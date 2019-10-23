MIME-Version: 1.0
References: <CAJPjb1LG3HTfUC0FFDATAkb3-6f=nj5J+6d+gdLL3yAwxt8avQ@mail.gmail.com>
 <9224513f-51e2-1ddb-107f-58a1142b3085@siemens.com>
 <CAJPjb1+d___e1BE3tk=us9WAr0HcW3QC5ROgWaRUMPXngudqpQ@mail.gmail.com>
 <8148a617-8087-076e-f1f1-bd337e2c7a14@siemens.com>
 <CAJPjb1KgLBHRq+myFgWATpOYi3ifUahj5G2f9VQe7YKgr0UhVQ@mail.gmail.com>
 <CAJPjb1KwBgJp+Zx2CKjCK2y8C6Omj43EQCSm2CnSffbZ01AOSg@mail.gmail.com>
 <CAJPjb1JYRu493q_zpBKDLRS9HhcGb-4YvZqr12nuQN0_JwC4gA@mail.gmail.com>
In-Reply-To: <CAJPjb1JYRu493q_zpBKDLRS9HhcGb-4YvZqr12nuQN0_JwC4gA@mail.gmail.com>
From: Rob Miller <rob.miller@broadcom.com>
Date: Wed, 23 Oct 2019 17:23:41 -0400
Message-ID: <CAJPjb1+qSBrqC5FX5j5E9awpBT6y6Z_wz8+oPR_=hQP_RsnBvA@mail.gmail.com>
Subject: Re: Xenomai fails to start when running in QEMU VM
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Correction, stock images work by removing the enable-kvm and *NOT *adding
the -no-hpet QEMU cmdline options.

also latency numbers are crazy with avg being 1678.126 usec w/ worst case
being 15463.240usec

at this point, I'm not sure which way to go:

1) do I hunt down issues in HPET failing w/ KVM mode enabled?
2) just go to dovetail
3) ???


Rob Miller
rob.miller@broadcom.com
(919)721-3339


On Wed, Oct 23, 2019 at 5:02 PM Rob Miller <rob.miller@broadcom.com> wrote:

> Downgrading to 3.1.0 doesn't help
>
> so in summary, removing the enable-kvm cmdline option and adding -no-hpet
> seems to allow Xenomai to startup at least. Will now start the latency
> tests, ect...
>
> Rob Miller
> rob.miller@broadcom.com
> (919)721-3339
>
>
> On Wed, Oct 23, 2019 at 3:52 PM Rob Miller <rob.miller@broadcom.com>
> wrote:
>
>> I found that if I remove the -enable-kvm and add -no-hpet, I'm able to
>> get Xenomi up-n-running on the stock xenomai-images. Adding -no-hpet alone
>> didn't help. Also, when the enable-kvm is disabled, the bootup time is
>> ~10-20 slower, but does boot.
>>
>> Further, just removing the enable-kvm flag, results in the stock image
>> never booting...or at least I gave up after 5 min's waiting.
>>
>> I will try to downgrade QEMU to 3.1.0
>>
>> Rob Miller
>> rob.miller@broadcom.com
>> (919)721-3339
>>
>>
>> On Wed, Oct 23, 2019 at 12:07 PM Rob Miller <rob.miller@broadcom.com>
>> wrote:
>>
>>> Mine a little newer
>>>
>>> QEMU emulator version 4.0.50
>>> Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers
>>>
>>> Rob Miller
>>> rob.miller@broadcom.com
>>> (919)721-3339
>>>
>>>
>>> On Wed, Oct 23, 2019 at 9:26 AM Gylstorff Quirin via Xenomai <
>>> xenomai@xenomai.org> wrote:
>>>
>>>>
>>>>
>>>> On 10/23/19 2:48 PM, Rob Miller via Xenomai wrote:
>>>> > Interestingly, I also get the exact same failure on the xenomai-images
>>>> > pulled from the git repo.
>>>> >
>>>> > the errors start right off the bat with:
>>>> >
>>>> > tsc: Fast calibration failed
>>>> > tsc: Unable to calibrate against PIT
>>>> > tsc: No reference (HPET/PMTIMER) available
>>>> > ..
>>>> > ..
>>>> > clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff,
>>>> max_idle_ns:
>>>> > 19112604467 ns
>>>> > hpet clock event registered
>>>> > tsc: Fast calibration failed
>>>> > tsc: Unable to calibrate against PIT
>>>> > tsc: No reference (HPET/PMTIMER) available
>>>> > tsc: Marking TSC unstable due to could not calculate TSC khz
>>>> <---
>>>> > kiss of death I believe as Cobalt sees the flag and errors out
>>>> > ..
>>>> > ..
>>>> > hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
>>>> > hpet0: 3 comparators , 64-bit 100.000000 MHz counter
>>>> > clocksource: Switched to clocksource hpet
>>>> > ..
>>>> > ..
>>>> > [Xenomai] scheduling class idle registered
>>>> > [Xenomai] scheduling class weak registered
>>>> > [Xenomai] scheduling class tp registered
>>>> > [Xenomai] scheduling class pss registered
>>>> > [Xenomai] scheduling class quota registered
>>>> > [Xenomai] scheduling class rt registered
>>>> > I-pipe: high-resolution clock not working               <--- I
>>>> believe this
>>>> > looks at the TSC marked as being unstable flag set above and bails out
>>>> > [Xenomai] init failed, code -19
>>>> >
>>>> > I dug into the unstable issues on my VM (ie: non xenomai-images
>>>> repo), and
>>>> > found that tsc_read_refs(*ref, hpet) is where the problem lies in
>>>> either
>>>> > whether using using hpet or not, either the returned ref value is 0
>>>> (when
>>>> > hpet == 1), or the amount of time is took to read from PM (hpet == 0)
>>>> took
>>>> > forever (ie: 100000+ cycles) which is at least 2x the SMI_THRESHOLD
>>>> vlaue
>>>> > that is allowed in the code. My guess is that even when using the
>>>> stock
>>>> > xenomai-images directly, I'll have the same situation.
>>>> >
>>>> > I read about SMI issues, and given the cycle allowance for SMI
>>>> > interruptions in the tsc_read_refs() functio, I focused on SMI. In my
>>>> VM
>>>> > (ie: non-stock images), I set the linux cmdline option
>>>> > xenomai.smi=disabled, but no love there either.
>>>> >
>>>> > Given that both my VM and the stock images fail, I'm now thinking QEMU
>>>> > version, or underlying host CPU issues, or TBD, is the issue, and
>>>> thought
>>>> > I'd first ask the community for guidance as to how to proceed.
>>>> >
>>>> > Thoughts ideas will be greatly appreciated.
>>>> >
>>>> What qemu version do you use?
>>>>
>>>> For our tests we use
>>>> QEMU emulator version 3.1.0 (Debian 1:3.1+dfsg-8+deb10u2).
>>>>
>>>>
>>>> Quirin
>>>>
>>>> --
>>>> Siemens AG
>>>> Corporate Technology
>>>> CT RDA IOT SES-DE
>>>>
>>>>
>>>>
>>>>
