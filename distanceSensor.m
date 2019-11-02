%brick.StopMotor('BD');
distanjceSensorPort = 3;
lockClose = true;
lockFar = true;
global key;
InitKeyboard();
while 1
    pause(0.1);
    switch key
        case 'o'
            brick.MoveMotor('A', 15);
        case 'q'
           brick.StopMotor('BD');
           break;
        case 0
            
    end
    
    distance = brick.UltrasonicDist(3);
    buttonPressed = brick.TouchPressed(2);
    
    
    if(buttonPressed == 1)
        brick.StopMotor('BD');
        brick.MoveMotor('BD', 50);
        pause(.75);
        brick.MoveMotorAngleRel('D',50, -180,'Brake');
         pause(.75);
    elseif (buttonPressed == 0)

    brick.MoveMotor('DB', -100);
        if distance < 4 && lockClose == true%%Nudge left if too close
            brick.MoveMotorAngleRel('B',25,-2,'Brake');
            lockClose = false;
            lockFar = true;
            disp("Too close: correcting");
        elseif distance > 9  && distance < 20  && lockFar == true%%Nudge left if too far
            brick.MoveMotorAngleRel('D',25,-2,'Brake');
            lockFar = false;
            lockClose = true;
            disp("Too far: correcting");
        %elseif distance > 27 %%180 turn
            %brick.MoveMotorAngleRel('B',50,-360,'Brake');
          
        %else
            %brick.MoveMotor('DB', -100);
            
        end
    end
    
    %brick.SetColorMode(1, 2);  
    %color = brick.ColorCode(1);  

        %if color ==  5
         %   brick.MoveMotor('DB', 'Brake');
         %   brick.MoveMotorAngleRel('B',50,-30,'Brake');
        %else
         %   brick.MoveMotor('DB', -100);
       % end

      %  if color == 4

      %  end

       % if color==2
       % break;
       % end

       % if color ==3
        %break;
       % end

    
end
CloseKeyboard();


