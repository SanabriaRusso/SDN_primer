FROM python:2.7-slim

WORKDIR /app

COPY requirements.txt testRest.py /app/

RUN pip install  --upgrade pip
RUN pip install --trusted-host pypi.python.org -r requirements.txt

EXPOSE 5200

CMD ["python", "testRest.py"]
