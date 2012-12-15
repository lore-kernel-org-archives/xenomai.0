Message-ID: <50CC8F3E.30908@xenomai.org>
Date: Sat, 15 Dec 2012 15:54:54 +0100
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
> Question : If the address in the tsc_info struct were incorrect,

> there would be a hang?


If you are accessing another timer register, the processor will not
hang, what you read is simply not the hardware counter.

Anyway, I also asked you to run the "tsc" test, what does this test tell
you?

-- 
                                                                Gilles.

