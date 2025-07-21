nodeSubscriber = ros2node('NodeSubscriber');
%%
% First, let's check what topics are available
disp('Available topics:');
ros2 topic list;
%%
% Create the callback subscribers with specific callback functions for each topic
topicCallbackSubscriber1 = ros2subscriber(nodeSubscriber, ...
    '/Name', ...
    @nameCallback);

topicCallbackSubscriber2 = ros2subscriber(nodeSubscriber, ...
    '/Number', ...
    @numberCallback);

topicCallbackSubscriber3 = ros2subscriber(nodeSubscriber, ...
    '/Nationality', ...
    @nationalityCallback);
%%
% Individual callback functions for each topic
function nameCallback(message)
    disp(['Received Name: ', message.data]);
end    

function numberCallback(message)
    disp(['Received Number: ', num2str(message.data)]);
end

function nationalityCallback(message)
    disp(['Received Nationality: ', message.data]);
end

% Note: Don't include the clear commands here as they would immediately unsubscribe
% Keep this script running to maintain the subscriptions active
% To manually stop, use Ctrl+C or clear the specific subscriber variables