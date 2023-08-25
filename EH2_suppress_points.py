# -*- coding: utf-8 -*-
"""
Created on Mon Jul 10 13:54:58 2023

@author: clement.leger
"""
import csv
import numpy as np
from scipy import integrate
import pandas as pd
import time
from progress.bar import IncrementalBar

def suppress_points_under_plane(plane_point1, plane_point2, plane_point3, points):
    # Create a numpy array for the three points defining the plane
    plane_points = np.array([plane_point1, plane_point2, plane_point3], dtype=float)

    # Compute the normal vector of the plane
    v1 = plane_points[1] - plane_points[0]
    v2 = plane_points[2] - plane_points[0]
    normal_vector = np.cross(v1, v2)

    # Normalize the normal vector
    normal_vector /= np.linalg.norm(normal_vector)

    # List to store points above or on the plane
    incre = []
    # Convert points DataFrame to float with NaN for non-numeric or missing values
    points = points.apply(pd.to_numeric, errors='coerce')
    
    
    for j in range(len(points)):
        
        print("l'avancement est : ", j * 100 / len(points), '%')
        try:
            # Extract a row from the DataFrame and convert it to a numpy array
            point = np.array(points.iloc[j])

            # Check if any NaN values are present in the row
            if np.isnan(point).any():
                # Skip this row if it contains any NaN values
                continue

            # Compute the vector from any point on the plane to the current point
            vec_to_point = point[:3] - plane_points[0]

            # Calculate the dot product of the vector to the point and the normal vector
            dot_product = np.dot(vec_to_point, normal_vector)

            # If the dot product is non-negative, the point is above or on the plane
            if dot_product >= 0:
                incre.append(j)
        except ValueError:
            # Handle non-numeric or missing data
            pass
        
    return incre

num_files = 1

plane_point1 = np.array([0.0018333261711967834, 0.0076859671111069945, -0.0016950040506517179])
plane_point2 = np.array([0.007324528837756441, 0.007425413624007568, 0.0002515569673210274])
plane_point3 = np.array([0.005957701097672514, 0.008248724268469656, -0.004600656476703483])
    

data1 = pd.read_csv('EH2_P.csv')

i =1



data4 = {
    'Points_0': np.array(data1['Points_0']),
    'Points_1': np.array(data1['Points_1']),
    'Points_2': np.array(data1['Points_2']),
}

data4 = pd.DataFrame(data4)

points = data4[['Points_0','Points_1','Points_2']]

incre = suppress_points_under_plane(plane_point1, plane_point2, plane_point3, points)

data2 = pd.read_csv('EH2_Q.csv')



num_files = 41

for i in range(1, num_files+1):
    
    print("l'avancement est : ", i * 100 / num_files, '%')

    # Example usage:
    data3 = pd.read_csv(f'EH2_nopoi_VM_all_{i:02d}.csv')
  
    # Combine the results and save to CSV
    data = {
        'Points_0': np.array(data1.loc[incre, 'Points_0']),
        'Points_1': np.array(data1.loc[incre, 'Points_1']),
        'Points_2': np.array(data1.loc[incre, 'Points_2']),
        'Cell Type': np.array(data2.loc[incre, 'Cell Type']),
        'Quality': np.array(data2.loc[incre, 'Quality']),
        'Velocity_Magnitude': np.array(data3.loc[incre, 'Velocity_Magnitude']),
    }
    
    result_df = pd.DataFrame(data)
    result_df.to_csv(f'EH2_Vm_all_rm_{i:02d}.csv', index=False)
    
    del(data)
    del(data3)