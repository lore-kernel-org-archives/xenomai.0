From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <Pine.LNX.4.64.0909021156010.22914@domain.hid>
References: <Pine.LNX.4.64.0909021156010.22914@domain.hid>
Content-Type: text/plain
Date: Wed, 02 Sep 2009 11:07:38 +0200
Message-Id: <1251882458.3205.121.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Differences in RT_HEAP_INFO struct between
 Xenomai 2.4/2.5
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Rus V. Brushkoff" <rus@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2009-09-02 at 11:59 +0300, Rus V. Brushkoff wrote:
> 	Hi,
> 
>   Trying to backport Xenomai app from 2.5 to 2.4 noticed that 
> rt_heap_info struct has no phys_addr field. Is this interface difference 
> supposed to exist ?
> 

Well, if it's there, it is indeed supposed to exist. ABI is guaranteed
to be stable within a stable Xenomai series, e.g. 2.4.0 to 2.4.9.1. No
such guarantee exists across major releases, e.g. 2.4.0 to 2.5.0.

> 
>  		Rus
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



