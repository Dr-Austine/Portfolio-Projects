import csv
from faker import Faker
import random
from datetime import date, timedelta

# Initialize Faker
fake = Faker()

# Define the departments and positions
DEPARTMENTS = [
    "Media Directing",
    "Talent Management",
    "Sales & Marketing",
    "Operations",
    "Finance & Accounting",
    "Information Technology"
]

POSITIONS = [
    "Director",
    "Producer",
    "Sr. Cameraman",
    "Video Editor",
    "Sound Engineer",
    "Gaffer",
    "Accountant",
    "Financial Analyst",
    "Recruiter",
    "Marketing Manager",
    "IT Specialist",
    "Assistant",
    "Screenwriter",
    "Motion Graphics Designer",
    "Colorist"
]

# A list of nationalities to choose from, based on the provided data
NATIONALITIES = [
    "Saudi",
    "Tunisia",
    "Syrian",
    "Egyptian",
    "Iraqi",
    "Bahrain",
    "Emirati",
    "Kuwaiti"
]

# The headers for the CSV file
HEADERS = [
    "Staff ID", "Name", "Position", "Nationality", "Gender", "Section", "Department",
    "Per-Hourly Rate", "Per-200 Hrs. Rate", "Start", "End",
    "Hourly Rate 2", "Per 200 Hrs. Rate 2", "Start2", "End2",
    "Salary 5% & 10% reduction", "Total Budget Allocated",
    "Invoice January", "Actual January", "Jan Final Amount",
    "Invoice February", "Actual February", "Feb Final Amount",
    "Invoice March", "Actual March", "Mar Final Amount",
    "Invoice April", "Actual April", "Apr Final Amount",
    "Invoice May", "Actual May", "May Final Amount",
    "Invoice June", "Actual June", "Jun Final Amount",
    "Invoice July", "Actual July", "Jul Final Amount",
    "Invoice August", "Actual August", "Aug Final Amount",
    "Invoice September", "Actual September", "Sep Final Amount",
    "Invoice October", "Actual October", "Oct Final Amount",
    "Invoice November", "Actual November", "Nov Final Amount",
    "Invoice December", "Actual December", "Dec Final Amount"
]

def generate_employee_record(staff_id):
    """Generates a single fake employee record."""
    name = fake.name()
    gender = random.choice(["Male", "Female"])
    nationality = random.choice(NATIONALITIES)
    position = random.choice(POSITIONS)
    department = random.choice(DEPARTMENTS)
    
    # Assign department based on position to make it more realistic
    if "Cameraman" in position or "Director" in position or "Editor" in position or "Sound" in position or "Gaffer" in position:
        department = "Media Directing"
    elif "Producer" in position or "Assistant" in position:
        department = random.choice(["Media Directing", "Operations", "Sales & Marketing", "Talent Management"])
    elif "Accountant" in position or "Financial Analyst" in position:
        department = "Finance & Accounting"
    elif "Recruiter" in position:
        department = "Talent Management"
    elif "Marketing" in position:
        department = "Sales & Marketing"
    elif "IT" in position:
        department = "Information Technology"
    
    # Generate hourly rates
    hourly_rate = round(random.uniform(50, 150), 2)
    per_200_hrs_rate = hourly_rate * 200
    
    # Generate salary reduction
    salary_reduction_percent = random.choice([5, 10])
    hourly_rate_2 = hourly_rate * (1 - salary_reduction_percent / 100)
    per_200_hrs_rate_2 = hourly_rate_2 * 200
    
    # Generate start and end dates
    start_date = date(2025, 1, 1) + timedelta(days=random.randint(0, 60))
    end_date = date(2025, 6, 30) + timedelta(days=random.randint(0, 60))
    start_date_2 = date(2025, 3, 1) + timedelta(days=random.randint(0, 90))
    end_date_2 = date(2025, 12, 30) + timedelta(days=random.randint(0, 0))

    # Generate monthly invoice and actual hours
    monthly_data = []
    for _ in range(12):
        invoice_hours = random.randint(50, 300)
        actual_hours = random.randint(int(invoice_hours * 0.8), int(invoice_hours * 1.2))
        final_amount = round(actual_hours * hourly_rate, 2)
        monthly_data.extend([invoice_hours, actual_hours, final_amount])
        
    # Calculate total budget
    total_budget = sum(monthly_data[2::3]) # Sum every 3rd element starting from index 2

    return [
        staff_id, name, position, nationality, gender, "Section", department,
        f"${hourly_rate:.2f}", f"${per_200_hrs_rate:.2f}", start_date.strftime("%d-%b-%y"), end_date.strftime("%d-%b-%y"),
        f"${hourly_rate_2:.2f}", f"${per_200_hrs_rate_2:.2f}", start_date_2.strftime("%d-%b-%y"), end_date_2.strftime("%d-%b-%y"),
        f"{salary_reduction_percent}%", f"${total_budget:.2f}"
    ] + monthly_data

def generate_csv_file(filename, num_records):
    """Generates a CSV file with the specified number of fake records."""
    try:
        with open(filename, 'w', newline='') as csvfile:
            csv_writer = csv.writer(csvfile)
            
            # Write the headers
            csv_writer.writerow(HEADERS)
            
            # Write the records
            for i in range(1, num_records + 1):
                record = generate_employee_record(i)
                csv_writer.writerow(record)
        print(f"Successfully generated {num_records} records in '{filename}'.")
    except Exception as e:
        print(f"An error occurred: {e}")

# Generate the CSV file with 1500 records
if __name__ == '__main__':
    generate_csv_file('media_company_data.csv', 1500)
