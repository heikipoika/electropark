import pdb
import matplotlib.pyplot as plt
import numpy as np
import scipy

def parsefile():
    with open("cars2.txt", 'w') as outfile, open("cars.txt", 'r', encoding='utf-8') as infile:
        for line in infile:
            if line.startswith("snap"):
                continue
            strs = line.split()
            #pdb.set_trace()
            outfile.write(strs[3][1:9]+','+strs[0]+'\n')


cars = [int(line.split(',')[1]) for line in open('cars2.txt', 'r')]



fig = plt.figure(figsize=(4,4)) # Notice the equal aspect ratio
ax = fig.add_subplot(1,1,1)
#pdb.set_trace()
ax.plot(cars, 'g')
# ax.plot(x,y, 'r')
#ax.plot(M,np.log(M), 'g')
#ax.plot(M,SCALE*np.log(M), 'g')
#ax.plot(M,SCALE2*np.sqrt(SCALE*np.log(M)), 'b')

plt.show()