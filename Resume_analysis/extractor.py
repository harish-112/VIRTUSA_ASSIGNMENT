import os
from pypdf import PdfReader

def extracttext(path):
     with open(path, 'r', encoding='utf-8') as f:
        return f.read()

def extractpdf(path):
        reader = PdfReader(path)
        text = ""
        for page in reader.pages:
            text += page.extract_text()
        return text

def extraction(path):    
    extension = os.path.splitext(path)[1].lower()
    
    if extension == '.pdf':
        return extractpdf(path)
    elif extension == '.txt':
        return extracttext(path)
    else:
        raise ValueError("System only supports PDF and TXT files for resume input.")
