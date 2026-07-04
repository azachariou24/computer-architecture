/* Computes the Taylor Series for ln(x) for n terms */ 
#include<stdio.h>  

float powerR(float x, int n){ 

    if (n == 0) 
    
        return 1.0; 

    return x * powerR(x,n-1); 

} 

float Taylor_lnR(float x, int i, int n){ 

    if (i > n)
    
        return 0.0; 

    return powerR(-1,i+1)*(powerR(x,i)/i)+Taylor_lnR(x,++i,n);

} 

float Taylor_lnRecursive(float x, int n){ 

    return Taylor_lnR(x-1, 1, n); 

} 

float Taylor_ln(float x, int n){ 

    int i; 
    float sum = 0.0; 

    x = x - 1; 

    for(i=1;i<=n;i++){ 

        sum = sum + (powerR(-1,i+1))*(powerR(x,i)/i); 

    } 

    return sum; 

} 

int main(void){ 
    
    float i; 
    int n = 100; // The number of terms 

    for(i = 0; i <= 2; i+=0.1){ 

        printf("terms[%d] : ln(%f)=%f\n",n,i,Taylor_ln(i, n)); 
        printf("terms[%d]R: ln(%f)=%f\n",n,i,Taylor_lnRecursive(i, n)); 

    } 

} 