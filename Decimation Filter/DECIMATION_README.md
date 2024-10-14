# Decimation Filter

## How it works
Connect an ADC that produces a 1-bit output through oversampling to the input of a decimation filter. The Delta-Sigma modulator produces data at a much higher rate than required, and the decimation filter serves two key functions: it removes high-frequency quantization noise and reduces the data rate.

The decimation filter is crucial because it eliminates unwanted high-frequency noise generated during oversampling while downsampling the data. This ensures that the ADC’s output is easier to manage and process, without sacrificing signal quality.

Without the decimation filter, the oversampled output from the Delta-Sigma ADC would carry excessive noise and an unnecessarily high data rate, making it inefficient and challenging for further processing.

<img src="/Images/Simulink_Model.png" alt="Simulink Model">

## Structure between Di and Dout 
* Two blocks are both gated counters/accumulators. Both accumulators in series with one another creates a quadratic output. 

* The input is a single bit coming from the Delta Sigma ADC and the output is a 16 bit value. In our implementation, the Decimation filter is used to reduce the sample frequency by a factor of 4.

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

## How to test
* Connect an ADC with a 1 bit output and get the 16 bit output

* Delta Sigma ADC

## References 
[1] https://wirelesspi.com/cascaded-integrator-comb-cic-filters-a-staircase-of-dsp/
