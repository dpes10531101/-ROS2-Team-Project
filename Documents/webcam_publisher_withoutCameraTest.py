import rclpy
from rclpy.node import Node
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
import cv2
import numpy as np

class WebcamPublisher(Node):
    def __init__(self):
        self._print_progress("🔧 初始化 WebcamPublisher 節點")
        super().__init__('webcam_publisher')

        self._print_progress("📡 建立 Publisher")
        self.publisher_ = self.create_publisher(Image, 'camera/image_raw', 10)

        self._print_progress("🔄 建立 CvBridge")
        self.bridge = CvBridge()

        self._print_progress("⏱️ 設定 Timer，每 0.5 秒發送一張影像")
        self.timer = self.create_timer(0.5, self.timer_callback)

        self.get_logger().info("✅ WebcamPublisher 已啟動並準備發送模擬影像")

    def timer_callback(self):
        self.get_logger().info("🖼️ 建立一張模擬影像（黑底）")
        dummy_frame = np.zeros((480, 640, 3), dtype=np.uint8)

        self.get_logger().info("📦 轉換成 ROS Image 訊息格式")
        msg = self.bridge.cv2_to_imgmsg(dummy_frame, encoding='bgr8')

        self.get_logger().info("📤 發送影像中...")
        self.publisher_.publish(msg)

    def destroy_node(self):
        self.get_logger().info("🛑 結束節點，釋放資源")
        super().destroy_node()

    def _print_progress(self, message):
        print(f"[WebcamPublisher 設定] {message}")

def main(args=None):
    print("🚀 啟動 ROS 2 節點")
    rclpy.init(args=args)
    node = WebcamPublisher()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        print("🧹 偵測到 Ctrl+C，準備關閉")
    node.destroy_node()
    rclpy.shutdown()
    print("✅ 程式關閉完成")
