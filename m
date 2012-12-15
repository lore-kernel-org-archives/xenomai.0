Message-ID: <50CC8E3B.8030109@xenomai.org>
Date: Sat, 15 Dec 2012 15:50:35 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7385E066AECB78449EEDFA7EE2A2B2B60A052D7D@DB3PRD0410MB355.eurprd04.prod.outlook.com>,
	<50CC6B1E.8070102@xenomai.org>	<7385E066AECB78449EEDFA7EE2A2B2B60A052DA8@DB3PRD0410MB355.eurprd04.prod.outlook.com>	<50CC819F.7010009@xenomai.org>,
	<50CC83E8.1070408@xenomai.org>
	<7385E066AECB78449EEDFA7EE2A2B2B60A052DCB@DB3PRD0410MB355.eurprd04.prod.outlook.com>
In-Reply-To: <7385E066AECB78449EEDFA7EE2A2B2B60A052DCB@DB3PRD0410MB355.eurprd04.prod.outlook.com>
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

On 12/15/2012 03:42 PM, GUGLIELMO NAVARRA wrote:

> Reply for FCSE: Omap L138 is based on ARM926ejs (FCSE supported) 
> Reply for tsc_info hardcode: The DAVINCI_TIMER0_BASE macro represents
> the physical address of the timer 0 (corrected), which is 64bit timer
> that i use (unchained mode) 32bit for clockevent (BOTTOM) and 32bit
> for clocksource (TOP) . Instead "t->base" represents the virtual
> address obtained from ioremap.


The Xenomai mailing list is an old style mailing list where we do not
top-post. So, please stop top-posting.

If the virtual address of the hardware counter is t->base + t->tim_off
and
t->base is the ioremap of DAVICIN_TIMER0_BASE then the counter physical
address is:
DAVINCI_TIMER0_BASE + t->tim_off

Hence my first question (which you did not answer):
"what about t->tim_off ?"

What I said was if other SOCs or other boards use different timer
configuration where t->base is not DAVINCI_TIMER0_BASE, then you should
not hardcode DAVINCI_TIMER0_BASE in the tsc physical address, yes this
will work in your case, but not for other possible configurations.

-- 
                                                                Gilles.

