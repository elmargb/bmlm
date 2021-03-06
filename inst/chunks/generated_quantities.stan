    // Transform Cholesky factorized correlation matrix to corrmat and covmat
    matrix[K, K] Omega;         // Correlation matrix
    matrix[K, K] Sigma;         // Covariance matrix

    // Average mediation parameters
    real covab;                 // a-b covariance
    real corrab;                // a-b correlation
    real ab;                    // Indirect effect
    real c;                     // Total effect
    real pme;                   // % mediated effect

    // Person-specific mediation parameters
    vector[J] u_ab;
    vector[J] u_cp;
    vector[J] u_c;
    vector[J] u_pme;
    vector[J] u_a;
    vector[J] u_b;

    // Re-named tau parameters for easy output
    real tau_cp;
    real tau_b;
    real tau_a;
    real tau_dy;
    real tau_dm;

    tau_cp = tau[1];
    tau_b = tau[2];
    tau_a = tau[3];
    tau_dy = tau[4];
    tau_dm = tau[5];

    Omega = L_Omega * L_Omega';
    Sigma = quad_form_diag(Omega, tau);

    covab = Sigma[3,2];
    corrab = Omega[3,2];
    ab = a*b + covab;
    c = cp + a*b + covab;
    pme = ab / c;

    for (j in 1:J) {
        u_a[j] = a + U[j, 3];
        u_b[j] = b + U[j, 2];
        u_ab[j] = (a + U[j, 3]) * (b + U[j, 2]);
        u_cp[j] = cp + U[j, 1];
        u_c[j] = u_cp[j] + u_ab[j];
        u_pme[j] = u_ab[j] / u_c[j];
    }
