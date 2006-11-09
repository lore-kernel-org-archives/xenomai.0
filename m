Message-ID: <45533755.1000201@domain.hid>
Date: Thu, 09 Nov 2006 15:12:37 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Strange results with latency test
References: <20061109133632.GA4205@domain.hid>
In-Reply-To: <20061109133632.GA4205@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Matthias Fechner wrote:
> Hi,
> 
> I tested today Xenomai on my AMD64 (32-bit mode) with the latency
> program from the testsuite and I got for lat min negative values.
> 
> Can my computer predict the future? :)

Of course, the timer is programmed a bit in advance taking into account 
some average latency, like code run time, HW latencies, etc. It is 
system dependent.

> How can I interpret these values?
> 
> 100 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...
> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
> RTD|      -1.337|      -0.958|       0.970|       0|      -1.337| 0.970
> RTD|      -1.290|      -0.907|       1.959|       0|      -1.337| 1.959
> ...
> RTD|      -1.406|      -0.923|       1.884|       0|      -1.468| 4.358
> ---|------------|------------|------------|--------|-------------------------
> RTS|      -1.468|      -0.922|       4.358|       0| 00:00:34/00:00:34

Add the value listed by 'cat /proc/xenomai/latency` to the above figures 
or set the latency to "1 ns" with 'echo "1" > /proc/xenomai/latency'.

Wolfgang.


