Message-ID: <4386DF11.1020601@domain.hid>
Date: Fri, 25 Nov 2005 10:53:21 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] fusion and its stack limit
References: <001401c5f1a5$872f2980$06000100@domain.hid>
In-Reply-To: <001401c5f1a5$872f2980$06000100@domain.hid>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
To: Marco Cavallini <rtai@domain.hid>
Cc: Xenomai-core@domain.hid

Marco Cavallini wrote:
> Hi,
> with fusion-0.9.1 and VxWorks skin
> I am testing the creation of 255 different tasks each with a different 
> priority
> level from 0 to 254.
> I am facing to a problem creating more than 12 tasks with taskSpawn
> after creating 12 tasks the program fails into thread.c
> in function xnthread_init()
> at call xnarch_alloc_stack()
> returning -ENOMEM.
> 
> Can I increase the stack for fusion (and how) ?

There is not enough space in your system heap. Try raising 
CONFIG_XENO_OPT_SYS_HEAPSZ in the nucleus config menu.

> TIA
> 
> Marco Cavallini
> Koan s.a.s. - Bergamo - ITALIA
> Embedded and Real-Time Software Engineering
> www.koansoftware.com    |    www.klinux.org
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 

Philippe.

