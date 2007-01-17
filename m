From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Wed, 17 Jan 2007 23:33:25 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1QqrFrRGWr9RMAX"
Message-Id: <200701172333.25574.niklaus.giger@domain.hid>
Subject: [Xenomai-core] PPC405: DMA-Problem with OCM (interrupt-example)
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--Boundary-00=_1QqrFrRGWr9RMAX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

I tried to simply an example program how to use interrupts
with Xenomai (see attached Makefile & dma_4xx_int_module.c).

The interrupt part of the example works, but the DMA transfer (memory to
memory) using the OnChipMemory fails. I think I must somewhere specify that 
the src/dst adressed should not be cached, but I do not know how to do it.
(I tried to use virt_to_phys and virt_to_bus but failed miserably.)
The OCM is initialised in my board specific __init by calling:
>         io_block_mapping(mfdcr(DCRN_OCMDSARC), mfdcr(DCRN_OCMDSARC),
> 4*1024, _PAGE_IO);

A simple insmod/rmmod cycle gives me the following output:

>                      init_module: SRC f4000000 DST f4000103
>                      init_module: residue 111 status 0xa00f100
>              xenomai_irq_handler: IRQ  8 uipr 0xffffff87 uier 0x003f0000
> uisr 0xc0809807 xenomai_irq_handler: residue 0 status 0x1a00f000
> src at f4000000 is Could we use a DMA + interrupt to copy a string?
> dst at f4000103 is Should be overwritten.
>                   cleanup_module: dma_ch.control 0x0 0
>                   cleanup_module: IRQ  8 uipr 0xffffff87 uier 0x003f0000
> uisr 0xc0009807 cleanup_module: residue 0 status 0x1a00f000
> src at f4000000 is Could we use a DMA + interrupt to copy a string?
> dst at f4000103 is Should be overwritten.

Does anybody have a clue?

If this question is off topic, which mailing list would you reccomend?
(http://ozlabs.org/pipermail/linuxppc-embedded/ ??)

Is the example code otherwise good enough to be accepted as an example how to 
attach a interrupt?

Best regards
-- 
Niklaus Giger

--Boundary-00=_1QqrFrRGWr9RMAX
Content-Type: application/x-zip; charset="iso-8859-1"; name="Makefile.zip"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="Makefile.zip"

UEsDBBQAAAAIACG6MTYmASZwpAIAANQEAAAIAAAATWFrZWZpbGV9U2FvmzAQ/Vz/iluaSiEKsG7V
pFHxgRLaZSGhglSrNE2IgClejE0xbKmm/ffZhCyJpg4JsM93797dPZ+fqwfcYHk7u3sIndUsWEJn
O0eBZZutqE1Rp+a6JTTTi7R9r78zPhiXH41LNPWi1XQW2mbBS2zKM7PmvMmFyciGJq2Id55oHoXu
ERQlrN0eUJATup8su6pS5IZBFMVusLif+V5niq+2Wx3dOyvpsUvDq8bENNuYV/HbDnJNmNUtKE8T
eth2C/lBC8sejkSBKYXqZ6YhpAr2iWiA55BUFSVp0hDOBDQc1hi6UtGjtwxkXF+j1kFuMeNlQjqA
JW+wpSL4D1zXJMPQFBgETuq0gCppCsh53dlUlJ5ylpMnEGlNqmYCrcAwKJMNBpVn133bMIwBOqVX
8qyl+JTZIpg++F4ENmRlohoUE9bEO0/0H24bXDNMQfC2TnFH8ZiHGlLPYDd+mHvh0vNhlw5uHmb+
FEaMQ1ok7AlDjZ9bUuMMGK/LhNIXba8bkjP8DKPhqGeqTWTTg5vPEajHsmH4S2YX7VrWeDGBC4NP
4OD8G7m+5yzl9l9X42J86nr/ZQp/Ufshkxy+wmA4lGcDeGPDYADfrlUHGOC04NCdXAOmsnYpiGvI
SS+K+a5DUpqIr7/rJcARuCpAQ97jKnRi99Z37iJp12fDkeqcZhKW0jbDe43AqydmxQXZSkBnOu2B
ZHpZ0sKZS9F3wzi5CFKFJ3sNQF0ZaVY/DZRMAw10F/qMsJCWhQbq2siV+mmv80GoF5mFzrrWKh7a
XnkIESYaOV7rbG859poto5Xj+7E0xH26/Y3ZI8Q9AEIK5QCDUooTZnVZQ8lWVtnPXYOxkZaZ/HL5
btRHBhkpLLrQsSFeSilssY/UQzCashojhFlGcvQHUEsBAhQDFAAAAAgAIboxNiYBJnCkAgAA1AQA
AAgACQAAAAAAAAAAAKSBAAAAAE1ha2VmaWxlVVQFAAdeoK5FUEsFBgAAAAABAAEAPwAAAMoCAAAA
AA==

--Boundary-00=_1QqrFrRGWr9RMAX
Content-Type: application/x-zip; charset="iso-8859-1";
	name="dma_4xx_int_module.c.zip"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="dma_4xx_int_module.c.zip"

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

--Boundary-00=_1QqrFrRGWr9RMAX--

