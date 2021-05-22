FROM python:3.9.5

RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple/

COPY C189Checkin.py ./

ENV USERNAME USERNAME

ENV PASSWORD PASSWORD

CMD [ "python", "./C189Checkin.py" ]
