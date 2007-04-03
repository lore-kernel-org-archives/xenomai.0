Message-ID: <46124C61.3070107@domain.hid>
Date: Tue, 03 Apr 2007 14:45:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] large latencies on a Dell D620 dual core laptop
References: <20070403143122.4ac4ffaf@domain.hid>
In-Reply-To: <20070403143122.4ac4ffaf@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Simon <Daniel.Simon@domain.hid>
Cc: xenomai@xenomai.org

Daniel Simon wrote:
> Hello all,
> 
> I have very high latencies running Xenomai on my new laptop.
> It is a dell D620 dual core laptop with the following
> configuration:
> 
> kernel 2.6.20.3, xenomai 2.3.1, adeos-ipipe-2.6.20-i386-1.7-03.patch
> compiled with  gcc-4.1.1 (fedora core 6), cpuinfo is attached
> 
> kernel config file are attached, to summarize:
> 
> no HPET, no APM, no CPU_FREQ, no ACPI_PROC
> CONFIG_XENO_HW_SMI_APMC must be enabled, otherwise the kernel does not boot
> 
> here is a sample of the latency test trace:
> 
> root@domain.hid$ ./latency -f
> == Sampling period: 100 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...
> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
> RTD|       5.463|       5.823|     112.608|       1|       5.463|     112.608
> RTD|       5.484|       6.109|    1414.435|      32|       5.463|    1414.435
> RTD|       5.388|       6.025|     344.315|      37|       5.388|    1414.435
> RTD|       5.432|       6.149|    1549.593|      69|       5.388|    1549.593
> RTD|       5.468|       5.769|      32.653|      69|       5.388|    1549.593
> RTD|       5.447|       6.183|    1671.993|     109|       5.388|    1671.993
> RTD|       5.506|       6.135|    2935.370|     139|       5.388|    2935.370
> RTD|       5.406|       6.753|    1505.142|     200|       5.388|    2935.370
> RTD|       5.456|       5.827|      36.626|     200|       5.388|    2935.370
> RTD|       5.041|       6.138|    1393.665|     229|       5.041|    2935.370
> RTD|       5.503|       5.778|      52.663|     229|       5.041|    2935.370
> RTD|       5.506|       6.138|    1691.224|     263|       5.041|    2935.370
> 
> I also disabled the USB emulation in BIOS, also boot in runlevel 3
> (without X), but that does not improve this bad behavior. 
> 
> Any idea? Is it possible to be a  rt_pathological laptop?

Maybe you could compile Xenomai support as modules, and disable
CONFIG_XENO_HW_SMI_APMC ? If this does not work, I am afraid you are in
the "out of luck" case of Xenomai TROUBLESHOOTING file.

-- 
                                                 Gilles Chanteperdrix

