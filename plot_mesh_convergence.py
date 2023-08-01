import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

def Get_data(mesh,plan,i):
# Read the CSV file
    data = pd.read_csv('line_'+str(mesh)+'_'+str(plan)+'_'+str(i)+'.csv')


    # Extract the relevant columns
    velocity = np.array(data['Velocity_Magnitude'])
    pressure = np.array(data['PressureStagnation'])
    return velocity, pressure

mesh = ['c','cp','m','mp','f']
plan = ['XY','YZ']

dat = pd.read_csv('line_c_XY_1.csv')
points_ID = dat['Point ID']

l = 1 

for i in range(len(plan)):
    for j in range(0,3):
        V = np.empty((len(mesh), len(points_ID)))  # Create an empty 2D numpy array for velocity
        P = np.empty((len(mesh), len(points_ID)))  # Create an empty 2D numpy array for pressure       
        plt.figure(l)
        for k in range(len(mesh)):
            V[k,:],P[k,:] = Get_data(mesh[k], plan[i], j+1)
            
        
        plt.plot(points_ID*0.001, V[0,:],'-x',markevery=40, label='Coarse')
        plt.plot(points_ID*0.001, V[1,:],'-',markevery=40, label='Coarse Plus')
        plt.plot(points_ID*0.001, V[2,:],'--',markevery=40, label='Medium')
        plt.plot(points_ID*0.001, V[3,:],'-',markevery=40, label='Medium Plus')
        plt.plot(points_ID*0.001, V[4,:],'-o',markevery=40, label='Fine')
        plt.xlabel('Adimentional Position', fontsize=14)
        plt.ylabel('Velocity (m/s)', fontsize=14)
        plt.title('Velocity vs position at t=10.0s', fontsize=18)
        plt.grid(True)
        plt.legend(fontsize=12)
        plt.savefig('MC_Velocity_'+str(l)+'.pdf', bbox_inches='tight')
        plt.show()
        
        # plt.plot(points_ID*0.001, P[0,:],'-x',markevery=40, label='Coarse')
        # plt.plot(points_ID*0.001, P[1,:],'-',markevery=40, label='Coarse Plus')
        # plt.plot(points_ID*0.001, P[2,:],'--',markevery=40, label='Medium')
        # plt.plot(points_ID*0.001, P[3,:],'-',markevery=40, label='Medium Plus')
        # plt.plot(points_ID*0.001, P[4,:],'-o',markevery=40, label='Fine')
        # plt.xlabel('Adimentional Position', fontsize=14)
        # plt.ylabel('Pressure (Pa)', fontsize=14)
        # #plt.title('Pressure vs position at t=10.0s', fontsize=18)
        # plt.grid(True)
        # plt.legend(fontsize=12)
        # plt.savefig('MC_Pressure_'+str(l)+'.pdf', bbox_inches='tight')
        
        l+=1