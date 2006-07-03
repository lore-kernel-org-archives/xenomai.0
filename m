Message-ID: <44A92FC5.3000900@domain.hid>
Date: Mon, 03 Jul 2006 14:55:01 +0000
From: "s.a." <sancelot@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] xeno task debigging
References: <44A519C4.3080900@domain.hid> <44A50553.9010200@domain.hid>
	<b647ffbd0606300804q28d0f070o30e93cc00db2b87a@domain.hid>
In-Reply-To: <b647ffbd0606300804q28d0f070o30e93cc00db2b87a@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org


Yes, it is.
However, this kind of problem happens easily with a Pentium III @ 700Mhz
and never with a celeron @1.3Ghz !



Dmitry Adamushko wrote:
> Hi,
>
> do you mean that your rt tasks work fine until you press Ctrl-Alt-FN
> to switch virtual terminals?
>
> well, it's pretty enough information at least to point out the code
> that caused a problem in question :)
>
> it seems to be "sysexit" in entry.S, namely the following block
>
> /* if something modifies registers it must also disable sysexit */
>       EMULATE_ROOT_IRET(sysenter_exit)
>        movl EIP(%esp), %edx
>        movl OLDESP(%esp), %ecx
>        xorl %ebp,%ebp
>        sti
> ->     sysexit
>
> Looking at dumped register values :
>
> edx == ffffe410 that stands for some code inside "vsyscall page" -
> [fffe000, ffff0000]. I suppose the next instruction after "sysenter".
>
> ecx - a pointer to user-space stack of the task that issued a syscall
> through "vsyscall page". it's 0xb7d1223c and at least we may say it
> belongs to user-space (but can point to something invalid).
>
> this is exactly what "sysexit" expects to find in edx and ecx, namely
> EIP and ESP.
>
> Then let's look at the "code":
>
> Code: 44 24 18 e8 81 ca 03 00 fb 8b 4d 08 66 f7 c1 ff fe 0f 85 4e 01 00
> 00 e8 ed ea 00 00 8b 44 24 18 8b 54 24 28 8b 4c 24 34 31 ed fb <0f> 35
> 50 fc 06 1e 50 55 57 56 52 51 53 ba 7b 00 00 00 8e da 8e
>
> <0f> 35 seems to be the current instruction and this is an opcode for
> "sysexit" on e.g. AMD aa64 (google helps :)
>
> The following also confirms that:
> EIP is at sysenter_exit+0xf/0x11
>
> EIP points to last 2 bytes of sysenter_exit and that's "sysexit".
>
> I tried to find what exactly "sysexit" does and when/why it may fault
> but failed so far. e.g. if ecx is wrong (points to non-existent vma).
>
> It's also interesting that 2 tasks get GPF, both returning from some
> syscall.
>
> Maybe Philippe who (I suppose) introduced sysenter/exit support for
> Adeos/ipipe can shed some light.
>
>


