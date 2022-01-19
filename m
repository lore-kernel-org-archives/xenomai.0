MIME-Version: 1.0
References: <CAAvDm6YgEyJuX98RzioWFTrWdY2zGDPGdptLnL9oivVHmsCZsg@mail.gmail.com>
 <CAAvDm6aoKx65CcipLG9t4MgmzKLhzkEtzAX_z23B5VUnw7iTUg@mail.gmail.com>
 <MN2PR11MB42859CE34F2CD706F90946D4F2599@MN2PR11MB4285.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB42859CE34F2CD706F90946D4F2599@MN2PR11MB4285.namprd11.prod.outlook.com>
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Wed, 19 Jan 2022 16:57:34 +0800
Message-ID: <CAAvDm6bXNK-wgKGHJ+zF=qTasRW2e9fHH5QeGkA0MvxCqS5PiA@mail.gmail.com>
Subject: Re: About the kernel configuration(CONFIG_CPU_FREQ and
 CONFIG_CPU_IDLE.)
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

> How could you find that frequency of cpu is constant or not in both
trials?
By cat /proc/cpuinfo | grep -i hz
The output looks like this when idle:
model name      : Intel(R) Core(TM) i7-8565U CPU @ 1.80GHz
cpu MHz         : 799.193

When busy:
model name      : Intel(R) Core(TM) i7-8565U CPU @ 1.80GHz
cpu MHz         : 3600.628

On Wed, Jan 19, 2022 at 2:31 PM Chen, Hongzhan <hongzhan.chen@intel.com>
wrote:

>
>
> >-----Original Message-----
> >From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of ??? sunshilong
> via Xenomai
> >Sent: Tuesday, January 18, 2022 3:18 PM
> >To: xenomai <xenomai@xenomai.org>
> >Subject: Re: About the kernel configuration(CONFIG_CPU_FREQ and
> CONFIG_CPU_IDLE.)
> >
> >Sorry, there is a clerical error in the last mail.
> >
> >>It should be
> >>"It's strange that the frequency of the CPU is not constant if I both
> >>disable CONFIG_CPU_FREQ and CONFIG_CPU_IDLE
>
> How could you find that frequency of cpu is constant or not in both trials?
>
> Regards
>
> Hongzhan Chen
>
> >whereas
> >the frequency of the CPU is constant if I only disable CONFIG_CPU_FREQ
> >                                         ^^^^^^^^^^
> >(left CONFIG_CPU_IDLE int enabled state)."
> >
> >On Tue, Jan 18, 2022 at 3:12 PM ??? sunshilong <sunshilong369@gmail.com>
> >wrote:
> >
> >> Hi, list
> >> I am using Xenomai-3.1 + Linux 4.19.84.
> >> Hardware name: UNO-2372G-J021AE.
> >>
> >> As per this official document
> >> (https://source.denx.de/Xenomai/xenomai/-/wikis/Troubleshooting#kconf),
> >> which says tells me that I should disable both CONFIG_CPU_FREQ
> >> and CONFIG_CPU_IDLE.
> >>
> >> For your convenience, the aforementioned document is listed below:
> >> >Common kernel configuration issues
> >> >When configuring the Linux kernel, some options should be avoided.
> >> >CONFIG_CPU_FREQ
> >> >CONFIG_CPU_IDLE
> >> >...
> >>
> >> It's strange that the frequency of the CPU is not constant if I both
> >> disable CONFIG_CPU_FREQ and CONFIG_CPU_IDLE
> >> whereas
> >> the frequency of the CPU is not constant if I only disable
> CONFIG_CPU_FREQ
> >> (left CONFIG_CPU_IDLE int enabled state).
> >>
> >> Could somebody please shed some light on this matter?
> >>
>
