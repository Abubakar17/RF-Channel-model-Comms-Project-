# RF-Channel-model-Comms-Project-
implement the propagation of  a given RF signal through a Nakagami-m Fading Model 
The Nakagami distribution is a probability distribution often used to model the amplitude of a signal affected by multipath fading in wireless communication systems. The distribution has two parameters: mu (μ) and omega (ω).

Mu (μ): The mu parameter, also known as the "shape parameter," controls the shape of the distribution. It is a positive real number that represents the fading severity in the channel. When mu equals 1, the Nakagami distribution becomes the Rayleigh distribution, which models the worst-case fading scenario with no line-of-sight component. As mu increases, the distribution approaches the Ricean distribution, which has a stronger line-of-sight component and less severe fading.

Omega (ω): The omega parameter, also known as the "spread parameter" or "scaling parameter," controls the spread of the distribution. It is a positive real number that represents the mean power of the signal, or the average energy per symbol. This parameter determines the scale of the Nakagami distribution and is related to the received signal power. When modeling wireless channels, the omega parameter often varies with the distance between the transmitter and receiver, as well as other factors such as shadowing and path loss.

In summary, the two parameters of the Nakagami distribution are mu (μ), which controls the shape of the distribution and represents the severity of fading, and omega (ω), which controls the spread of the distribution and represents the mean signal power.
