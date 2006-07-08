Message-ID: <e325d110607080632u5d80322bte8d32d8e4828030e@domain.hid>
Date: Sat, 8 Jul 2006 14:32:33 +0100
From: "Kim Chuan Lim" <lim.kim.chuan@domain.hid>
Subject: Re: [Xenomai-help] xenomai beginner problem.
In-Reply-To: <44AEC245.7090702@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e325d110607071259g5ebc019bs2565887803265adc@domain.hid>
	<44AEC245.7090702@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hi Jan,

You are right, i got some informations from my dmesg...
Xenomai: Local APIC absent or disabled!
         Disable APIC support or pass "lapic=1" as bootparam.
Xenomai: system init failed, code -19.
Xenomai: native skin init failed, code -19.
Xenomai: starting POSIX services.
Xenomai: POSIX skin init failed, code -19.
Xenomai: RTDM skin init failed, code -19.

The following is part of my APIC kernel configuration.

# CONFIG_HPET_TIMER is not set
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_IPIPE=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y

What should i do??

Regards,
Kim Chuan.


On 7/7/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Kim Chuan Lim wrote:
> > Hi all,
> > The following is my problem...
> >
> > suse003:/usr/xenomai/testsuite/latency # ./run
> > *
> > *
> > * Type ^C to stop this application.
> > *
> > *
> > Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
> > (modprobe xeno_native?)
> > suse003:/usr/xenomai/testsuite/latency # modprobe xeno_native
> > FATAL: Module xeno_native not found.
>
> xeno_nucleus and xeno_native are by default both compiled into your
> kernel. Therefore: no modules.
>
> What does dmesg tell you regarding Xenomai? Any suspicious
> warnings/errors? I'm thinking now of the issue that local APIC is
> enabled in the kernel, but "lapic" is missing in the kernel command
> line. The kernel messages should indicate this.
>
> >
> > i'm using an old pentium 3 1GHz machine with suse9.3.
> > i recently downloaded kernel 2.6.17 from kernel.org and patch it with
> > xenomai trunk.
> >
> > May i know what is my problem??
> > Is it i didnt setup my kernel probably?
> >
> > The following is the result of my locate..
> >
> > locate xeno_native
> > /home/username/linux-2.6.17.4/kernel/xenomai/skins/native/.xeno_native.o.cmd
> >
> > /home/username/linux-2.6.17.4/kernel/xenomai/skins/native/xeno_native.o
> >
> > How can i load the xeno_native manually?
>
> Check you kernel configuration if this is really needed - I bet not.
>
> Jan
>
>
>
>

