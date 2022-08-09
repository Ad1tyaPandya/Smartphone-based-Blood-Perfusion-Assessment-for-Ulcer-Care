import something
# print("hi")
something.hot()
# print('bye')
# importing the module 
# importing the module 
# import cv2 
# import numpy as np
  
# # reading the vedio 
# source = cv2.VideoCapture('input1.mp4') 

# # We need to set resolutions. 
# # so, convert them from float to integer. 
# frame_width = int(source.get(3)) 
# frame_height = int(source.get(4)) 
   
# size = (frame_width, frame_height) 

# result = cv2.VideoWriter('input.mp4',  
#             cv2.VideoWriter_fourcc(*'MJPG'), 
#             10, size, 0) 
  
# # running the loop 
# while True: 
  
#     # extracting the frames 
#     ret, img = source.read() 
      
#     # converting to gray-scale 
#     gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY) 

#     # write to gray-scale 
#     result.write(gray)

#     # displaying the video 
#     cv2.imshow("Live", gray) 
  
#     # exiting the loop 
#     key = cv2.waitKey(1) 
#     if key == ord("q"): 
#         break
      
# # closing the window 
# cv2.destroyAllWindows() 
# source.release()
# import subprocess
# subprocess.call(['ffmpeg', '-i', "input1.mp4",
#                          "output.avi"])