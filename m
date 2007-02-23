Message-ID: <45DEF0FE.4010506@domain.hid>
Date: Fri, 23 Feb 2007 14:49:50 +0100
From: Steven Scholz <steven.scholz@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency hangs on AT91RM9200
References: <45DECFAF.60304@domain.hid>
In-Reply-To: <45DECFAF.60304@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Steven Scholz <steven.scholz@domain.hid>
Cc: Xenomai-core@domain.hid

Steven Scholz wrote:
> Hi,
> 
> i pick up this issue again.
> 
> I am running 2.6.19 + adeos-ipipe-2.6.19-arm-1.6-02.patch + xenomai-svn-2007-02-22
> on an AT91RM9200 (160MHz/80MHz).
> 
> When starting "latency -p 200" it runs for a while printing
> 
> RTT|  00:05:37  (periodic user-mode task, 200 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
> RTD|      11.200|     139.200|     236.800|       1|      10.800|     280.800
> RTD|      11.200|     146.400|     253.200|       1|      10.800|     280.800
> RTD|      11.200|     144.400|     240.400|       1|      10.800|     280.800
> 
> but then hangs. The timer LED stops blinking. No "soft lockup detected" appears.

Easy to reproduce with

~ # cat /dev/zero > /dev/null &
~ # latency -p 200

--
Steven

