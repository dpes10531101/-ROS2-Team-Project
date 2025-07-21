nodePublisher = ros2node('NodePublisher');
%%
topicPublisher1 = ros2publisher(nodePublisher, ...
    '/Name', ...
    'example_interfaces/String');

topicPublisher2 = ros2publisher(nodePublisher, ...
    '/Number', ...
    'example_interfaces/Int32');

topicPublisher3 = ros2publisher(nodePublisher, ...
    '/Nationality', ...
    'example_interfaces/String');
%%
topicMessage1 = ros2message(topicPublisher1);
topicMessage2 = ros2message(topicPublisher2);
topicMessage3 = ros2message(topicPublisher3);

topicMessage1.data = 'Keshav Sundar Venkateswaran';
topicMessage2.data = int32(772077);  % Fixed: Using numeric value directly
topicMessage3.data = 'Indian';
%%
% Display available topics
disp('Available topics:');
ros2 topic list;
%%
ratePublisher = ros2rate(nodePublisher, 1);
%%
reset(ratePublisher);
% Increased number of messages to 5 for better testing
for i = 1:1
    send(topicPublisher1, topicMessage1);
    send(topicPublisher2, topicMessage2);
    send(topicPublisher3, topicMessage3);
    disp([num2str(i), ' Published ' , topicMessage1.data]);
    disp([num2str(i), ' Published ' , num2str(topicMessage2.data)]);
    disp([num2str(i), ' Published ' , topicMessage3.data]);
    waitfor(ratePublisher);
end