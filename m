Message-ID: <53E3D084.2000506@tuebingen.mpg.de>
Date: Thu, 07 Aug 2014 12:16:20 -0700
From: Ludovic Righetti <ludovic.righetti@tuebingen.mpg.de>
MIME-Version: 1.0
References: <AE39D2A4-ECC3-481B-AF3B-8A67FA23D2BF@tuebingen.mpg.de>
 <44BE6908-E639-421F-B556-E7B3871402CF@gmail.com>
 <67B7E374-C4D2-4F83-BA40-B289B15867B9@tuebingen.mpg.de>
 <53E3B5E3.3090006@xenomai.org> <oqtx5om90q.fsf@merlin.sez.to>
 <53E3CD23.5040909@xenomai.org>
In-Reply-To: <53E3CD23.5040909@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] real-time guarantee issues on xenomai 2.6.2.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Paul Janzen <pcj@xenomai.sez.to>, xenomai@xenomai.org


> This is more likely a I-pipe issue (3.4.6/x86 is outdated, although 1 ms
> is really above usual issues), a kernel configuration issue (e.g.
> CONFIG_CPU_FREQ, or other latency killer), or maybe a SMI problem. Or
> maybe an issue induced by a graphic card driver if you happen to run
> with a GUI.
>
we have the same issue (same machine Alexander described - xeno 2.6.3 /
kernel 3.8.13 ipipe patch from the xenomai tar)
below the xeno latency output when I run with a watch -n .1 cat
/proc/xenomai/stat and no X-windows server. I do not have the problem
without the watch command and with running a x-window (ubuntu 12.04
desktop) although I get latency spikes when opening open gl windows
(which I know is normal).

CONFIG_CPU_FREQ, CPU_IDLE, ACPI_PROCESSOR, INPUT_PCSPKR are disabled in
my kernel config. Not sure if there could be other latency killers I
should disable.

RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat
best|--lat worst
RTD|     -2.413|     -0.799|    141.488|       1|     0|     -2.413|   
141.488
RTD|     -2.423|     -0.494|    477.758|      15|     0|     -2.423|   
477.758
RTD|     -2.440|     -0.564|    286.563|      23|     0|     -2.440|   
477.758
RTD|     -2.389|     -0.858|    118.116|      24|     0|     -2.440|   
477.758
RTD|     -2.376|     -0.980|     71.960|      24|     0|     -2.440|   
477.758
RTD|     -2.375|     -0.671|    100.248|      24|     0|     -2.440|   
477.758
RTD|     -2.382|     -0.872|    184.203|      26|     0|     -2.440|   
477.758
RTD|     -2.383|     -0.739|    260.341|      33|     0|     -2.440|   
477.758
RTD|     -2.380|     -0.760|    711.203|      41|     0|     -2.440|   
711.203
RTD|     -2.314|     -0.658|   1664.493|      63|     0|     -2.440|  
1664.493
RTD|     -2.413|     -0.838|    134.240|      65|     0|     -2.440|  
1664.493
RTD|     -2.435|     -0.661|    381.385|      68|     0|     -2.440|  
1664.493
RTD|     -2.317|     -0.872|     93.973|      68|     0|     -2.440|  
1664.493
RTD|     -2.316|     -0.568|   2756.048|     100|     0|     -2.440|  
2756.048
RTD|     -2.387|     -0.870|    117.891|     102|     0|     -2.440|  
2756.048
RTD|     -2.319|     -0.950|     66.645|     102|     0|     -2.440|  
2756.048
RTD|     -2.384|     -0.864|     86.956|     102|     0|     -2.440|  
2756.048
RTD|     -2.385|     -0.878|     73.840|     102|     0|     -2.440|  
2756.048
RTD|     -2.380|     -1.000|     42.325|     102|     0|     -2.440|  
2756.048

best wishes
ludovic
