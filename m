Message-ID: <45C19C09.20903@domain.hid>
Date: Thu, 01 Feb 2007 08:51:37 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] switchbench tests with IPIPE tracer disabled
References: <79744.96382.qm@domain.hid>
In-Reply-To: <79744.96382.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: poornima r <rpoornar@domain.hid>
Cc: adeos-main@gna.org

poornima r wrote:
> Hi,
> 
> I was able to run latency and switchbench tests on
> MPC860 board with IPIPE tracer feature
> enabled/disabled.

Nice, what versions of Linux and Xenomai did you use for your tests? It 
is known that Linux 2.6 does not yet work properly for 8xx. It would 
also be nice if you could briefly post your results on this list as well.

> Interrupt & scheduling Latencies and switching
> latencies (with IPIPE tracer option disabled) were
> having lower values when compared to latency values
> with IPIPE tracer enabled. 

The ipipe tracer introduces some overhead (extra code) and as this CPU 
is very slow, you will notice it.

> cyclictest test results were same with or without
> IPIPE tracer enabled. 

Your results would really be of interest.

> Is this reduced context switching latency in
> switchbench test due to timer interrupt?  

Likely it also due to overhead introduced by the ipipe tracer.

BTW: the switchtest should run as well with the option "-n" (for not 
using the FPU),

Wolfgang.


