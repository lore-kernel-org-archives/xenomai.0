Message-ID: <500438EF.2050306@univ-amu.fr>
Date: Mon, 16 Jul 2012 17:53:19 +0200
From: Francois Touchard <francois.touchard@univ-amu.fr>
MIME-Version: 1.0
References: <1342430162.7582.YahooMailNeo@web120606.mail.ne1.yahoo.com>
In-Reply-To: <1342430162.7582.YahooMailNeo@web120606.mail.ne1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai 2.6.1 compiler error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jignesh Patel <jigneshj.patel@yahoo.com>
Cc: "rgupta108@gmail.com" <rgupta108@gmail.com>, "patelilesh32@gmail.com" <patelilesh32@gmail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

  Le 16/07/2012 11:16, Jignesh Patel a =E9crit :
> hi,
>
> I'm trying to compile Xenomai 2.6.1 with kernel 3.2.21 that time it gen=
erate following error...
>
>
> CC      kernel/xenomai/nucleus/heap.o
>   CC   =20
>    kernel/xenomai/nucleus/intr.o
>   CC      kernel/xenomai/nucleus/pod.o
> In
>   file included from /usr/src/linux-3.2.21/arch/x86/include/asm/xenomai=
/switch.h:2:0,
>                  from /usr/src/linux-3.2.21/arch/x86/include/asm/xenoma=
i/bits/pod_32.h:27,
>                  from /usr/src/linux-3.2.21/arch/x86/include/asm/xenoma=
i/bits/pod.h:2,
>                  from kernel/xenomai/nucleus/pod.c:47:
> /usr/src/linux-3.2.21/arch/x86/include/asm/xenomai/switch_32.h:30:2: wa=
rning: #warning "Buffer overflow detection not supported in 32bit
> mode" [-Wcpp]
> /usr/src/linux-3.2.21/arch/x86/include/asm/xenomai/switch_32.h:31:2: er=
ror: #error "Disable CONFIG_CC_STACKPROTECTOR in your kernel
> configuration"
> make[3]: * [kernel/xenomai/nucleus/pod.o]
> Error 1
> make[2]: * [kernel/xenomai/nucleus] Error 2
> make[1]: * [kernel/xenomai] Error 2
> make: * [kernel] Error 2
>
>
> how i can enable CONFIG_CC_STACKPROTECTOR in my kernel configuration???
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
while in menuconfig:

Processor type and features
    Enable -fstack-protector buffer overflow detection

and *disable* the option

Remember that typing  "/ STACKPROTECTOR" (or any symbol) will give you=20
the path in the menu

--=20
Fran=E7ois TOUCHARD
mailto:francois.touchard@in2p3.fr
Polytech Marseille/CPPM
http://francois.touchard.perso.luminy.univmed.fr/



