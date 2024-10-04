# IIR Filter

<img src="/Images/Simulink_Model.png" alt="Simulink Model">

## Math Behind IIR Filter
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
* First Block: Gated Counter (Single Bit Input)

* Second Block: Accumulator That Needs a Wide Bit Width

## References 
[1] https://wirelesspi.com/cascaded-integrator-comb-cic-filters-a-staircase-of-dsp/
