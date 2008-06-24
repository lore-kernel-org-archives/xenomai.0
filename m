Message-ID: <4860D6A5.4060800@domain.hid>
Date: Tue, 24 Jun 2008 13:12:37 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <op.uc8z0alst06gyn@domain.hid>
In-Reply-To: <op.uc8z0alst06gyn@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] compiling probs
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Axel Beierlein <belatronix@domain.hid>
Cc: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

Axel Beierlein wrote:
> Hello,
> 
> when i try to compile the module examples from the xenomai source  
> directory i get many <in file included> like this
> 
> In file included from  
> /home/xx/linuxppc_2_4_25/include/asm/xenomai/hal.h:50,
>                   from  
> /home/xx/linuxppc_2_4_25/include/asm-generic/xenomai/system.h:39,
>                   from  
> /home/xx/linuxppc_2_4_25/include/asm/xenomai/system.h:29,
>                   from  
> /home/xx/linuxppc_2_4_25/include/xenomai/nucleus/types.h:39,
>                   from  
> /home/xx/linuxppc_2_4_25/include/xenomai/nucleus/queue.h:24,
>                   from  
> /home/xx/linuxppc_2_4_25/include/xenomai/nucleus/timer.h:23,
>                   from  
> /home/xx/linuxppc_2_4_25/include/xenomai/nucleus/thread.h:23,
>                   from  
> /home/xx/linuxppc_2_4_25/include/xenomai/nucleus/pod.h:34,
>                   from  
> /home/xx/linuxppc_2_4_25/include/xenomai/nucleus/xenomai.h:23,
>                   from  
> /home/xx/linuxppc_2_4_25/include/xenomai/rtdm/rtdm_driver.h:36,
>                   from heartbeat-x86.c:21:
> 
> also a type qualifier warning.
> 
> /home/xx/linuxppc_2_4_25/include/asm/time.h:60: warning: type qualifiers  
> ignored on function return type
> 
> Did anyone know what i make wrong?
> 
> I use xenomai 2.3.5 and the Kernelsource 2.4.25 from the Denx repository  
> with the ELDK4.1.
> 
> my make to build the modules is like <make XENO=$DESTDIR/root/xenomai  
> CC=ppc_6xx-gcc> where DESTDIR is set to the Path where the rootfs is.

Is your kernel configured and built?
Does adding ARCH=ppc help?
Is module support enabled in the kernel?
What ELDK version do you use?

It works fine here.

Wolfgang.




