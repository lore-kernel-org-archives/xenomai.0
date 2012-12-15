Message-ID: <50CC6E7E.3040404@xenomai.org>
Date: Sat, 15 Dec 2012 13:35:10 +0100
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


Maybe the documentation is not clear enough, but you have to make the
changes to multiplexed GPIO irq handlers, otherwise all hell will break
loose when such an irq will happen, even in the absence of real-time
drivers.

Also, if your processor is an armv4 or armv5, you should consider
enabling the FCSE.

-- 
                                                                Gilles.

