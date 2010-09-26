MIME-Version: 1.0
In-Reply-To: <4C9E6C21.8010403@domain.hid>
References: <AANLkTimFXFr48DgXSj=53pNjAQB7w+mjOwwuEYQXc3KV@mail.gmail.com>
	<4C9D0A94.9030501@domain.hid>
	<AANLkTikQi1+5F5e5x1om=4HMqmwc9twJ+ZtK-kWN8gnD@mail.gmail.com>
	<4C9DB383.1050606@domain.hid>
	<AANLkTikR8pc1w27pi11wA7rS-K6C3wzSQXkE33iKHfcX@mail.gmail.com>
	<4C9E6C21.8010403@domain.hid>
Date: Sun, 26 Sep 2010 13:37:16 +0200
Message-ID: <AANLkTimte2sxk535RfQ4M7b2gT4v1PJAzUiVB_nh7-zO@mail.gmail.com>
From: Gajamohan Mohanarajah <gajamohan.m@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] switchtest/xeon-test fails: Help needed
 (Ubuntu/Core i7)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,

Thanks a lot!  With XENO_OPT_SYS_STACKPOOLSZ set to 1024 and then
setting it up along the wiki instructions worked fine. (no error on
kern.log and switch test works fine too)

But, when ACPI is enabled (but CONFIG_ACPI_PROCESSOR is not set) and
with an AHCI bios setting, while booting it drops to initramfs shell
saying [Gave up waiting for root device.. /dev/disk/by-uuid/.... does
not exist. Dropping to shell !].

Please Note:
1. I couldn't reproduce this problem with an ubuntu kernel (without
Xenomai patch) ACPI enabled, CONFIG_ACPI_PROCESSOR  not set and AHCI
on bios.
2. cat /proc/modules shows an [ahci] on initramfs/busybox
3. root=3D/dev/sda1 on grep config instead of uuid also did not help.

Thank you,
Gajan

On 25 September 2010 23:39, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Gajamohan Mohanarajah wrote:
>> Hi Gilles,
>>
>> On 25 September 2010 10:32, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> Gajamohan Mohanarajah wrote:
>>>>> You can also configure your kernel to only keep what is needed for yo=
u
>>>>> real-time system. In any case, please make sure to take a look at:
>>>>> http://www.xenomai.org/index.php/Configuring_x86_kernels
>>>> I will double check once I solve the switchtest error.
>>> Please check this first.
>> I went through the x86 config page and FAQ. =A0There was one change
>> regarding the CPU family I had to do.
>> Since mine is an i7 (/proc/cpuinfo: cpu family 6) i changed the
>> processor family to Core 2 / newer xeon (The help text said this is
>> for cpu families 6 and 15). But native skin init fails with this
>> option. Please note that this didn't happen when generic-X86_64 was
>> selected.
>
> You also have ACPI disabled whereas you should not. The issue you see is
> an allocation failure.
>
> Now that I think about it, when you increased XENO_OPT_SYS_STACKPOOLSZ
> to solve the original issue, you probably changed some other option,
> because the second error you had when relaunching switchtest happens
> earlier than the first one in the program execution. So, you should
> restart from the first configuration file, and only change the
> XENO_OPT_SYS_STACKPOOLSZ option.
>
> And now that I think about it(2), the error is probably due to the size
> you pass to XENO_OPT_SYS_STACKPOOLSZ, the size you ask is passed
> directly to kmalloc, so 9192 is really too large. I think you can forget
> about running switchtest on your platform, switchtest is more a
> maintainer tool anyway. Check latency instead.
>
>> Also note that enabling SMI workaround did not help.
>
> Err, what has SMI workaround to do with this? SMI workaround helps
> solving latency issues, not configuration issues.
>
>> Sep 25 22:55:00 totoro kernel: [ =A0 =A01.161571] WARNING: at
>> mm/page_alloc.c:1806 __alloc_pages_nodemask+0x607/0x6d0()
> (...)
>> __get_free_pages+0xe/0x50
> (...)
>> Sep 25 22:55:00 totoro kernel: [ =A0 =A01.161607] =A0[<ffffffff810f466b>=
]
>> xnpod_init+0x27b/0x3c0
>
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.
>

