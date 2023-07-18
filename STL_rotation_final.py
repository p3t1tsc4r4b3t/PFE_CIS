import numpy as np
from stl import mesh

# Load the STL file
name ='14675-01_GU100_Sutue_ring_cannula_Assy.stl'# Evaheart Geometry 
name ='HM3_InflowFullPMcoated_WoutCover.stl' # HeartMate3 Geometry
stl_mesh = mesh.Mesh.from_file(name)


# Define the rotation axis
#axis1 = np.array([1, 0, 0]) \
    #Evaheart geometry axis
axis1 = np.array([0, -167515891739673/18014398509481984, 0]) \
    # Heartmate 3 geometry axis
axis2 = np.array([1689030004249031/1152921504606846976, 649/6250, 1127/62500]) \
    # Old HVAD cannula axis


# Calculate the rotation angle
norm1 = np.linalg.norm(axis1)
norm2 = np.linalg.norm(axis2)

if norm1 == 0 or norm2 == 0:
    rotation_matrix = np.identity(3)
else:
    dot_product = np.dot(axis1, axis2)
    angle = np.arccos(dot_product / (norm1 * norm2))
    
    # Calculate the rotation matrix
    axis = np.cross(axis1, axis2)
    axis /= np.linalg.norm(axis)
    
    c = np.cos(angle)
    s = np.sin(angle)
    t = 1 - c
    x, y, z = axis
    
    rotation_matrix = np.array([
        [t*x*x + c, t*x*y - z*s, t*x*z + y*s],
        [t*x*y + z*s, t*y*y + c, t*y*z - x*s],
        [t*x*z - y*s, t*y*z + x*s, t*z*z + c]
    ])

# Apply the rotation
vertices = stl_mesh.vectors.reshape((-1, 3))
rotated_vertices = np.dot(vertices, rotation_matrix)
rotated_mesh = mesh.Mesh(np.zeros_like(stl_mesh.data))
rotated_mesh.vectors = rotated_vertices.reshape((-1, 3, 3))

# Save the rotated mesh to a new STL file
#rotated_mesh.save('Evaheart2_rotated.stl')
rotated_mesh.save('HM3_rotated.stl')
