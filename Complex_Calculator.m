disp("Welcome to the Complex Calculator!")
# This line is here solely for the purpose of not having the function declaration first
# in the program. Octave interprets files with a function declaration at the top differently
# from a program that has something else at the top. As function declarations in Octave need
# to be before they are called (MATLAB behaves differently), this display line allows the
# function declaration to be at the top of the program while also keeping the file as a script file
# rather than as a function file (both have file ending of .m though).

global program_status = 1;
global prev_answer = 0;

# If running in Octave, this function definition should be at the beginning of the program.
# If running on MatLab, this function definition should be at the end of the program.
function complex_input = get_complex_input
  #disp("getting complex input")
  global prev_answer;
  response = false;
  while (response == false)
    complex_type = input("Rectangular or Polar? Type 'r' or 'p' to choose.\nYou may also type 'a' to use the previous answer.\n", "s");
    if (complex_type == 'r')
      response = true;
      complex_input = input("Type the number like so: a+bi\n");
    elseif (complex_type == 'p')
      response = true;
      complex_mag = input("Type the magnitude:\n");
      complex_angle = input("Type the angle:\n");
      # The 'd' appended to the sine and cosine functions mean they work with degrees rather than radians.
      complex_input = (complex_mag*cosd(complex_angle)) + (complex_mag*sind(complex_angle))*i;
    elseif (complex_type == 'a')
      response = true;
      complex_input = prev_answer;
      disp(complex_input);
    else
      disp("Please input a valid response.");
    endif
  endwhile
endfunction


while (program_status == 1)
  global program_status
  clc # This clears the command window
  clear # This clears the variable workspace
  disp("Enter 'p' for parallel impedances.")
  disp("Enter 'l' for adding impedances.")
  disp("Enter '/' to quit the program.")
  disp("NOTE: All angles are in degrees.\n")
  command = input("Which operation do you desire?\n", "s");
  printf("\n")
  switch (command)
    case 'p' # Calculating parallel impedances
      clc
      disp("Enter Value #1.")
      x = get_complex_input;
      clc
      disp("Enter Value #2.")
      y = get_complex_input;
      answer = (x*y)/(x+y);
      clc
      printf("Inputs:\nValue #1 = %f + %f\nValue #2 = %f + %f\n\n", real(x), imag(x), real(y), imag(y));
      printf("Equivalent Parallel Impedance:\nRectangular: %f + %fi\nPolar: %f < %f\n\n", real(answer), imag(answer), abs(answer), angle(answer)*(180/pi))
      prev_answer = answer;
      input("Press any key to continue.")
    case 'l' # Adding impedances
      x = get_complex_input;
      y = get_complex_input;
      answer = x+y;
      printf("\nAnswers:\nRectangular: %f + %fi\nPolar: %f < %f\n\n", real(answer), imag(answer), abs(answer), angle(answer)*(180/pi))
      prev_answer = answer;
      input("Press any key to continue.")
    case '/' # Quitting the program
      program_status = 0;
      clc
  endswitch
  printf("\a") # Rings the terminal bell on your computer :)
endwhile

