Date: Tue, 22 Sep 2015 19:44:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150922174455.GA13976@hermes.click-hack.org>
References: <CAFkYNwZV3xY_QU5E+zdFNGeeM=O4jo897wppbGCg40HumoojBQ@mail.gmail.com>
 <5600F8DE.30705@xenomai.org>
 <CAFkYNwaW5+nnDmumwt_zFFn01oWY5CsS5Fbmj1wB0aPF7om-4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFkYNwaW5+nnDmumwt_zFFn01oWY5CsS5Fbmj1wB0aPF7om-4w@mail.gmail.com>
Subject: Re: [Xenomai] Xenomai tests
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: vibnwis <vibnwis@gmail.com>
Cc: xenomai@xenomai.org

On Wed, Sep 23, 2015 at 12:32:11AM +1200, vibnwis wrote:
> By regenerating ./configure using autoreconf -fi, I managed to compile
> xenomai-3-3.0-rc7 natively on PandaBoard. All things are put in their own
> place by make install. However, when running latency, it produces
> 
> > latency
> 0"000.000| BUG in low_init(): [main] mlockall: Cannot allocate memory

You should either run the latency test as root, or have a look at
this page:
http://xenomai.org/2014/06/running-a-xenomai-application-as-a-regular-user/


> > dmesg | grep -i ipipe
> [    0.000000] Linux version 3.18.20-ipipe (qws@qws-MacBookPro) (gcc
> version 4.9.2 (Ubuntu/Linaro 4.9.2-10ubuntu10) ) #1 SMP Tue Sep 22 21:04:49
> NZST 2015
> [    0.623763] 3.18.20-ipipe #1 Not tainted
> [    0.623994]   [<c00d3094>] __ipipe_do_sync_stage+0x288/0x2d0
> [    0.624011]   [<c0008634>] __ipipe_grab_irq+0x5c/0x70
> [    0.624321] CPU: 1 PID: 22 Comm: kblockd Not tainted 3.18.20-ipipe #1
> [    0.624479] [<c00843b4>] (trace_hardirqs_on_caller) from [<c05da7f4>]
> (__ipipe_fast_svc_irq_exit+0x4/0x18)
> [    0.624504] [<c05da7f4>] (__ipipe_fast_svc_irq_exit) from [<c001aacc>]
> (ipip_test_and_stall_root+0x2c/0x3c)
> [    0.624524] [<c001aacc>] (ipipe_test_and_stall_root) from [<c0086e58>]
> (lock_acquire+0x44/0x108)
> [    0.728394] Switched to clocksource ipipe_tsc
> [    2.464800] usb usb1: Manufacturer: Linux 3.18.20-ipipe ehci_hcd
> [    6.364516] usb usb2: Manufacturer: Linux 3.18.20-ipipe musb-hcd

Please post the full kernel logs. You likely enabled a kernel
configuration option which has an issue with CONFIG_IPIPE

-- 
					    Gilles.
https://click-hack.org

