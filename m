Message-ID: <48F11C12.20104@domain.hid>
Date: Sat, 11 Oct 2008 23:35:14 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <333188.51777.qm@domain.hid>
In-Reply-To: <333188.51777.qm@domain.hid>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] trap exceptions in user
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
To: Gabriele Moabiti <gabmoa@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Gabriele Moabiti wrote:
> 
>>Yes, but I still think this is useless. If your user-space code expects
>>to be running from 1MB to 16MB, it expects this for virtual addresses,
>>not for physical addresses. So, I really think you should mmap the 1MB
>>to 16MB region by passing the start address to mmap with the MMAP_FIXED
>>flag.
> 
> I know my way to solve this problem is very strange but there are some
> reasons.
> It is done for compatibility reasons (DMA and a strange architecture
> with custom gdt entries needed by the asm blob...)
> In this application I don't need contiguous physical addresses so I will
> try the mmap fixed way.
> I didn't only want to fork the driver but it is not a big problem...
> 
>>You should trace the exception path in the I-pipe patch to find the
>>point where your exception handling callback is not called.
> 
> will it be a large print work or there are another ways to do that? :)
> 

You may want to have a look at the I-pipe tracer:

http://www.xenomai.org/index.php/I-pipe:Tracer

>     Gabriele
> 
> 
> ------------------------------------------------------------------------
> Scopri il Blog di Yahoo! Mail
> <http://us.rd.yahoo.com/mail/it/taglines/yahoo/ymail/SIG=11djrg460/**http%3A%2F%2Fwww.ymailblogit.com%2Fblog%2F>:
> trucchi, novità, consigli... e scrivi la tua opinione!
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

