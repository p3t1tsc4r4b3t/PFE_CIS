import csv
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy import integrate

num_files = 41

point1 = np.array([0.003065912246704102, 0.020446482023777315, -0.016138603025171158])
point2 = np.array([0.003065912246704102, 0.01659214043528668, 0.014213765966364911])
point3 = np.array([0.003065912246704102, 0.06888531364129963, -0.003162105997512386])
point4 = np.array([0.003065912246704102, 0.10396461774952723, 0.027527135381286098])   


MV_1 = []
MV_2 = []
MV_3 = []
MV_4 = []

r = 0.004

# Define functions to calculate the distance between points and filter data within the circle radius
def distance(p1, p2):
    return np.linalg.norm(p1 - p2)

def filter_within_circle(data, center, radius):
    distances = data.apply(lambda row: distance(np.array([row['Points_0'], row['Points_1'], row['Points_2']]), center), axis=1)
    return data[distances <= radius]

# Filter points within the sphere for the first file (i=1)
data3 = pd.read_csv('EH2_Vm_all_rm_01.csv')


cell_type = data3['Cell Type']
cell_quality = data3['Quality']
Volume=0

t = np.linspace(0,2,41)

dummy = 0
for j in range(0, len(cell_type)): 
    if cell_type[j] == 10 or cell_type[j] == 13:
        Volume+= cell_quality[j]
        dummy += 1
print('Volume =',Volume)

data4 = {
    'Points_0': np.array(data3['Points_0']),
    'Points_1': np.array(data3['Points_1']),
    'Points_2': np.array(data3['Points_2']),
    'Cell Type': np.array(data3['Cell Type']),
    'Quality': np.array(data3['Quality']),
    'Velocity_Magnitude': np.array(data3['Velocity_Magnitude']),
}
data4 = pd.DataFrame(data4)

filtered_data_points = []
for point in [point1, point2, point3, point4]:
    data_within_circle = filter_within_circle(data4, point, r)
    filtered_data_points.append(set(data_within_circle.index))

velocity1 = []
velocity2 = []
velocity3 = []
velocity4 = []
quality1 = data3.loc[filtered_data_points[0], 'Quality']
quality2 = data3.loc[filtered_data_points[1], 'Quality']
quality3 = data3.loc[filtered_data_points[2], 'Quality']
quality4 = data3.loc[filtered_data_points[3], 'Quality']


for i in range(1, num_files + 1):

    data3 = pd.read_csv(f'EH2_Vm_all_rm_{i:02d}.csv')
    

    velocity1.append(np.array(data3.loc[filtered_data_points[0], 'Velocity_Magnitude']))
    velocity2.append(np.array(data3.loc[filtered_data_points[1], 'Velocity_Magnitude']))
    velocity3.append(np.array(data3.loc[filtered_data_points[2], 'Velocity_Magnitude']))
    velocity4.append(np.array(data3.loc[filtered_data_points[3], 'Velocity_Magnitude']))

    print("l'avancement est : ", i * 100 / num_files, '%')
    
#mean_velocities = [MV_1, MV_2, MV_3, MV_4]

V1 = np.array(velocity1)
V2 = np.array(velocity2)
V3 = np.array(velocity3)
V4 = np.array(velocity4)
t = np.linspace(0,2,41)
MV_1 = []
MV_2 = []
MV_3 = []
MV_4 = []

SI1 = []
SI2 = []
SI3 = []
SI4 = []
area = (4*np.pi*(Volume**2)/3)**(1/3)


    
for i in range (0,num_files-1):
    MV11 = []
    MV22 = []
    MV33 = []
    MV44 = []
    SI11 = []
    SI22 = []
    SI33 = []
    SI44 = []
    for j in range(0,len(V1[0,:])):
        
        if cell_type[j] == 10 or cell_type[j] == 13:
            matrix = (V1[i:i+2,j])**2
            inte=integrate.trapezoid(matrix,t[i:i+2],0.05)
            MV11.append(np.mean(V1[i,j])*(cell_quality[j]/(Volume/dummy)))
            SI11.append(np.sqrt(area*2/(inte))*(cell_quality[j]/(Volume/dummy)))
    MV_1.append(np.mean(MV11))
    SI1.append(np.mean(SI11))
    
    for j in range(0,len(V2[0,:])):
        
        if cell_type[j] == 10 or cell_type[j] == 13:
            matrix = (V2[i:i+2,j])**2
            inte=integrate.trapezoid(matrix,t[i:i+2],0.05)
            MV22.append(np.mean(V2[i,j])*(cell_quality[j]/(Volume/dummy)))
            SI22.append(np.sqrt(area*2/(inte))*(cell_quality[j]/(Volume/dummy)))
    MV_2.append(np.mean(MV22))
    SI2.append(np.mean(SI22))
    
    for j in range(0,len(V3[0,:])):
        
        if cell_type[j] == 10 or cell_type[j] == 13:
            matrix = (V3[i:i+2,j])**2
            inte=integrate.trapezoid(matrix,t[i:i+2],0.05)
            MV33.append(np.mean(V3[i,j])*(cell_quality[j]/(Volume/dummy)))
            SI33.append(np.sqrt(area*2/(inte))*(cell_quality[j]/(Volume/dummy)))
    MV_3.append(np.mean(MV33))
    SI3.append(np.mean(SI33))
    
    
    for j in range(0,len(V4[0,:])):
        
        if cell_type[j] == 10 or cell_type[j] == 13:
            matrix = (V4[i:i+2,j])**2
            inte=integrate.trapezoid(matrix,t[i:i+2],0.05)
            MV44.append(np.mean(V4[i,j])*(cell_quality[j]/(Volume/dummy)))
            SI44.append(np.sqrt(area*2/(inte))*(cell_quality[j]/(Volume/dummy)))
    MV_4.append(np.mean(MV44))
    SI4.append(np.mean(SI44))
    
    # Combine the results and save to CSV
data = {
    'MV1': np.array(MV_1),
    'MV2': np.array(MV_2),
    'MV3': np.array(MV_3),
    'MV4': np.array(MV_4),
    'SI1': np.array(SI1),
    'SI2': np.array(SI2),
    'SI3': np.array(SI3),
    'SI4': np.array(SI4),
}

result_df = pd.DataFrame(data)
result_df.to_csv('EH2_4_points_cst.csv', index=False)
    
#     # Create the plots only if there are common points
# t = np.linspace(8, 10, 41)

# for i in range(4):
#     print(i)
#     plt.figure(i)
#     plt.title(r'EH2 Mean Velocity within sphere of center '+str(i+1)+' between T=8s and T=10s', fontsize=16)
#     plt.xlabel('Time (s)', fontsize=16)
#     plt.ylabel('Mean Velocity Magnitude (m/s)', fontsize=16)
#     plt.plot(t, mean_velocities[i], color='blue', marker='o')
#     plt.grid()
#     plt.ylim(np.mean(mean_velocities[i])-0.01,np.mean(mean_velocities[i])+0.01)
#     plt.savefig('Mean_VM_sphere_EH2'+str(i+1)+'.pdf', bbox_inches='tight')
#     plt.show()

