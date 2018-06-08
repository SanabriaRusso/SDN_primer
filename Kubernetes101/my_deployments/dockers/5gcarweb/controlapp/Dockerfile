FROM python:2.7-slim-jessie

WORKDIR /controlApp


COPY . /controlApp/

RUN pip install  -r requirements.txt

EXPOSE 8848

CMD ["python", "app.py"]

