import re
import json
import nltk
from nltk.corpus import stopwords

nltk.download('stopwords')
STOP_WORDS = set(stopwords.words('english'))

def loadskills(file_path):
    f = open(file_path, 'r')
    data = json.load(f)
    f.close()

    skills = []
    for category in data:
        for s in data[category]:
            skills.append(s.lower())
    return skills

def clean_text(text):
    text = text.lower()
    text = re.sub(r'[^a-zA-Z\s]', ' ', text)
    return text

def extractskills(text, skill_list):
    cleaned = clean_text(text)
    found = []
    
    for skill in skill_list:
        if f" {skill} " in f" {cleaned} ": 
            if skill not in found:
                found.append(skill)
    return set(found)

def analysis(restxt, jdtxt, skill_db):
    all_skills = loadskills(skill_db)
    resume_skills = extractskills(restxt, all_skills)
    jd_skills = extractskills(jdtxt, all_skills)
    
    matched = resume_skills.intersection(jd_skills) # to find common skills between resume and JD
    
    if len(jd_skills) == 0:
        score = 0
    else:
        score = (len(matched) / len(jd_skills)) * 100
        
    missing = []
    for item in jd_skills:
        if item not in resume_skills:
            missing.append(item)
            
    results = {
        'jd_skills': list(jd_skills),
        'match_score': score,
        'missing_skills': missing,
        'matched_skills': list(matched)
    }
    return results

