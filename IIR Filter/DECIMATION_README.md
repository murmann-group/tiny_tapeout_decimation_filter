# Decimation Filter

<img src="/Images/Simulink_Model.png" alt="Simulink Model">

## Math Behind Decimation Filter
<div class="text-center">
    <img src="/Images/Simplified_IIR_Circuit.png" alt="IIR Simplified Depiction" height="300px" width="300px"> 
</div>

   $H(z) = \frac{1}{1 - z^{-1}} = \frac{Y(z)}{X(z)}$
   
   $Y(z) (1 - z^{-1}) = X(z)$
   
   $Y(n) - Y(n - 1) = X(n)$
   
   $Y(n) = X(n) + Y(n - 1)$

   To find the impulse response, we replace x(n) with the unit impulse $\delta(n)$.

   We first start with the intial condition $y(-1) = 0$:

   $y(0) = 1 + 0$

   $y(1) = 0 + 1$

   $y(2) = 0 + 1$
   
   Thus, we see that the impulse response of the filter is 0 for n < 0 and 1 for n $\geq$ 0, so $h_{i}[n] = u[n]$.

## Structure between Di and Dout 
* Two blocks are both gated counters/accumulators. The input is a single bit coming from the Delta Sigma ADC and the output is a 16 bit value. Both accumulators in series with one another creates a quadratic output.

## References 
[1] https://wirelesspi.com/cascaded-integrator-comb-cic-filters-a-staircase-of-dsp/
