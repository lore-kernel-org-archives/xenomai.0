Message-ID: <4433A190.3040702@domain.hid>
Date: Wed, 05 Apr 2006 12:53:04 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: RESEND: [Xenomai-help] Xenomai on PPC
References: <CC692F5386B0AA47A62B7484A7CA2B6D027A2D85@domain.hid>
In-Reply-To: <CC692F5386B0AA47A62B7484A7CA2B6D027A2D85@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Behre, Frederik - LT" <Behre.Frederik@domain.hid>
Cc: xenomai@xenomai.org

Behre, Frederik - LT wrote:
> Hello
> 
> I have following Problem when I Build my uImage from my kernel.
> 
> 
> ppc_82xx-gcc -D__KERNEL__ 
> -I/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include 
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
> -fno-common -fomit-frame-pointer 
> -I/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/arch/ppc 
> -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized 
> -mmultiple -mstring  
> -I/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/xenomai 
> -I/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/xenomai/compat 
> -nostdinc -I /root/eldk/311/usr/lib/gcc-lib/ppc-linux/3.3.3/include 
> -DKBUILD_BASENAME=hal  -c -o hal.o hal.c
> 
> In file included from 
> /root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/asm/xenomai/hal.h:32, 
>

You did not switch on the I-pipe support in your kernel configuration,
see "General setup".

-- 

Philippe.

_______________________________________________
Xenomai-help mailing list
Xenomai-help@domain.hid
https://mail.gna.org/listinfo/xenomai-help


