MIME-Version: 1.0
In-Reply-To: <CAFkYNwa-XGD+JM-5w6EGepO8XG2Ki9Tt+ocqgcd_zNmPCngdyA@mail.gmail.com>
References: <CAFkYNwZV3xY_QU5E+zdFNGeeM=O4jo897wppbGCg40HumoojBQ@mail.gmail.com>
 <5600F8DE.30705@xenomai.org>
 <CAFkYNwaW5+nnDmumwt_zFFn01oWY5CsS5Fbmj1wB0aPF7om-4w@mail.gmail.com>
 <20150922174455.GA13976@hermes.click-hack.org>
 <CAFkYNwa-XGD+JM-5w6EGepO8XG2Ki9Tt+ocqgcd_zNmPCngdyA@mail.gmail.com>
Date: Wed, 23 Sep 2015 13:21:55 +1200
Message-ID: <CAFkYNwazPQ1D98f5xEyAh0CgYfE1ddkxxK_paF4v7YN_hbkT5Q@mail.gmail.com>
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

On 23 September 2015 at 12:41, vibnwis <vibnwis@gmail.com> wrote:

>
>
> On 23 September 2015 at 05:44, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
>
>> On Wed, Sep 23, 2015 at 12:32:11AM +1200, vibnwis wrote:
>> > By regenerating ./configure using autoreconf -fi, I managed to compile
>> > xenomai-3-3.0-rc7 natively on PandaBoard. All things are put in their
>> own
>> > place by make install. However, when running latency, it produces
>> >
>> > > latency
>> > 0"000.000| BUG in low_init(): [main] mlockall: Cannot allocate memory
>>
>> You should either run the latency test as root, or have a look at
>> this page:
>>
>> http://xenomai.org/2014/06/running-a-xenomai-application-as-a-regular-user/
>
>
Referring to the link, I have the following outcomes.
/dev/rtpipe <- not exist

/sys/module/xenomai/parameters/allowed_group <- not exist as well

tried with the following commands:

ubuntu@arm:/usr/xenomai/bin$ sudo find /sys/module -type f -name
"allowed_group" -print
[sudo] password for ubuntu:
<nothing came back>

ubuntu@arm:/usr/xenomai/bin$ sudo find /sys/module -type f -name
"parameters" -print
<nothing came back>

Any idea what/where went wrong?


>
>>
>> By root I get this.
> root@arm:/usr/xenomai# latency
>    0"000.000| BUG in low_init(): [main] binding failed: Function not
> implemented
>
> However, the PATH has set the Lib
>
> root@arm:/usr/xenomai# echo $PATH
>
> /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/xenomai/bin:/usr/xenomai/lib:/usr/xenomai/include
>
>
>>
>> > > dmesg | grep -i ipipe
>> > [    0.000000] Linux version 3.18.20-ipipe (qws@qws-MacBookPro) (gcc
>> > version 4.9.2 (Ubuntu/Linaro 4.9.2-10ubuntu10) ) #1 SMP Tue Sep 22
>> 21:04:49
>> > NZST 2015
>> > [    0.623763] 3.18.20-ipipe #1 Not tainted
>> > [    0.623994]   [<c00d3094>] __ipipe_do_sync_stage+0x288/0x2d0
>> > [    0.624011]   [<c0008634>] __ipipe_grab_irq+0x5c/0x70
>> > [    0.624321] CPU: 1 PID: 22 Comm: kblockd Not tainted 3.18.20-ipipe #1
>> > [    0.624479] [<c00843b4>] (trace_hardirqs_on_caller) from [<c05da7f4>]
>> > (__ipipe_fast_svc_irq_exit+0x4/0x18)
>> > [    0.624504] [<c05da7f4>] (__ipipe_fast_svc_irq_exit) from
>> [<c001aacc>]
>> > (ipip_test_and_stall_root+0x2c/0x3c)
>> > [    0.624524] [<c001aacc>] (ipipe_test_and_stall_root) from
>> [<c0086e58>]
>> > (lock_acquire+0x44/0x108)
>> > [    0.728394] Switched to clocksource ipipe_tsc
>> > [    2.464800] usb usb1: Manufacturer: Linux 3.18.20-ipipe ehci_hcd
>> > [    6.364516] usb usb2: Manufacturer: Linux 3.18.20-ipipe musb-hcd
>>
>> Please post the full kernel logs. You likely enabled a kernel
>> configuration option which has an issue with CONFIG_IPIPE
>>
> Please find it in attachment. Many thanks (very grateful indeed)
>
>>
>> --
>>                                             Gilles.
>> https://click-hack.org
>>
>
>
