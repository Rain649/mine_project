#include "rclcpp/rclcpp.hpp"

class Talker : public rclcpp::Node
{
public:
    Talker() : Node("talker_node")
    {
        timer_ = this->create_wall_timer(
            std::chrono::seconds(1),
            std::bind(&Talker::timer_callback, this));
    }

private:
    void timer_callback()
    {
        RCLCPP_INFO(this->get_logger(), "Hello ROS2 Docker");
    }

    rclcpp::TimerBase::SharedPtr timer_;
};

int main(int argc, char *argv[])
{
    rclcpp::init(argc, argv);
    rclcpp::spin(std::make_shared<Talker>());
    rclcpp::shutdown();
    return 0;
}

