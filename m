Message-ID: <4C3EF9EB.2080301@domain.hid>
Date: Thu, 15 Jul 2010 14:07:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTilAdUGrkep3tlofYpRYxEOto2XpM29NWA_F4_7g@domain.hid>	<4C3EF4A1.3090805@domain.hid>	<AANLkTik0R1eoCbOH9aJ4ccjzvW9STZTvh_bTOWt4u07K@mail.gmail.com>
	<AANLkTilZF4rUb82Cy8DBANm2qKG-nvtbBhBHP1HIRYmW@mail.gmail.com>
In-Reply-To: <AANLkTilZF4rUb82Cy8DBANm2qKG-nvtbBhBHP1HIRYmW@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai Compilation error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: PREMRAJ SV <svprem20@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

PREMRAJ SV wrote:
> On Thu, Jul 15, 2010 at 11:54 AM, PREMRAJ SV <svprem20@domain.hid> wrote:
> 
>> Hi Gilles, I am new to Xenomai.. which linux kernel version is compatible
>> with xenomai 2.5.3 i am using linux-2.6.28 for patching xenomai..shall i use
>> the same kernel version...
>>
>   Let me know Where can i find APIC options while configuring, to disable...
> 

As explained in ksrc/arch/x86/patches/README, we try to maintain
compatibility with past releases of the kernel. However, if you are
starting a new project, there is little sense in using such an old
kernel as Linux 2.6.28.

To look for an option in the kernel configuration, if you are using the
QT configuration tool, use ctrl-F, if you are using the ncurses
configuration tool, use /.

For setting the options of the x86 kernel, see:
http://www.xenomai.org/index.php/FAQs#Tips_and_tricks_setting_up_your_x86_kernel

In particular, you should not select generic i686 as processor type,
neither should you disable the power management completely, you want PM
enabled, APM disabled, ACPI enabled, but ACPI_PROCESSOR disabled. It is
probably impossible to disable APIC because you are running an SMP
kernel, which can not run without an APIC. And enabling the APIC is
better anyway.

The next private mail you send me will receive no answer.

-- 
					    Gilles.

