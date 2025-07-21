import rclpy
from rclpy.node import Node
from std_msgs.msg import String

class HalloPublisher(Node):
    def __init__(self):
        super().__init__('hallo_publisher')
        self.publisher_ = self.create_publisher(String, 'hallo_topic', 10)
        self.timer = self.create_timer(0.5, self.timer_callback)
        self.get_logger().info("✅ HalloPublisher 啟動成功")

    def timer_callback(self):
        msg = String()
        msg.data = "Hallo"
        self.publisher_.publish(msg)
        self.get_logger().info(f"📤 發送: {msg.data}")

def main(args=None):
    rclpy.init(args=args)
    node = HalloPublisher()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()
