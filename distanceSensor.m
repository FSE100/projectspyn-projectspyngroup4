
distanceSensorPort = 3;
while true
    distance = brick.UltrasonicDist(3);
    buttonPressed = brick.TouchPressed(2);
    
    
    if(buttonPressed == 1)
        brick.StopMotor('BD');
        brick.MoveMotor('BD', 50);
        pause(1);
        brick.MoveMotorAngleRel('D',50, 90,'Brake');
        brick.beep;
        %brick.MoveMotor('BD',-50);
        %break %%remove this break but its convenient for now
        
    elseif (buttonPressed == 0)
    
        if distance < 3 %%Nudge right if too close
            brick.MoveMotorAngleRel('B',50,-30,'Brake');
       
        elseif distance > 7 && distance < 10 %%Nudge left if too far
            brick.MoveMotorAngleRel('D',50,-30,'Brake');
            
        elseif distance >=10 %%180 turn
            brick.MoveMotorAngleRel('B',50,-180,'Brake');
          
        else
            brick.MoveMotor('DB', -100);
            
        end
    end
end


