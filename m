Message-ID: <50CC6B1E.8070102@xenomai.org>
Date: Sat, 15 Dec 2012 13:20:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7385E066AECB78449EEDFA7EE2A2B2B60A052D7D@DB3PRD0410MB355.eurprd04.prod.outlook.com>
In-Reply-To: <7385E066AECB78449EEDFA7EE2A2B2B60A052D7D@DB3PRD0410MB355.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-help] Latency calculation on da850 (Omap
	L138)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: GUGLIELMO NAVARRA <guglielmo.navarra@studenti.uniparthenope.it>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 12/15/2012 01:07 PM, GUGLIELMO NAVARRA wrote:

> Hello,
> I ported i-pipe to the board da850 with TI L138 CPU.
> I have no problems during startup, the system starts quietly.
> I followed the guide http://www.xenomai.org/index.php/I-pipe-core:ArmPorting,
> the only thing that I did not (because do not use ) are the changes to the GPIO module.
> When I run latency program in "user-task period" mode, the latency shows great numbers and even negative,
> which does not happen if i run latency in "in-kernel task period" mode, with more normal numbers.
> Of course, before you run latency test, sending "echo 0 > /proc/xenomai/latency".
> 
> If I use cyclictest, the numbers are more correct. What could be the problem?
> Is there any mistake I made or that I missed in porting?


You probably got the user-space "high resolution counter" (tsc)
emulation wrong. In order to check if the user-space tsc emulation runs
correctly, try the "tsc" test. The only reasons I already saw for the
emulation to run correctly in kernel-space but not in user-space are:
- you are passing the wrong physical address in the "struct
__ipipe_tscinfo" structure, this error only affects user-space
- the processor is configured to forbid access to the timers registers
in user-space, you have to change the configuration to allow it.

-- 
                                                                Gilles.

