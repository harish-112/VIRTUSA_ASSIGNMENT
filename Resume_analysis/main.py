import os
from extractor import extraction, extracttext
from analyzer import analysis

def reportgeneration(analysis_result, output_file):
    
    report = []
    report.append("RESUME ANALYSIS REPORT\n")
    
    score = int(analysis_result['match_score'])
    report.append(f"\nOverall Score: {score}%")

    jd_skills = sorted(analysis_result['jd_skills'])
    report.append(str(\nJob Description Skills :\n))
    for skill in jd_skills:
        report.append(" - "+str(skill))
    
    matched_skills = sorted(analysis_result['matched_skills'])
    report.append(str(\n\nSkills Matched with Job Description :))
    if matched_skills:
        for skill in matched_skills:
            report.append(" - "+str(skill))

    missing_skills = sorted(analysis_result['missing_skills'])
    report.append(str(\n\nSkills missing in your resume:))
    if missing_skills:
        for skill in missing_skills:
            report.append(" - "+str(skill))
    else:
        report.append(" Your Resume looks great! All skills matched with the Job Description.")
    

    report_text = "\n".join(report)

    with open(output_file, 'w') as f:
        f.write(report_text)
    return report_text

def main():
    resume_file = "resume.txt"
    jd_file = "job_description.txt"
    skill_taxonomy = "skill_taxonomy.json"
    outputfile = "analysis_report.txt"
    
    try:
        resume_text = extraction(resume_file)
        jd_text = extraction(jd_file)
        analysis_result = analysis(resume_text, jd_text, skill_taxonomy)
        report = reportgeneration(analysis_result, outputfile) 
        print(f"\nReport saved to: {outputfile}")
    except Exception as e:
        print(e)

if __name__ == "__main__":
    main()
