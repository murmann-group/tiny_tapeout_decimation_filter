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
### Integrator
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

### Comb
   $c[n] = x[n] - x[n - L]$

Impulse Response

   $h_{c}[n] = \delta[n] - \delta[n - L]$

Frequency Response

   $H_{c}(e^{jw}) = \sum_{n} h_{c}[n]e^{-jwn}$

   $H_{c}(e^{jw}) = \delta[n]^{-jwn} - \delta[n - L]^{-jwn}$

   $H_{c}(e^{jw}) = 1 - e^{-jwL}$

   At $\delta[n-n_{0}]$ is 1 at $n_{0}$ and zero everwhere else.

   $H_{c}(e^{jw}) = e^{-jw\frac{L}{2}}(e^{+jw\frac{L}{2}} - e^{-jw\frac{L}{2}})$

   $H_{c}(e^{jw}) = e^{-jw\frac{L}{2}} \cdot j2sin(w\frac{L}{2})$

   In terms of iscrete frequency:
   
   $H_{c}(f) = e^{-j\pi Lf} \cdot j2sin(\pi Lf)$

   The first term and the factor j contribute to the phase only and all that is left for magnitude is a sine wave. The shape of the curve is the reason the term "comb" is used because there are L nulls in the frequency response at equally spaced intervals that makes the spectrum look like a comb.

## How to test
* Connect an ADC with a 1 bit output and get the 16 bit output

* Delta Sigma ADC

## References 
[1] https://wirelesspi.com/cascaded-integrator-comb-cic-filters-a-staircase-of-dsp/
