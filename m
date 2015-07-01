MIME-Version: 1.0
In-Reply-To: <CAL5YyVbm6rHu0QFyfMZbrVdDAeHmJrtrggbsAyERdC5HhaeQng@mail.gmail.com>
References: <CAL5YyVbm6rHu0QFyfMZbrVdDAeHmJrtrggbsAyERdC5HhaeQng@mail.gmail.com>
Date: Wed, 1 Jul 2015 11:59:52 +0200
Message-ID: <CAL5YyVawvx-8nVDd4u7RTgQ4o6z3Xdy+WeRP-Sg=0shdLLp-jA@mail.gmail.com>
From: ACO31 <alain.cordat@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Kernel compilation problem x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

'cocobalt' is just a bad  copy/past -> sorry
I work with   linux kernel and xenomai3rc5 without modification
In a first time i have launched the compil with same modification of kernel
with menuconfig  (RC4 ok, RC5 KO)
in a second time, I launch the compil of RC5 with no modification on
'menuconfig'. (only for test) with exactly the same process that with RC4.
(RC4 ok, RC5 KO)
I can find the apc.h
 - linux: in dir arch/sparc/... and include/xenomai/cobalt/kernel/
 - rc4 and rc5: in rep include/cobalt/kernel.
But the compil is ok for RC4, not for RC5. with same kernel src and same
process.

2015-07-01 11:02 GMT+02:00 ACO31 <alain.cordat@gmail.com>:

> Hello,
>
> I want to compile the RC5 of Xenomai 3  for X86 arch
> I use ipipe core 3.16.7-5  accorded to linux kernel 3.16.7 from kernel.org
> .
> (I've do the same compile for the RC4 without problem)
> no error message for prepare-kernel.sh.
> No problem with kernel make menuconfig.
> But the compile stop with error message about apc.h:
> cobalt/kernel/apc.h no such file or dir
> #include <cocobalt/kernel/apc.h>
> ...
> I re lauch teh compil wit same kernel archive and rc4 to valide archives
> and process:
> No error message...
> Thanks
> alain
>
>
> --
> Cordialement.
>
> A.Cordat
> Port: 06 04 04 17 69
>



-- 
Cordialement.

A.Cordat
Port: 06 04 04 17 69
