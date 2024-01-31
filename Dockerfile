FROM python:2.7.18-slim-stretch

# if you need to use a pip proxy, you can set it here:
# RUN pip config set global.index-url https://mirrors.ustc.edu.cn/pypi/web/simple
RUN pip install Twisted==20.3.0