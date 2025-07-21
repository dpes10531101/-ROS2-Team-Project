import cv2
import zmq
import base64

# 開啟 webcam
cap = cv2.VideoCapture(0)
if not cap.isOpened():
    print("❌ 無法開啟攝影機")
    exit()

# 設定 ZeroMQ publisher
context = zmq.Context()
socket = context.socket(zmq.PUB)
socket.bind("tcp://*:5555")  # 你可以改成固定 IP，也可以 localhost

print("📡 Webcam publisher 啟動中，正在發送影像...")

while True:
    ret, frame = cap.read()
    if not ret:
        print("⚠️ 讀取攝影機失敗")
        break

    # 編碼成 jpg 並轉成 base64 字串
    _, buffer = cv2.imencode('.jpg', frame)
    jpg_bytes = base64.b64encode(buffer)
    socket.send(jpg_bytes)

    cv2.waitKey(100)  # 每秒 10 張
