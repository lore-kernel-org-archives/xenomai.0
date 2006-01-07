Message-ID: <43C03558.6060200@domain.hid>
Date: Sat, 07 Jan 2006 22:40:40 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Problems cross-compiling for PPC405
References: <200601072124.44626.niklaus.giger@domain.hid>
In-Reply-To: <200601072124.44626.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: niklaus.giger@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

Niklaus Giger wrote:
> Hi
> 
> I just upgraded to revision 392 of xenomai and got the following error trying
> to compile the linux 2.6.14 kernel
>   CC      kernel/xenomai/nucleus/heap.o
> /mnt/data.ng/hcu/kernel/linux-2.6.14/kernel/xenomai/nucleus/heap.c:1017:1: 
> pasting "," and "args" does not give a valid preprocessing token

r393 fixes this. Thanks.

> /mnt/data.ng/hcu/kernel/linux-2.6.14/kernel/xenomai/nucleus/heap.c: In 
> function `xnheap_mount':
> /mnt/data.ng/hcu/kernel/linux-2.6.14/kernel/xenomai/nucleus/heap.c:1015: 
> error: `args' undeclared (first use in this function)
> /mnt/data.ng/hcu/kernel/linux-2.6.14/kernel/xenomai/nucleus/heap.c:1015: 
> error: (Each undeclared identifier is reported only once
> /mnt/data.ng/hcu/kernel/linux-2.6.14/kernel/xenomai/nucleus/heap.c:1015: 
> error: for each function it appears in.)
> /mnt/data.ng/hcu/kernel/linux-2.6.14/kernel/xenomai/nucleus/heap.c:1015: 
> warning: too many arguments for format
> make[4]: *** [kernel/xenomai/nucleus/heap.o] Fehler 1
> make[3]: *** [kernel/xenomai/nucleus] Fehler 2
> make[2]: *** [kernel/xenomai] Fehler 2
> make[1]: *** [kernel] Fehler 2
> 
> 
> I am using GCC 3.4.4.
> 
> Best regards 


-- 

Philippe.

