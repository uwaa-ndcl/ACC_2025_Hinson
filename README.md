# ACC_2025_Hinson
Autocovariance Least Squares with Constrained Noise Covariance Model Identification

---

The scripts to run the constrained Autocovariance Least Squares technique for two examples are contained in this repository.

## Mass Spring Damper Example
![msdfbd](https://github.com/user-attachments/assets/256d80c3-0c33-4f19-bcdf-00a3877f13e3)

1. [gen_data_msd](https://github.com/uwaa-ndcl/ACC_2025_Hinson/blob/main/MassSpringDamper/gen_data_msd.m)
   - Creates simulated datasets of the msd dynmaics with process and measurement noise
   - Generates ALS inputs with initial suboptimal process noise covaraince, $Q$ and measurement noise covariance,  $R$.
2. [run_als_msd](https://github.com/uwaa-ndcl/ACC_2025_Hinson/blob/main/MassSpringDamper/run_als_msd.m)
   - Run script for constrained ALS problem
   - Calls [setup_ALS_msd.m](https://github.com/uwaa-ndcl/ACC_2025_Hinson/blob/main/MassSpringDamper/setup_ALS_msd.m) with defines lags and other ALS inputs
   - [als_msd](https://github.com/uwaa-ndcl/ACC_2025_Hinson/blob/main/MassSpringDamper/als_msd.m)
     - ALS class with mass spring damper constraints for 7 temperature problem
3. [plot_lags_msd](https://github.com/uwaa-ndcl/ACC_2025_Hinson/blob/main/MassSpringDamper/plot_lags_msd.m)
   - Plots results from constrained ALS problem
   - Saves mean and standard deviation of $Q$ and $R$ solutions
   - Figure 2 and Figure 3
4. [plot_QR_T](https://github.com/uwaa-ndcl/ACC_2025_Hinson/blob/main/MassSpringDamper/plot_QR_T.m)
   - Figure 5
  
## Model for Aeroelastic Response to Gust Excitation
![MARGE_tunnel_eddie_2](https://github.com/user-attachments/assets/3e91ef10-5956-45b0-b81e-b710b8b1d441)


1. [wtData_setup](https://github.com/uwaa-ndcl/ACC_2025_Hinson/blob/main/MARGE/wtData_setup.m)
   - Loads wind tunnel datasets: https://github.com/uwaa-ndcl/ACC_2025_Hinson/tree/main/MARGE/Data
   - Relies on models locted here: https://github.com/uwaa-ndcl/ACC_2025_Hinson/tree/main/MARGE/Models
   - Generates ALS inputs with initial suboptimal process noise covaraince, $Q$ and measurement noise covariance,  $R$.
2. [run_als_MARGE](https://github.com/uwaa-ndcl/ACC_2025_Hinson/blob/main/MARGE/run_als_MARGE.m)
   - Run script for constrained ALS problem
   - Calls [setup_ALS_MARGE.m](https://github.com/uwaa-ndcl/ACC_2025_Hinson/blob/main/MARGE/setup_ALS_MARGE.m) with defines lags and other ALS inputs
   - [als_MARGE](https://github.com/uwaa-ndcl/ACC_2025_Hinson/blob/main/MARGE/als_MARGE.m)
     - ALS class with MARGE constraints for 4 dynamic pressure problem
3. [plot_lags_MARGE](https://github.com/uwaa-ndcl/ACC_2025_Hinson/blob/main/MARGE/plot_lags_MARGE.m)
   - Plots results from constrained ALS problem
   - Saves mean and standard deviation of $Q$ and $R$ solutions
4. [plot_QR_qbar](https://github.com/uwaa-ndcl/ACC_2025_Hinson/blob/main/MARGE/plot_QR_qbar.m)
   - Figure 7
   - Relies on unconstrained ALS solutions:https://github.com/uwaa-ndcl/ACC_2025_Hinson/tree/main/MARGE/Results/Unconstrained
5. [wtData_ALSest](https://github.com/uwaa-ndcl/ACC_2025_Hinson/blob/main/MARGE/wtData_ALSest.m)
   - Figures 8-13
   - Relies on wind tunnel data: https://github.com/uwaa-ndcl/ACC_2025_Hinson/tree/main/MARGE/Data/WT_post

