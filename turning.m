%{
GROUP 4 PROJECT SPYN CODE
Kiran Gershenfeld
Zi Jia Tan
Bennett Scott
Ritvik Ramdas
%}

%VARIABLE INITIALIZATION
brick.SetColorMode(1, 2);
global key;
InitKeyboard();
autoDrive = false;
lock180 = false;
passengerEntered = false;

%Continous Loop
while 1
    %--VARIABLE UPDATING--
    distance = brick.UltrasonicDist(3);    
    buttonPressed = brick.TouchPressed(2);
    color = brick.ColorCode(1);
    
    %--KEYBOARD COMMANDS--
    pause (.01);
    switch key
        case 'd'
            autoDrive = true;
        case 's'
            autoDrive = false;
            brick.StopMotor('ABCD');
        case 'uparrow'
            brick.MoveMotor('DB', -50);
        case 'downarrow'
            brick.MoveMotor('DB', 50);
        case 'leftarrow'
            brick.MoveMotor('D', -40);
        case 'rightarrow'
            brick.MoveMotor('B', -40);
        case 'p'
            brick.MoveMotor('A', -15);
        case 'o'
            brick.MoveMotor('A', 15);
        case 'q'
           brick.StopMotor('BD');
           break;
        case 0   
            %If not autmatic driving, stop all motors unless a button is
            %being pushed
            if(autoDrive == false)
                brick.StopMotor('ABCD');
            end
    end
    
    %--AUTOMATIC DRIVING BEHAVIOR--
      
    %If automatic driving is on, move forward slowly
    if(autoDrive == true)
        brick.MoveMotor('BD', -50);
    end
    
    %If front facing button is pressed, turn 90 degrees to the left
    if(buttonPressed == 1 && autoDrive == true)
        %Stop
        autoDrive = false;
        brick.StopMotor('BD');
        %Backup
        brick.MoveMotor('BD', 50);
        pause(.4);
        brick.StopMotor('BD');
        %Turn 90 degrees left
        brick.MoveMotor('D', -50);
        pause(1.1);
        brick.StopMotor('D');
        %Return to driving
        autoDrive = true;
    end
  
    %If the car is too close to a wall, increase the right motor speed to
    %turn away
    if (distance < 4 && autoDrive == true) %Nudge too close 
        brick.MoveMotor('D', -60); 
        lock180 = false;
        
    %If the car is too far away from a wall, increase the left motor speed
    %to turn closer
    elseif (distance > 8  && distance < 30 && autoDrive == true) %Nudge too far
        brick.MoveMotor('B', -65);
        lock180 = false;
        
    %If the car does not sense a wall, intiate a 2 part 180 degree turn
    elseif (distance > 30 && distance < 200 && autoDrive == true && lock180 == false)
        disp(distance);
        %Stop other processes
        lock180 = true;
        autoDrive = false;
        disp("180");
   
        %Begin turning 180 degrees
        brick.MoveMotor('D', -35);
        brick.MoveMotor('B', -200);
        pause(.25);
        brick.StopMotor('DB');
        pause(1.2);
        disp("color" + color);
        color = brick.ColorCode(1);
        if( color == 5)
            disp("mid turn color is red");
            brick.StopMotor('DB');
            pause(5);
            brick.MoveMotor('DB', -50); %Move forward a little
            pause(.25);
        end
        %----
       brick.MoveMotor('D', -35);
        brick.MoveMotor('B', -200);
        pause(.25);
        brick.StopMotor('DB');
        pause(1.2);
        disp("color" + color);
        color = brick.ColorCode(1);
        if( color == 5)
            disp("mid turn color is red");
            brick.StopMotor('DB');
            pause(5);
            brick.MoveMotor('DB', -50); %Move forward a little
            pause(.25);
        end
        %----
        brick.MoveMotor('D', -35);
        brick.MoveMotor('B', -200);
        pause(.25);
        brick.StopMotor('DB');
        pause(1.2);
        disp("color" + color);
        color = brick.ColorCode(1);
        if( color == 5)
            disp("mid turn color is red");
            brick.StopMotor('DB');
            pause(5);
            brick.MoveMotor('DB', -50); %Move forward a little
            pause(.25);
        end
        %----
        brick.MoveMotor('D', -35);
        brick.MoveMotor('B', -200);
        pause(.6);
        brick.StopMotor('DB');
        pause(.3);
        disp("color" + color);
        color = brick.ColorCode(1);
        if(color == 5)
            disp("mid turn color is red");
            brick.StopMotor('DB');
            pause(5);
            brick.MoveMotor('DB', -50); %Move forward a little
            pause(.25);
        end
        %----
        brick.MoveMotor('D', -35);
        brick.MoveMotor('B', -200);
        pause(.6);
        brick.StopMotor('DB');
        pause(.3);
        disp("color" + color);
        color = brick.ColorCode(1);
        if( color == 5)
            disp("mid turn color is red");
            brick.StopMotor('DB');
            pause(5);
            brick.MoveMotor('DB', -50); %Move forward a little
            pause(.25);
        end
        %----
        
        %Return to normal driving
        autoDrive = true;
    end
    
    %--COLOR SENSING BEHAVIOR--
    
    %If color is red, stop for 5 seconds, then move forward a little
    if color ==  5
        disp("color is red");
        brick.StopMotor('DB');
        pause(5);
        brick.MoveMotor('DB', -50); %Move forward a little
        pause(.5);
        lock180 = false;
    %If color is blue, switch to manual control
    elseif color==2
        autoDrive = false;
        passengerEntered = true;
        brick.StopMotor('BD');
    %If color is green and passenger is in the car, switch to manual
    %control
    elseif (color == 3 && passengerEntered == true)
        autoDrive = false;
        brick.StopMotor('BD');
    end
end
CloseKeyboard();
