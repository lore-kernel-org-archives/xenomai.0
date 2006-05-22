Message-ID: <4471F84C.1020007@domain.hid>
Date: Mon, 22 May 2006 19:43:40 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai @ ppc with linker Porblem
References: <CC692F5386B0AA47A62B7484A7CA2B6D02B52527@domain.hid>
In-Reply-To: <CC692F5386B0AA47A62B7484A7CA2B6D02B52527@domain.hid>
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
> Hi
> 
> I have following problem when I compiling my Xenomai Program. It is a
> example from the Internet. 
> As Attachment I send the programm and the Makefile.
> 
> I think the problem is very simple but I have no Idea what it can be. 
> 
> My system is
> Linux 2.4.25
> Xenomai 2.1.1

You should upgrade to 2.1.2.

> Adeos 1.0-04
> 

You should upgrade to 1.1-02.

> PPC - MPC 8270 on Mircosys PM287.
> 
> This is my output:
> bash-2.05b# echo $PATH
> /usr/xenomai/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/us
> r/bin:/usr/X11R6/bin
> bash-2.05b# make
> gcc -I. -I/usr/xenomai/include -O2 -D_GNU_SOURCE -D_REENTRANT -D__XENO__
> -Wall -pipe -L/usr/xenomai/lib -lpthread -lnative -o timer timer.c
> timer.c: In function `main':

Try moving the linker flags after the input source file.
i.e. ... -o timer timer.c -L/usr/xenomai/lib -lpthread -lnative

> timer.c:44: warning: `rt_timer_start' is deprecated (declared at
> /usr/xenomai/include/native/timer.h:62)
> /tmp/ccyCczMp.o(.text+0x3c): In function `testtask':
> : undefined reference to `rt_task_sleep'
> /tmp/ccyCczMp.o(.text+0xac): In function `clean_exit':
> : undefined reference to `rt_task_delete'
> /tmp/ccyCczMp.o(.text+0x124): In function `main':
> : undefined reference to `rt_task_create'
> /tmp/ccyCczMp.o(.text+0x144): In function `main':
> : undefined reference to `rt_task_start'
> collect2: ld returned 1 exit status
> make: *** [timer] Error 1
> bash-2.05b#   
> 
> 
> Thanks for helping
> 
> Greetz
> Freddy
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 

Philippe.

