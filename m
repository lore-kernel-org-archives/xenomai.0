Message-ID: <22d09acb5430193e258d428d89390d30.squirrel@domain.hid>
Date: Mon, 18 Oct 2010 08:10:37 +0200
From: "Cagnulein" <cagnulein@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20101018081037_32220"
Subject: Re: [Xenomai-help] Error building xenomai 2.5.5.1 on kubuntu 10.10
 64	bit
Reply-To: cagnulein@domain.hid
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

------=_20101018081037_32220
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: Quoted-Printable

I've never seen this bug (i've never compiled under a x86_64) but i
guess it's probably related to this one:
-
http://git.xenomai.org/?p=3Dipipe-gch.git;a=3Dcommit;h=3Ddd17c8f72993f946=
1e9c19250e3f155d6d99df22
and so the solution it might be this one:
-
http://git.xenomai.org/?p=3Dipipe-gch.git;a=3Dcommitdiff;h=3D1154fab73ccb=
ab010cfaa272b6987c624cfd63c6

Let me know if i can help you more.
Ciao :)
Roberto

On 17/10/2010 20:12, gprizzi@domain.hid wrote:
>  Hello everyone,
>
>  I am a new user of xenomai.
>  I am trying to install xenomai on a system with the following
> characteristics:
>
>  - Intel Q6600
>  - Kubuntu 10.10 - 64 bits version
>  - linux kernel 2.6.35.7
>  - xenomai 2.5.5.1
>  - ggc  compiler version (Ubuntu/Linaro 4.4.4-14ubuntu5) 4.4.5
>
>
> I followed the instructions for "Buildin Debian packages" from
> xenomai.org.
> Everything was OK till applying patch to kernel.
>
> After that I tried to build the kernel executing the following command:
>
> CONCURRENCY_LEVEL=3D2 CLEAN_SOURCE=3Dno fakeroot make-kpkg --initrd
--append-to-version -xenomai-2.5.5.1 --revision 1.0 kernel_image
kernel_headers
>
> but i get the following errors and build fails.
>
>
>
>
>
>
>
>
>
> CC      kernel/xenomai/nucleus/pod.o
> In file included from
/home/giampy/linux-2.6.35.7/arch/x86/include/asm/xenomai/bits/pod.h:4,
>                   from kernel/xenomai/nucleus/pod.c:47:
> /home/giampy/linux-2.6.35.7/arch/x86/include/asm/xenomai/bits/pod_64.h:
In function =E2=80=98xnarch_switch_to=E2=80=99:
> /home/giampy/linux-2.6.35.7/arch/x86/include/asm/xenomai/bits/pod_64.h:=
98:
error: implicit declaration of function =E2=80=98per_cpu_var=E2=80=99
> /home/giampy/linux-2.6.35.7/arch/x86/include/asm/xenomai/bits/pod_64.h:=
98:
error: lvalue required in asm statement
> /home/giampy/linux-2.6.35.7/arch/x86/include/asm/xenomai/bits/pod_64.h:=
98:
error: invalid lvalue in asm output 6
> /home/giampy/linux-2.6.35.7/arch/x86/include/asm/xenomai/bits/pod_64.h:=
98:
error: memory input 14 is not directly addressable
> /home/giampy/linux-2.6.35.7/arch/x86/include/asm/xenomai/bits/pod_64.h:
In function =E2=80=98xnarch_thread_trampoline=E2=80=99:
> /home/giampy/linux-2.6.35.7/arch/x86/include/asm/xenomai/bits/pod_64.h:=
113:
error: lvalue required in asm statement
> /home/giampy/linux-2.6.35.7/arch/x86/include/asm/xenomai/bits/pod_64.h:=
113:
error: invalid lvalue in asm output 0
> make[4]: *** [kernel/xenomai/nucleus/pod.o] Error 1
> make[3]: *** [kernel/xenomai/nucleus] Error 2
> make[2]: *** [kernel/xenomai] Error 2
> make[1]: *** [kernel] Error 2
> make[1]: *** Waiting for unfinished jobs....
>
>
> Please can anyone help me to solve this problem?
>
>
>
> Thank you in advance.
>
> Gianpaolo Rizzi
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


------=_20101018081037_32220
Content-Type: text/html; name="untitled-[2]"
Content-Disposition: attachment; filename="untitled-[2]"
Content-Transfer-Encoding: 7Bit


------=_20101018081037_32220--



