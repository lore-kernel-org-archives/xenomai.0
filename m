Message-ID: <53D0CEE7.6010208@xenomai.org>
Date: Thu, 24 Jul 2014 11:16:23 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <19C66D276CD97349B3ED15358BC387930904DECABF@Mailprodapp3.brooks.com>
In-Reply-To: <19C66D276CD97349B3ED15358BC387930904DECABF@Mailprodapp3.brooks.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Latency Test Results (xeno-test) on Xilinx Zynq XC702
 Board with Xenomai 2.6.3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Botev, Roumen" <roumen.botev@brooks.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/21/2014 08:50 PM, Botev, Roumen wrote:
> Hello, All,
> 
> I am running Xenomai's out of the box battery of tests (xeno-test) on a Xilinx Zynq XC702 evaluation board.
> 
> I am new to Xenomai and I am wondering if these results look good to people having more experience in running Xenomai on a Cortex-A9 hardware. In particular, I had higher expectations of the average and worst case latency numbers - I was expecting < 10 usec worst latency for the highest priority user mode task. Here is the summary of the latency test (the full output of the test is attached to this message):
> 
> RTT|  00:15:04  (periodic user-mode task, 1000 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
> . . . . . . . . . .
> ---|-----------|-----------|-----------|--------|------|-------------------------
> RTS|      3.675|     14.049|     35.913|       0|     0|    00:15:04/00:15:04
> 

Figures look ok particularly in dual core mode, regarding the scheduling
latency of a userland thread over a 1Khz period. A large part of such
latency is induced by cache effects, including those entailed by
switching memory contexts.

- scheduling latency for kernel threads (latency -t1) should show lower
figures, although these threads should be reserved to running
driver/RTDM tasks (i.e. not application level stuff)

- the lower the sampling frequency, the higher the latency, as the
regular linux system has more time to tread on a larger address space,
which in turn makes the real-time code a more frequent victim of cache
eviction. Running with -p 100 should get you different results (although
this may not apply to your use case anyway, just for kicks).

-- 
Philippe.

