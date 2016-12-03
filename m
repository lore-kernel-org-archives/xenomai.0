Date: Sat, 3 Dec 2016 19:05:21 +0000 (UTC)
From: Giulio Moro <giuliomoro@yahoo.it>
Message-ID: <691807707.9610188.1480791921515@mail.yahoo.com>
In-Reply-To: <daba9179-e8ae-9eea-325f-fc7735aee1ea@xenomai.org>
References: <884477039.8840647.1480697545181.ref@mail.yahoo.com>
 <884477039.8840647.1480697545181@mail.yahoo.com>
 <daba9179-e8ae-9eea-325f-fc7735aee1ea@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] FAILURE rt_thread_body:116: no
 SIGDEBUG_MIGRATE_PRIOINV received on ARM
Reply-To: Giulio Moro <giuliomoro@yahoo.it>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks

> - the figures reported by latency

Latency results with the previously described system were
RTS| 7.872| 11.098| 54.957| 0| 0| 00:00:18/00:00:18

> - whether you enabled debug (--enable-debug) when building the user libs
> and programs?
> You may also want to make sure that debug options like
> XENO_OPT_DEBUG_LOCKING are disabled, vanilla kernel debug options
> likewise (DEBUG_LIST, IPIPE_TRACE and so on).

I previously did not specify --enable-debug.


I now rebuilt the kernel according to your recommendations (full config file here 
http://pastebin.com/fb623kSQ ), and then built the user-space library with 
--disable-debug --with-core=cobalt --enable-pshared --build=arm

Latency results have improved over the previous build:
RTS| 1.487| 6.459| 46.364| 0| 0| 00:03:19/00:03:19

With the new configuration, I do NOT get the FAILURE rt_thread_body:116 error when running xeno-test.

> - did you run the autotuner to calibrate the core clock?

I run the autotuner buy I get large variations between successive runs, so I am not sure which values I should echo to /proc/xenomai/clock/coreclk :

== auto-tuning started, period=1000000 ns (may take a while)
irq gravity... 999 ns
kernel gravity... 6499 ns
user gravity... 5999 ns
== auto-tuning completed after 21s
== auto-tuning started, period=1000000 ns (may take a while)
irq gravity... 2999 ns
kernel gravity... 5499 ns
user gravity... 6999 ns
== auto-tuning completed after 24s
== auto-tuning started, period=1000000 ns (may take a while)
irq gravity... 3499 ns
kernel gravity... 3499 ns
user gravity... 5499 ns
== auto-tuning completed after 23s
== auto-tuning started, period=1000000 ns (may take a while)
irq gravity... 999 ns
kernel gravity... 2999 ns
user gravity... 4499 ns

What do these values mean?
Are they supposed to vary so much? What can I do about it?

Thanks,
Giulio

PS: For reference, these are the latency performance on the same board with Xenomai 2.6 on Linux 3.8.13
RTS| 3.666| 6.958| 46.124| 0| 0| 00:15:10/00:15:10
(I have no way to run the autotuner there as I did not build the library myself so I don't have the utility).

