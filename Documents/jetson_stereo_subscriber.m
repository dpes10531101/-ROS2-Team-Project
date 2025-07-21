function stereo_image_subscriber()

setenv("ROS_DOMAIN_ID", "0");  % 確保 ROS 2 的網域 ID 與 Jetson 一樣

% 建立一個 ROS 2 節點，名稱為 matlab_stereo_node
    node = ros2node("/matlab_stereo_node");

    % 建立訂閱者，訂閱來自 Jetson 的影像主題
    % 主題名稱與 Jetson 上 Publisher 傳送的主題要一致
    % 記得這裡要根據實際主題名稱修改，例如：/stereo/left/image_raw
    sub = ros2subscriber(node, "/stereo/left/image_raw", "sensor_msgs/Image", @imageCallback);

    % 顯示狀態訊息
    disp("✅ MATLAB ROS 2 subscriber started. Waiting for images... MATLAB ROS 2 訂閱者已啟動，等待影像中...");
pause(inf);  % ⏸️ 持續等待影像
end

function imageCallback(msg)
    % 回呼函式（callback）：當接收到影像訊息時會自動執行此函數

    % 從 ROS 影像訊息中讀取影像資料，轉換成 MATLAB 支援的格式（uint8）
    img = rosReadImage(msg);  % 自動解析 BGR8 或 Mono8 格式影像

    % 顯示影像
    figure(1); clf;
    imshow(img);           % 在 MATLAB 視窗中顯示影像
    drawnow;               % 更新視窗內容
end
