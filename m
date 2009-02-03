Message-ID: <4988455B.3080108@domain.hid>
Date: Tue, 03 Feb 2009 14:23:39 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4B3F8896E1733D4787DDB0EA1C7FF91F6B572E@ukmail.uk.wirelessworld.airvananet.com>
In-Reply-To: <4B3F8896E1733D4787DDB0EA1C7FF91F6B572E@ukmail.uk.wirelessworld.airvananet.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread_cond_init() returns ENOMEM
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mike McTernan <mmcternan@domain.hid>
Cc: xenomai@xenomai.org

Mike McTernan wrote:
> Hi,
> 
> I'm trying to port a large complex app to Xenomai using the POSIX skin,
> and so far so good!
> 
> But I've found pthread_cond_init() it reporting ENOMEM to a userspace
> app.  Looking back up the sources I think this maybe because
> xnheap_alloc() is exhausted in the kernel.
> 
> I'm using the Xenomai VMware image from
> http://www.cs.ru.nl/lab/xenomai/, it's version 2.4.3.  Do I need to
> update, or is there a way I can increase the heap?  
> 

You should update it at some point, since we fixed significant bugs since then.
But you don't need this to increase the heap.

> I can't see how to do it from the docs, please point me in the right
> direction.
> 

Check XENO_OPT_SYS_HEAPSZ in the Xenomai nucleus menu (Kconfig).

> Kind Regards,
> 
> Mike
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

