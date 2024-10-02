# IIR Filter

<img src="/Images/Simulink_Model.png" alt="Simulink Model">

## Math Behind IIR Filter
<img src="/Images/Simplified_IIR_Circuit.png" alt="IIR Simplified Depiction">

   $H(z) = \frac{1}{1 - z^{-1}} = \frac{Y(z)}{X(z)}$
   
   $Y(z) (1 - z^{-1}) = X(z)$
   
   $Y(n) - Y(n - 1) = X(n)$
   
   $Y(n) = X(n) + Y(n - 1)$

## Structure between Di and Dout 
* First Block: Gated Counter (Single Bit Input)

* Second Block: Accumulator That Needs a Wide Bit Width

## References 
[1] https://wirelesspi.com/cascaded-integrator-comb-cic-filters-a-staircase-of-dsp/
