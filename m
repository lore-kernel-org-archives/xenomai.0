MIME-Version: 1.0
In-Reply-To: <55CED222.8040901@siemens.com>
References: <CAKC9m6f5Yc7MZHZQO2MRCf+y2nOM7P1psX4fLTeqgE4tsnv+RA@mail.gmail.com>
 <20150813191157.GG28709@hermes.click-hack.org>
 <CAKC9m6cKtcwx_tYvWVnqNrFMxxN5=0azmLcqPwzuN_ZBX1Kh8A@mail.gmail.com>
 <55CED222.8040901@siemens.com>
From: Hongfei Cheng <hongfei@mperpetuo.com>
Date: Tue, 18 Aug 2015 10:37:40 -0700
Message-ID: <CAKC9m6f8zTh84Ks1pf1+LA-Z0P=gK-XQENMeszRikKzudZDRsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] I-pipe's determinism in handling hardware interrupts
 when GIC implements "Security Extensions"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai Mailing List <xenomai@xenomai.org>

On Fri, Aug 14, 2015 at 10:46 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 2015-08-14 22:38, Hongfei Cheng wrote:
>>> If, like I believe,
>>> such a "privileged interrupt" is handled by the monitor behind
>>> Linux/I-pipe's back, then yes, it will break determinism.
>>
>> Do you have any suggestion as to how I-pipe can be improved to work
>> with ARM's multiple exception levels in order to ensure determinism on
>> ARMv7 (and ARMv8)?
>
> Conceptually, this is fairly similar to the SMM on x86. But, in contrast
> to that arch, we tend to have the firmware sources on ARM.
>
> You can check if you actually need the secure monitor on our platform
> (it's most often used for PSCI) and disable it (may be trickier on ARMv8
> where PSCI is mandatory IIRC) or patch it or the kernel to avoid the
> problematic service calls (specifically CPU power control via PSCI).
>
> Jan

Thanks for the suggestion, Jan.

You're right -- PSCI is an integral part of ARMv8 Linux kernel.
Besides, secure apps other than PSCI-based CPU power management rely
on the secure monitor, such as firmware verification and user
authentication.

I don't know the details of x86's SMM. Based on my quick reading, it
does appear to have similar effect as ARM in terms of privileged
interrupts. On ARMv7/8, such privileged interrupts can be routed to
secure applications in either secure OS or non-secure OS.

Since SMM has been in the x86 arch for a very long time, how do you
manage to maintain I-pipe's determinism on SMM-enable x86 platform? Is
this one of the reasons that I-pipe requires disabling power
management features (cpu-freq scaling, cpu-idle, hot-plug)?

Hongfei

