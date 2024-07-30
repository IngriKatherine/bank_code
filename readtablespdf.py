import camelot
import pandas as pd

# Path to the PDF file
pdf_path=r'C:\Users\ingriq\Downloads\Guyana\A_reports\2017.pdf'

try:
    # Extract tables from page 1 of the PDF
    tables = camelot.read_pdf(pdf_path, flavor='stream', pages='141', strip_text='\n', split_text=True)
    
    # Save each table as a separate CSV file
    for idx, table in enumerate(tables, start=0):
        # Use the first row as the header
        header = table.df.iloc[0].tolist()
        table.df = table.df[1:]
        table.df.columns = header
        table.to_csv(f"C:/Users/ingriq/Downloads/table_{idx}.csv", index=False)
except Exception as e:
    print(f"Error: {e}")
