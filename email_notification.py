import smtplib, ssl
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import boto3

client = boto3.client('ssm')
response = client.get_parameter(
    Name='Email_Cred',
    WithDecryption=True
)

global passwor, sender_emai
sender_emai = response['Parameter']['Value'].split('/')[0]
passwor = response['Parameter']['Value'].split('/')[1]

def email_service(DSO_mail_id,subject,body,name):
    sender_email = sender_emai
    sender_email = 'triper@gmail.com'
    receiver_email ='rjraman100@gmail.com'

    #from aws secret manager
    password = 9600047072

    message = MIMEMultipart("alternative")
    message["Subject"] = subject
    message["From"] = sender_email
    message["To"] = receiver_email

    text = """\
    <html>
    <head></head>
    <body>
        <p>Hi!<br>
        {}
        <br>
        {}
        <br>
        </p>
        <p>Regards<br>
        IEEE Team
        </p>
    </body>
    </html>
    """.format(name,body)

    part1 = MIMEText(text, "html")

    message.attach(part1)

    # Create secure connection with server and send email
    context = ssl.create_default_context()
    with smtplib.SMTP_SSL("smtp.gmail.com", 465, context=context) as server:
        server.login(sender_email, password)
        server.sendmail(
            sender_email, receiver_email, message.as_string()
        )