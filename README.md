# ISRO 9-Nozzle Cluster Jet — Analytical MATLAB Model

**Author:** Thomas Abraham (22JE1018)  
**Institution:** IIT (ISM) Dhanbad  
**Affiliation:** ISRO Internship Project (2025)  
**Language:** MATLAB  

---

## Project Overview

This repository contains the MATLAB implementation of the **analytical model** developed for the **ISRO 9-nozzle cluster jet simulation**.  
The code models the flow through a single converging–diverging nozzle and extends the analysis to a 9-nozzle cluster configuration by computing the **total mass flow rate** under choked flow conditions.  

This analytical model was used to **validate the flow property profiles** obtained from high-fidelity CFD simulations conducted at the **High-Performance Computing (HPC) facilities** of **ISRO’s Satish Dhawan Space Centre (SDSC)** during my month-long internship.

The model applies quasi–one–dimensional compressible flow theory, using the **area–Mach number relation**, **isentropic flow equations**, and **thermodynamic state relations** to predict:

- Mach number distribution  
- Pressure and temperature variation along the nozzle axis  
- Free-jet behavior downstream of the exit plane  
- Choked-flow mass flow rate for a 9-nozzle cluster  

---

## Numerical Methodology

- The nozzle geometry is represented by analytical functions for **converging** and **diverging** sections.  
- The **Mach number** is evaluated by numerically inverting the **area–Mach relation** using MATLAB’s `fzero`.  
- Pressure and temperature are calculated from the **isentropic flow relations**:  
  \[
  T = \frac{T_0}{1 + \frac{\gamma - 1}{2}M^2}, \quad
  P = \frac{P_0}{(1 + \frac{\gamma - 1}{2}M^2)^{\gamma/(\gamma-1)}}
  \]
- The **mass flow rate** for each nozzle is computed under **choked flow conditions** and multiplied by the number of nozzles in the cluster.

---

## Files Included

| File | Description |
|------|--------------|
| `Analytical.m` | MATLAB script implementing the quasi–1D analytical model for a single converging–diverging nozzle and extended 9-nozzle cluster. Computes Mach number, pressure, temperature, and total choked mass flow rate. |
| `ISRO_Report.pdf` | Final report submitted for the ISRO project, detailing methodology, analytical formulation, results, and validation approach. |

## Outputs
- Mach number distribution along the nozzle and free-jet region  
- Pressure and temperature variations  
- Mass flow rate per nozzle and total cluster flow rate  

---

## Key Concepts Demonstrated
- Quasi–1D compressible flow modelling  
- Area–Mach number relation and inversion using `fzero`  
- Isentropic flow property evaluation  
- Analytical estimation of choked mass flow rate  

---
