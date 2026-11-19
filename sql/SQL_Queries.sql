-- ============================================================
-- TALENT ACQUISITION ANALYTICS
-- Tools: SQL, Excel, Power BI
--
-- FinalStatus is used as the final hiring outcome.
-- High Performer definition:
-- ResumeScore >= 70 AND TechnicalScore >= 70
-- ============================================================


-- 1. DATA PREVIEW

SELECT *
FROM candidates
LIMIT 10;


-- 2. DATA QUALITY SUMMARY

SELECT
    COUNT(*) AS total_records,

    SUM(
        CASE
            WHEN Age IS NULL THEN 1
            ELSE 0
        END
    ) AS missing_age,

    SUM(
        CASE
            WHEN EducationLevel IS NULL
                 OR TRIM(EducationLevel) = ''
            THEN 1
            ELSE 0
        END
    ) AS missing_education_level,

    SUM(
        CASE
            WHEN RecruitmentStrategy IS NULL
                 OR TRIM(RecruitmentStrategy) = ''
            THEN 1
            ELSE 0
        END
    ) AS missing_recruitment_strategy,

    SUM(
        CASE
            WHEN FinalStatus IS NULL
                 OR TRIM(FinalStatus) = ''
            THEN 1
            ELSE 0
        END
    ) AS missing_final_status

FROM candidates;


-- 3. OVERALL RECRUITMENT KPIs

SELECT
    COUNT(*) AS total_applicants,

    SUM(
        CASE
            WHEN FinalStatus = 'Selected' THEN 1
            ELSE 0
        END
    ) AS selected_candidates,

    SUM(
        CASE
            WHEN FinalStatus = 'Rejected' THEN 1
            ELSE 0
        END
    ) AS rejected_candidates,

    ROUND(AVG(ResumeScore), 2) AS average_resume_score,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN FinalStatus = 'Selected' THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS selection_rate_percentage

FROM candidates;


-- 4. FINAL STATUS DISTRIBUTION

SELECT
    FinalStatus,
    COUNT(*) AS total_candidates,

    ROUND(
        COUNT(*) * 100.0 /
        NULLIF((SELECT COUNT(*) FROM candidates), 0),
        2
    ) AS percentage_of_applicants

FROM candidates
GROUP BY FinalStatus
ORDER BY total_candidates DESC;


-- 5. STATUS CONSISTENCY CHECK
-- This identifies cases where HiringDecision and FinalStatus
-- do not communicate the same outcome.

SELECT
    HiringDecision,
    FinalStatus,
    COUNT(*) AS total_candidates

FROM candidates
GROUP BY
    HiringDecision,
    FinalStatus
ORDER BY
    FinalStatus,
    HiringDecision;


-- 6. CURRENT STAGE AND FINAL STATUS CHECK

SELECT
    CurrentStage,
    FinalStatus,
    DropStage,
    COUNT(*) AS total_candidates

FROM candidates
GROUP BY
    CurrentStage,
    FinalStatus,
    DropStage
ORDER BY
    FinalStatus,
    total_candidates DESC;


-- 7. CANDIDATE DROP-OFF BY HIRING STAGE
-- This is a drop-off analysis, not a progression funnel.

SELECT
    DropStage,
    COUNT(*) AS dropped_candidates,

    ROUND(
        COUNT(*) * 100.0 /
        NULLIF(
            (
                SELECT COUNT(*)
                FROM candidates
                WHERE FinalStatus = 'Rejected'
                  AND DropStage IS NOT NULL
                  AND DropStage <> 'None'
            ),
            0
        ),
        2
    ) AS share_of_rejected_candidates

FROM candidates
WHERE FinalStatus = 'Rejected'
  AND DropStage IS NOT NULL
  AND DropStage <> 'None'

GROUP BY DropStage
ORDER BY dropped_candidates DESC;


-- 8. REJECTION REASON ANALYSIS

SELECT
    DropReason,
    COUNT(*) AS rejected_candidates,

    ROUND(
        COUNT(*) * 100.0 /
        NULLIF(
            (
                SELECT COUNT(*)
                FROM candidates
                WHERE FinalStatus = 'Rejected'
                  AND DropReason IS NOT NULL
                  AND DropReason <> 'N/A'
            ),
            0
        ),
        2
    ) AS share_of_rejections

FROM candidates
WHERE FinalStatus = 'Rejected'
  AND DropReason IS NOT NULL
  AND DropReason <> 'N/A'

GROUP BY DropReason
ORDER BY rejected_candidates DESC;


-- 9. RECRUITMENT STRATEGY PERFORMANCE
-- Selection rate is used to compare strategy effectiveness.
-- Selected count alone should not be used to declare the best strategy.

SELECT
    RecruitmentStrategy,
    COUNT(*) AS total_applicants,

    SUM(
        CASE
            WHEN FinalStatus = 'Selected' THEN 1
            ELSE 0
        END
    ) AS selected_candidates,

    SUM(
        CASE
            WHEN FinalStatus = 'Rejected' THEN 1
            ELSE 0
        END
    ) AS rejected_candidates,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN FinalStatus = 'Selected' THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS selection_rate_percentage

FROM candidates
WHERE RecruitmentStrategy IS NOT NULL
  AND TRIM(RecruitmentStrategy) <> ''

GROUP BY RecruitmentStrategy
ORDER BY
    selection_rate_percentage DESC,
    selected_candidates DESC;


-- 10. HIGH-PERFORMER SELECTION ANALYSIS
-- High Performer:
-- ResumeScore >= 70 AND TechnicalScore >= 70

WITH performance_groups AS
(
    SELECT
        CASE
            WHEN ResumeScore >= 70
             AND TechnicalScore >= 70
            THEN 'High Performer'
            ELSE 'Other Candidates'
        END AS performance_group,

        FinalStatus

    FROM candidates
)

SELECT
    performance_group,
    COUNT(*) AS total_candidates,

    SUM(
        CASE
            WHEN FinalStatus = 'Selected' THEN 1
            ELSE 0
        END
    ) AS selected_candidates,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN FinalStatus = 'Selected' THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS group_selection_rate,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN FinalStatus = 'Selected' THEN 1
                ELSE 0
            END
        ) /
        NULLIF(
            (
                SELECT COUNT(*)
                FROM candidates
                WHERE FinalStatus = 'Selected'
            ),
            0
        ),
        2
    ) AS share_of_all_selected_candidates

FROM performance_groups
GROUP BY performance_group
ORDER BY selected_candidates DESC;


-- 11. INTERVIEW SCORE VS SELECTION
-- This correctly uses InterviewScore.
-- The earlier query incorrectly used PersonalityScore.

WITH interview_score_groups AS
(
    SELECT
        CASE
            WHEN InterviewScore >= 70 THEN 'High'
            WHEN InterviewScore >= 50 THEN 'Medium'
            ELSE 'Low'
        END AS interview_score_level,

        FinalStatus

    FROM candidates
)

SELECT
    interview_score_level,
    COUNT(*) AS total_candidates,

    SUM(
        CASE
            WHEN FinalStatus = 'Selected' THEN 1
            ELSE 0
        END
    ) AS selected_candidates,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN FinalStatus = 'Selected' THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS selection_rate_percentage

FROM interview_score_groups
GROUP BY interview_score_level
ORDER BY
    CASE interview_score_level
        WHEN 'High' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'Low' THEN 3
    END;


-- 12. PERSONALITY SCORE VS SELECTION

WITH personality_score_groups AS
(
    SELECT
        CASE
            WHEN PersonalityScore >= 70 THEN 'High'
            WHEN PersonalityScore >= 50 THEN 'Medium'
            ELSE 'Low'
        END AS personality_score_level,

        FinalStatus

    FROM candidates
)

SELECT
    personality_score_level,
    COUNT(*) AS total_candidates,

    SUM(
        CASE
            WHEN FinalStatus = 'Selected' THEN 1
            ELSE 0
        END
    ) AS selected_candidates,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN FinalStatus = 'Selected' THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS selection_rate_percentage

FROM personality_score_groups
GROUP BY personality_score_level
ORDER BY
    CASE personality_score_level
        WHEN 'High' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'Low' THEN 3
    END;


-- 13. DISTANCE FROM COMPANY VS SELECTION

WITH distance_groups AS
(
    SELECT
        CASE
            WHEN DistanceFromCompany < 10 THEN 'Near'
            WHEN DistanceFromCompany BETWEEN 10 AND 30 THEN 'Medium'
            ELSE 'Far'
        END AS distance_group,

        FinalStatus

    FROM candidates
)

SELECT
    distance_group,
    COUNT(*) AS total_candidates,

    SUM(
        CASE
            WHEN FinalStatus = 'Selected' THEN 1
            ELSE 0
        END
    ) AS selected_candidates,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN FinalStatus = 'Selected' THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS selection_rate_percentage

FROM distance_groups
GROUP BY distance_group
ORDER BY
    CASE distance_group
        WHEN 'Near' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'Far' THEN 3
    END;


-- 14. TECHNICAL SCORE VS SELECTION

WITH technical_score_groups AS
(
    SELECT
        CASE
            WHEN TechnicalScore >= 70 THEN 'High'
            WHEN TechnicalScore >= 50 THEN 'Medium'
            ELSE 'Low'
        END AS technical_score_level,

        FinalStatus

    FROM candidates
)

SELECT
    technical_score_level,
    COUNT(*) AS total_candidates,

    SUM(
        CASE
            WHEN FinalStatus = 'Selected' THEN 1
            ELSE 0
        END
    ) AS selected_candidates,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN FinalStatus = 'Selected' THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS selection_rate_percentage

FROM technical_score_groups
GROUP BY technical_score_level
ORDER BY
    CASE technical_score_level
        WHEN 'High' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'Low' THEN 3
    END;


-- 15. COMMUNICATION SCORE VS SELECTION

WITH communication_score_groups AS
(
    SELECT
        CASE
            WHEN CommunicationScore >= 70 THEN 'High'
            WHEN CommunicationScore >= 50 THEN 'Medium'
            ELSE 'Low'
        END AS communication_score_level,

        FinalStatus

    FROM candidates
)

SELECT
    communication_score_level,
    COUNT(*) AS total_candidates,

    SUM(
        CASE
            WHEN FinalStatus = 'Selected' THEN 1
            ELSE 0
        END
    ) AS selected_candidates,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN FinalStatus = 'Selected' THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS selection_rate_percentage

FROM communication_score_groups
GROUP BY communication_score_level
ORDER BY
    CASE communication_score_level
        WHEN 'High' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'Low' THEN 3
    END;
