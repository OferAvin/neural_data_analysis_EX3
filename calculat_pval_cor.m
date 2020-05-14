function[cor,pval] = calculat_pval_cor(set_size,mean)
    [r,p] = corrcoef(set_size,mean);
    cor = r(1,2);
    pval = p(1,2);