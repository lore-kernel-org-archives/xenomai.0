MIME-Version: 1.0
In-Reply-To: <CAFkYNwZoEEiezx1Ny+s2WXgx5xP471A1BrVEnJJ9hukjyEv4-Q@mail.gmail.com>
References: <CAFkYNwZV3xY_QU5E+zdFNGeeM=O4jo897wppbGCg40HumoojBQ@mail.gmail.com>
 <5600F8DE.30705@xenomai.org>
 <CAFkYNwaW5+nnDmumwt_zFFn01oWY5CsS5Fbmj1wB0aPF7om-4w@mail.gmail.com>
 <20150922174455.GA13976@hermes.click-hack.org>
 <CAFkYNwa-XGD+JM-5w6EGepO8XG2Ki9Tt+ocqgcd_zNmPCngdyA@mail.gmail.com>
 <20150923053843.GD13976@hermes.click-hack.org>
 <20150923070615.GI13976@hermes.click-hack.org>
 <CAFkYNwYta4TDofpKcGfkH4xUB0udKg8Q721T97LTD6ua_5MWjg@mail.gmail.com>
 <20150923115911.GB28513@hermes.click-hack.org>
 <CAFkYNwZoEEiezx1Ny+s2WXgx5xP471A1BrVEnJJ9hukjyEv4-Q@mail.gmail.com>
Date: Thu, 24 Sep 2015 01:26:31 +1200
Message-ID: <CAFkYNwbRx9ZK10_F7XfcP7U0uNBafY=xA7H_TbxbBj7CxpETrQ@mail.gmail.com>
From: vibnwis <vibnwis@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Xenomai tests
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 24 September 2015 at 00:42, vibnwis <vibnwis@gmail.com> wrote:

>
>
> On 23 September 2015 at 23:59, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
>
>> On Wed, Sep 23, 2015 at 11:29:21PM +1200, vibnwis wrote:
>> > On 23 September 2015 at 19:06, Gilles Chanteperdrix <
>> > gilles.chanteperdrix@xenomai.org> wrote:
>> >
>> > > On Wed, Sep 23, 2015 at 07:38:43AM +0200, Gilles Chanteperdrix wrote:
>> > > > On Wed, Sep 23, 2015 at 12:41:38PM +1200, vibnwis wrote:
>> > > > > On 23 September 2015 at 05:44, Gilles Chanteperdrix <
>> > > > > gilles.chanteperdrix@xenomai.org> wrote:
>> > > > >
>> > > > > > On Wed, Sep 23, 2015 at 12:32:11AM +1200, vibnwis wrote:
>> > > > > > > By regenerating ./configure using autoreconf -fi, I managed to
>> > > compile
>> > > > > > > xenomai-3-3.0-rc7 natively on PandaBoard. All things are put
>> in
>> > > their own
>> > > > > > > place by make install. However, when running latency, it
>> produces
>> > > > > > >
>> > > > > > > > latency
>> > > > > > > 0"000.000| BUG in low_init(): [main] mlockall: Cannot allocate
>> > > memory
>> > > > > >
>> > > > > > You should either run the latency test as root, or have a look
>> at
>> > > > > > this page:
>> > > > > >
>> > >
>> http://xenomai.org/2014/06/running-a-xenomai-application-as-a-regular-user/
>> > > > > >
>> > > > > > By root I get this.
>> > > > > root@arm:/usr/xenomai# latency
>> > > > >    0"000.000| BUG in low_init(): [main] binding failed: Function
>> not
>> > > > > implemented
>> > > > >
>> > > > > However, the PATH has set the Lib
>> > > >
>> > > > Running as root was necessary to avoid the mlockall issue. The issue
>> > > > you have now is different: the logs you sent show that the last
>> > > > kernel you booted is not patched with Xenomai. The kernel is patched
>> > > > with the I-pipe patch, but this is not sufficient, it is not
>> > > > prepared with prepare-kernel.sh
>> > > >
>> > > > >
>> > > > > root@arm:/usr/xenomai# echo $PATH
>> > > > >
>> > >
>> /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/xenomai/bin:/usr/xenomai/lib:/usr/xenomai/include
>> > > > >
>> > > > >
>> > > > > >
>> > > > > > > > dmesg | grep -i ipipe
>> > > > > > > [    0.000000] Linux version 3.18.20-ipipe (qws@qws-MacBookPro
>> )
>> > > (gcc
>> > > > > > > version 4.9.2 (Ubuntu/Linaro 4.9.2-10ubuntu10) ) #1 SMP Tue
>> Sep 22
>> > > > > > 21:04:49
>> > > > > > > NZST 2015
>> > > > > > > [    0.623763] 3.18.20-ipipe #1 Not tainted
>> > > > > > > [    0.623994]   [<c00d3094>]
>> __ipipe_do_sync_stage+0x288/0x2d0
>> > > > > > > [    0.624011]   [<c0008634>] __ipipe_grab_irq+0x5c/0x70
>> > > > > > > [    0.624321] CPU: 1 PID: 22 Comm: kblockd Not tainted
>> > > 3.18.20-ipipe #1
>> > > > > > > [    0.624479] [<c00843b4>] (trace_hardirqs_on_caller) from
>> > > [<c05da7f4>]
>> > > > > > > (__ipipe_fast_svc_irq_exit+0x4/0x18)
>> > > > > > > [    0.624504] [<c05da7f4>] (__ipipe_fast_svc_irq_exit) from
>> > > [<c001aacc>]
>> > > > > > > (ipip_test_and_stall_root+0x2c/0x3c)
>> > > > > > > [    0.624524] [<c001aacc>] (ipipe_test_and_stall_root) from
>> > > [<c0086e58>]
>> > > > > > > (lock_acquire+0x44/0x108)
>> > > > > > > [    0.728394] Switched to clocksource ipipe_tsc
>> > > > > > > [    2.464800] usb usb1: Manufacturer: Linux 3.18.20-ipipe
>> ehci_hcd
>> > > > > > > [    6.364516] usb usb2: Manufacturer: Linux 3.18.20-ipipe
>> musb-hcd
>> > > > > >
>> > > > > > Please post the full kernel logs. You likely enabled a kernel
>> > > > > > configuration option which has an issue with CONFIG_IPIPE
>> > > > > >
>> > > > > Please find it in attachment. Many thanks (very grateful indeed)
>> > > >
>> > > > Ok, when I say "please post the full kernel logs", I mean only the
>> > > > logs of the kernel currently running, not the logs of previous
>> > > > kernel runs, these are irrelevant. Anyway, I think you have
>> > > > CONFG_CONTEX_TRACKING enabled, which does not work with
>> > > > CONFIG_IPIPE, at least on ARM. Could you post you kernel
>> > > > configuration to be sure?
>> > >
>> > > The problematic option is CONFIG_TRACE_IRQFLAGS, not
>> > > CONFIG_CONTEXT_TRACKING, and you have it enabled, since without it,
>> > > you would not be able to enable CONFIG_LOCKDEP. Please disable
>> > > CONFIG_TRACE_IRQFLAGS. You will need to disable all the options
>> > > depending on that option, such as CONFIG_LOCKDEP.
>> > >
>> >
>> > Spent hours looking for the item in kernel config (make menuconfig), but
>> > could find any. Would you please share where that is, please?
>>
>> In make menuconfig type the / key, then type "lockdep".
>>
>
> Many thanks. Under kernel hacking, I disable everything in there, yet the
> CONFIG_TRACE_IRQFLAGS and CONFIG_LOCKDEP remain unchanged. FYI, I used
> omap2plus_defconfig. Would it be the cause of that?
>

To do a quick test if these CONFIG_LOCKDEP_SUPPORT
CONFIG_TRACE_IRQFLAGS_SUPPORT ever able to be changed. I simply turn off
everything in make menuconfig. I mean everything and these two flags are
still there unchanged.
FYI, I had the .config opened in a editor. Whenever changes were made, it
would prompt in the editor to reload the contents.

>
>> --
>>                                             Gilles.
>> https://click-hack.org
>>
>
>
