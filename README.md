# Talent Acquisition Analytics Dashboard

An end-to-end recruitment analytics project developed using **Microsoft Excel, SQL, and Power BI** to analyse candidate selection, hiring-stage drop-offs, rejection reasons, recruitment strategies, and candidate performance.

## Project Summary

Recruitment teams often receive large numbers of applications but may struggle to understand:

- Where candidates are eliminated during the hiring process
- Which rejection reasons occur most frequently
- How recruitment strategies are distributed
- How candidate scores relate to selection outcomes
- How effectively the hiring process converts applicants into selected candidates

This project analyses **1,498 candidate records** and presents the results through SQL analysis and an interactive Power BI dashboard.

## KPI Snapshot

| KPI | Result |
|---|---:|
| Total Applicants | 1,498 |
| Candidates Selected | 520 |
| Average Resume Score | 58.6 |
| Selection Rate | Approximately 34.69% |

## Business Problem

Organisations need a structured way to monitor recruitment performance and identify inefficiencies in the candidate-selection process.

Without recruitment analytics, decision-makers may find it difficult to:

- Track candidate progression across hiring stages
- Identify major candidate drop-off points
- Understand common rejection reasons
- Compare recruitment strategies
- Evaluate candidate quality
- Monitor overall selection performance

The objective of this project was to transform recruitment data into clear KPIs, interactive visualisations, and actionable hiring insights.

## Tools Used

| Tool | Purpose |
|---|---|
| **Microsoft Excel** | Data cleaning, preparation, and validation |
| **SQL** | Data exploration, KPI calculation, segmentation, and recruitment analysis |
| **Power BI** | Data modelling, interactive dashboard creation, slicers, and visualisation |

## Dataset

The cleaned dataset contains **1,498 candidate records**.

Important fields include:

- Age
- Gender
- Education Level
- Experience Years
- Previous Companies
- Distance From Company
- Resume Score
- Technical Score
- Interview Score
- Skill Score
- Personality Score
- Communication Score
- Recruitment Strategy
- Hiring Decision
- Current Stage
- Final Status
- Drop Stage
- Drop Reason
- Screening Date
- Interview Date
- HR Date

## Data Preparation

The dataset was prepared using Excel and SQL through the following steps:

- Reviewed missing and blank values
- Checked recruitment-strategy records
- Standardised data formats
- Validated candidate-status fields
- Reviewed score columns
- Prepared stage and rejection categories
- Validated KPI totals
- Created candidate-performance classifications

For the final hiring outcome, the analysis uses the `FinalStatus` field.

## Analysis Workflow

1. Collected and reviewed recruitment data
2. Cleaned and validated the dataset in Excel
3. Loaded the cleaned data into SQL
4. Calculated recruitment KPIs
5. Analysed candidate drop-offs and rejection reasons
6. Compared recruitment strategies
7. Evaluated candidate scores and performance groups
8. Built an interactive Power BI dashboard
9. Developed recruitment insights and recommendations

## Dashboard Preview

### Main Dashboard

![Talent Acquisition Analytics Dashboard](Power%20BI/Dashboard.png)

### Custom Tooltip

![Talent Acquisition Dashboard Tooltip](Power%20BI/Tooltip.png)

## Dashboard Features

The Power BI dashboard includes:

- Total Applicants
- Candidates Selected
- Average Resume Score
- Selection Rate
- Candidate hiring-stage analysis
- Candidate drop-off analysis
- Rejection-reason analysis
- Applicants by Recruitment Strategy
- High-performer analysis
- Gender filter
- Education Level filter
- Recruitment Strategy filter
- Performance Category filter
- Interactive tooltip
- Candidate-level detail page

## Metric Definitions

### Selected Candidate

A candidate is classified as selected when:

```text
FinalStatus = "Selected"
```

### Selection Rate

Selection Rate is calculated as:

```text
Selected Candidates ÷ Total Applicants
```

### High Performer

For this project, a candidate is classified as a high performer when:

```text
Resume Score ≥ 70
AND
Technical Score ≥ 70
```

### Candidate Drop-Off

Candidate drop-off is measured using the stage recorded in the `DropStage` field for rejected candidates.

This represents the stage at which a candidate was eliminated, rather than a complete sequential recruitment funnel.

## Key Business Insights

- The dataset contains **1,498 applicants**, of whom **520 were selected**.
- The overall selection rate is approximately **34.7%**.
- Candidate screening represents the largest hiring-stage drop-off.
- Low Resume Score is the most frequently recorded rejection reason.
- Weak Technical Skills and Poor Communication are also important rejection categories.
- The Moderate recruitment strategy was applied to the largest number of candidates.
- Candidate performance can be compared using resume, technical, interview, personality, communication, and skill scores.
- Recruitment performance should be evaluated using both candidate counts and selection rates.

## Business Recommendations

### Improve initial screening criteria

Review the resume-screening process to ensure candidates are assessed using clear and consistent criteria.

### Strengthen candidate-quality sourcing

Focus recruitment campaigns on channels that attract candidates with stronger resume and technical profiles.

### Improve technical-assessment support

Review technical-assessment requirements and identify whether job descriptions clearly communicate the expected technical skills.

### Monitor communication-related rejection

Analyse roles with high communication-related rejection rates and ensure communication expectations are defined before interviews.

### Compare strategy selection rates

Do not evaluate recruitment strategies only by the number of applicants or selected candidates. Compare the percentage of candidates selected under each strategy.

### Track stage-wise drop-offs

Monitor candidate eliminations at Screening, Interview 1, Interview 2, and HR stages to identify process bottlenecks.

### Validate recruitment KPIs regularly

Use consistent definitions for Total Applicants, Selected Candidates, Final Status, and Selection Rate across SQL and Power BI.

## SQL Analysis

The SQL file includes analysis for:

- Data-quality checks
- Total applicants
- Selected and rejected candidates
- Average resume score
- Selection rate
- Final-status distribution
- Candidate drop-off by stage
- Rejection reasons
- Recruitment-strategy performance
- High-performer analysis
- Interview-score analysis
- Personality-score analysis
- Technical-score analysis
- Communication-score analysis
- Distance-from-company analysis

## Repository Structure

```text
Talent-Acquisition-Analytics-Dashboard/
│
├── Power BI/
│   ├── Dashboard.png
│   ├── Tooltip.png
│   └── Talent_Acquisition_Analytics_Dashboard.pbix
│
├── data/
│   ├── recruitment_mydata.csv
│   └── Recruitment_Dataset.xlsx
│
├── sql/
│   └── SQL_Queries.sql
│
└── README.md
```

## Skills Demonstrated

- Recruitment Analytics
- Talent Acquisition Analytics
- SQL Data Analysis
- Microsoft Excel
- Power BI
- Data Cleaning
- Data Validation
- Data Aggregation
- KPI Calculation
- Candidate Segmentation
- Hiring-Stage Analysis
- Rejection-Reason Analysis
- Recruitment-Strategy Analysis
- Dashboard Development
- Data Visualisation
- Business Insight Generation
- Business Recommendation Development

## Project Outcome

This project demonstrates how recruitment data can be transformed into a structured hiring-performance dashboard. It enables users to monitor recruitment KPIs, examine candidate drop-offs, understand rejection patterns, compare recruitment strategies, and evaluate candidate-performance indicators.
The dashboard supports more informed and data-driven recruitment decisions while highlighting areas where the hiring process may require further investigation.


📄 License

This project is licensed under the MIT License — feel free to use, modify, and share with attribution.



👤 Author

[MahindraboopathiS]

📧 [mahindraboopathis@gmail.com]

🔗 [linkedin.com/in/mahindraboopathis]