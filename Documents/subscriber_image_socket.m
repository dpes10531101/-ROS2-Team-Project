% 使用 ZeroMQ 接收來自 Python 的 webcam 圖像
context = zmq.core.ctx_new();
sub = zmq.core.socket(context, 'ZMQ_SUB');
zmq.core.connect(sub, 'tcp://localhost:5555');
zmq.core.setsockopt(sub, 'ZMQ_SUBSCRIBE', '');

disp('📥 MATLAB 開始接收 webcam 圖像');

while true
    msg = zmq.core.recv(sub);
    imgData = uint8(base64decode(char(msg)));
    img = imdecode(imgData, 'jpg');
    imshow(img);
    drawnow;
end
