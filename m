Message-ID: <4FF43164.8010304@xenomai.org>
Date: Wed, 04 Jul 2012 14:04:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAL7_A_WEXhEBQr+LFb_mfaqLxBh=hsHJg6WiY08cmkgb=Y2TNA@mail.gmail.com>	<4FF369E5.5040007@xenomai.org>	<CAL7_A_WYVjFhh9RuxAm1jtVp7HqakB5gEzkSt8i7XsWJNJrh=Q@mail.gmail.com>	<4FF402AD.3020601@xenomai.org>	<4FF415AB.2030503@xenomai.org>
	<CAL7_A_Xr432pEEEiG4D5xsD-2yqWdgSd0tD26aEi4q0FzeWD_w@mail.gmail.com>
In-Reply-To: <CAL7_A_Xr432pEEEiG4D5xsD-2yqWdgSd0tD26aEi4q0FzeWD_w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Xenomai and normal linux application - Wait time with
 select() not reliable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?SmVucyBLw7ZobGVy?= <jenskxxx@googlemail.com>
Cc: xenomai@xenomai.org

On 07/04/2012 01:45 PM, Jens Köhler wrote:
> The Xenomai application runs every 2ms for about 150 us and sends/
> receives an udp packet.Rtnet socket is used for udp communication.
> 
> /proc/xenomai/stat:
> 
> CPU	PID	MSW	CSW	PF	STAT		%CPU  NAME
>   0	0	0	272362	0	00500080	93.8  ROOT
>   0	0	0	13475	0	00000082	0.0  rtnet-stack
>   0	0	0	1	0	00000082	0.0  rtnet-rtpc
>   0	1843	1	11677	0	00300182	0.1  SgbmReceive
>   0	1844	1	67501	0	00300184	4.7  SgbmSend
>   0	1845	63111	63304	0	00300380	0.3  SgbmUserSpaceComm
>   0	1846	1	134963	0	00300184	0.5  SgbmTimer
>   0	0	0	67500	0	00000000	0.3  IRQ19: rteth0
>   0	0	0	298425	0	00000000	0.3  IRQ233: [timer]
> 
> Application was ported from RTAI to Xenomai. With Rtai was never a
> problem with select.

What version of linux, the I-pipe patch, and xenomai are you using ?

-- 
					    Gilles.

