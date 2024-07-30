from PyPDF2 import PdfReader
import pandas as pd

def extract_text_from_pdf(pdf_path):
    text = ''
    with open(pdf_path, 'rb') as file:
        pdf_reader = PdfReader(file)
        for page_num in range(len(pdf_reader.pages)):
            page = pdf_reader.pages[page_num]
            text += page.extract_text()
    return text

pdf_path=r'C:\Users\ingriq\Downloads\2023-13576.pdf'
pdf_text = extract_text_from_pdf(pdf_path)

# Assuming the text is tabular, split it into lines and then into columns
lines = pdf_text.split('\n')
data = [line.split('\t') for line in lines if line.strip()]

# Create a DataFrame from the extracted data
df = pd.DataFrame(data)

# Display the DataFrame
print(df)

# Export the DataFrame to an Excel file
excel_file_path = r'C:\Users\ingriq\Downloads\2023-13576.xlsx'
df.to_excel(excel_file_path, index=False)
print(f"DataFrame successfully exported to {excel_file_path}")