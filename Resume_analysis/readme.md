## Introduction

This project is a Resume Analysis System that compares a candidate's resume against a job description to identify skill matches and gaps. It uses a skill taxonomy database and natural language processing techniques to extract and analyze technical skills.

## Technologies & Concepts Used

- **Python** - Core language for automation and text processing
- **Natural Language Processing (NLP)** - Text cleaning, skill extraction using NLTK
- **File Handling** - PDF and TXT file parsing
- **Data Structures** - Lists, Sets for skill comparison and matching
- **JSON** - Skill taxonomy database management
- **Regular Expressions** - Pattern matching for text cleaning
- **Object-Oriented Programming** - Modular code structure

## Project Overview

The Resume Analysis System provides an automated way to evaluate how well a candidate's qualifications align with job requirements. It extracts skills from both resume and job description, performs matching analysis, and generates a comprehensive report.

## Features

1. **Multi-Format Support** - Extract text from both PDF and TXT files
2. **Skill Extraction** - Identify technical skills using a predefined skill taxonomy
3. **Smart Matching** - Compare resume skills with job description requirements
4. **Match Scoring** - Calculate a percentage match score based on skill alignment
5. **Detailed Reporting** - Generate reports showing:
   - Overall match percentage
   - Required skills from job description
   - Matched skills
   - Missing/Gap skills

## Files & Modules

- **main.py** - Entry point, orchestrates extraction, analysis, and report generation
- **extractor.py** - Handles file parsing (PDF and TXT formats)
- **analyzer.py** - Core analysis logic for skill extraction and matching
- **skill_taxonomy.json** - Database of skills organized by categories
- **resume.txt** - Sample resume file for analysis
- **job_description.txt** - Sample job description for comparison
- **analysis_report.txt** - Generated output report

## How It Works

1. **Extraction** - Reads resume and job description files
2. **Skill Detection** - Loads skill taxonomy and identifies skills in both documents
3. **Analysis** - Finds common skills (matches) and missing skills using set operations
4. **Scoring** - Calculates match percentage = (matched skills / required skills) × 100
5. **Report Generation** - Creates detailed analysis report with results

## How to Run

```bash
python main.py
```

The script will:
- Extract text from resume.txt and job_description.txt
- Perform skill analysis using skill_taxonomy.json
- Generate analysis_report.txt with results

## Sample Output

```
RESUME ANALYSIS REPORT

Overall Score: 75%

Job Description Skills:
 - Python
 - Java
 - SQL
 - ...

Skills Matched with Job Description:
 - Python
 - SQL
 - ...

Skills missing in your resume:
 - Java
 - Docker
 - ...
```

## Key Concepts Applied

- **Text Processing** - Extracting and cleaning text from various formats
- **Set Theory** - Using intersection and difference operations for skill matching
- **Data Validation** - Input validation and error handling for different file types
- **Modular Design** - Separation of concerns (extraction, analysis, reporting)
