Message-ID: <434CFDFF.2090201@domain.hid>
Date: Wed, 12 Oct 2005 14:13:51 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] PATCH: fix ppc64 calibration
References: <1CFEB358338412458B21FAA0D78FE86D02CABCA8@domain.hid>
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D02CABCA8@domain.hid>
Content-Type: multipart/mixed; boundary="------------060709030901050403040709"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------060709030901050403040709
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On 10/11/2005 05:11 PM Fillod Stephane wrote:
> Heikki Lindholm wrote:
> [..]
>> Probably, but there are less than awesome 4xx boards around and I'd 
>> guess they might even be more likely targets than G4 based machines,
> for 
>> example. Some tuning might be needed.
> 
> How many people are using Xenomai (or Fusion) on 4xx ?
> What are their typical sched latency ?

Attached is the result of some latency measurements on the Ocotea eval
board. The AMCC 440 GX is already a fast 4xx processor. Unfortunately,
the linuxppc-2.6.10rc3 does not run on our Ebony board. Nevertheless,
it's difficult to provide a resonable default value. Why not simply
using 0 and it's then up to the user to provide an appropriate value
at configuration time?

Wolfgang.



--------------060709030901050403040709
Content-Type: text/plain;
 name="fusion-latencies-ocotea.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fusion-latencies-ocotea.log"

_______________________________________________________________________________

AMCC PowerPC 440GX Rev. C
Board: Ocotea - AMCC PPC440GX Evaluation Board
        VCO: 1066 MHz
        CPU: 533 MHz
        PLB: 152 MHz
        OPB: 76 MHz
        EPB: 76 MHz
I2C:   ready
DRAM:  256 MB
FLASH:  5 MB
PCI:   Bus Dev VenId DevId Class Int
In:    serial
Out:   serial
Err:   serial
Net:   ppc_4xx_eth0, ppc_4xx_eth1, ppc_4xx_eth2, ppc_4xx_eth3

Linux: linuxppc-2.6.10rc3

Adeos 2.6r8c4/ppc -- Pipelining: permanent

   Linux: priority=100, id=0x00000000, ptdkeys=0/4
        irq0-95: accepted
        irq96: accepted, virtual
        irq97: grabbed, virtual
_______________________________________________________________________________


*** SWITCH Without load ***

== Sampling period: 100 us
== Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|        lost
RTD|        5310|        7168|       17493|           0


*** CRUNCHER without load ***

Calibrating cruncher...301237,  8663, done -- ideal computation time = 9622 us.
1000 samples, 1000 hz freq (pid=24806, policy=SCHED_FIFO, prio=99)
--------
Nanosleep jitter: min = -8 us, max = 27 us, avg = -8 us
Execution jitter: min = -30 us (0%), max = 77 us (0%), avg = 7 us (0%)
--------


*** KLATENCY with load ("ping -f" and "while ls; do ls; done" in telnet window) ***

RTS|      -12510|       -9546|        3731|       0|    00:06:26/00:06:26


*** LATENCY with load ("ping -f" and "while ls; do ls; done" in telnet window) ***

== Sampling period: 100 us
...
RTS|      -11940|       -8885|        7143|       0|    00:06:55/00:06:55

--------------060709030901050403040709--

