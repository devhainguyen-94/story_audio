# Sử dụng Python base image
FROM python:3.10-slim

# Thiết lập thư mục làm việc
WORKDIR /app

# Sao chép requirements.txt và cài đặt dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Sao chép toàn bộ code vào container
COPY . /app/

# Thiết lập biến môi trường
ENV PYTHONUNBUFFERED=1

# Chạy các lệnh cần thiết (collectstatic, migrate)
# RUN python manage.py collectstatic --noinput
RUN python manage.py migrate

# Expose cổng mặc định
EXPOSE 8000

# Chạy ứng dụng
CMD ["gunicorn", "myproject.wsgi:application", "--bind", "0.0.0.0:8000"]