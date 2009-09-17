MIME-Version: 1.0
In-Reply-To: <4AAAAD28.8060107@domain.hid>
References: <9b3e2dc20909111201m1b553420k5436a2da179e3279@domain.hid>
	<4AAAAD28.8060107@domain.hid>
Date: Thu, 17 Sep 2009 13:41:35 -0400
Message-ID: <9b3e2dc20909171041h56208c6aqc1cc36b3a021bc91@domain.hid>
From: Stephen Sinclair <radarsat1@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] CONFIG_NR_CPUS is too large
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

On Fri, Sep 11, 2009 at 4:03 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Stephen Sinclair wrote:
>> Hello,
>>
>> I am trying to install Xenomai. =C2=A0After patching the kernel (I have
>> tried with 2.6.29.5 and 2.6.30.5), I get the following error message:
>>
>>
>> $ make
>> scripts/kconfig/conf -s arch/x86/Kconfig
>> =C2=A0 CHK =C2=A0 =C2=A0 include/linux/version.h
>> =C2=A0 CHK =C2=A0 =C2=A0 include/linux/utsrelease.h
>> =C2=A0 SYMLINK include/asm -> include/asm-x86
>> =C2=A0 CC =C2=A0 =C2=A0 =C2=A0arch/x86/kernel/asm-offsets.s
>> In file included from include/linux/sched.h:62,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from arch/=
x86/kernel/asm-offsets_64.c:8,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from arch/=
x86/kernel/asm-offsets.c:4:
>> include/linux/ipipe.h:76:2: error: #error "CONFIG_NR_CPUS is too
>> large, please lower it."
>> make[1]: *** [arch/x86/kernel/asm-offsets.s] Error 1
>> make: *** [prepare0] Error 2
>>
>>
>> The CONFIG_NR_CPUS config variable is set to the default 64, but I
>> still get this error if I lower it to 4 or 2. =C2=A0(This is a dual-core
>> machine, AMD X2.)
>>
>> I tried commenting-out this error, just to see what would happen, but
>> I get an oops on boot. =C2=A0Setting the boot flag earlyprintk=3Dvga sho=
ws a
>> backtrace, and the crash happens immediately after
>> __ipipe_enable_irqdesc, which is in ipipe_virtualize_irq.
>>
>> I don't know how to proceed from here, does anyone know why
>> CONFIG_NR_CPUS is triggering this error?
>
> Could you post the .config that fails to build?
>
> Yeah, there is a limitation, normally 96 (IIRC). 2 or 4 CPUs is
> definitely far below it.
>
> Jan

Hello,

I finally had the time to investigate more and traced back the error
to a variable related to the number of IRQs on the system.  I should
have previously mentioned that this is a 64-bit system by the way, so
I found several related #ifdefs in irq_vector.h and apicnum.h.

Anyways, I got the kernel to compile properly after disabling the flag
CONFIG_SPARSE_IRQ.  This made the CONFIG_NR_CPUS error go away, even
after setting it back to 64.  Also, it booted successfully, so I am on
to the next stage of my project.

Although, admittedly I have no idea what the potential consequences of
turning off CONFIG_SPARSE_IRQ could be.

thanks,
Steve

