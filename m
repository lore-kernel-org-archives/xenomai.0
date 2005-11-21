Message-ID: <43821221.9070702@domain.hid>
Date: Mon, 21 Nov 2005 19:29:53 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] __raw_*lock for Xenaomai 2.01 on ppc
References: <4381FC29.5040506@domain.hid>
In-Reply-To: <4381FC29.5040506@domain.hid>
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
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: xenomai@xenomai.org

Anders Blomdell wrote:
> Is it by design or mistake that I get the following undefined symbols on 
> a PowerPC
> 
> # insmod xeno_nucleus.ko
> xeno_nucleus: Unknown symbol __raw_read_lock
> xeno_nucleus: Unknown symbol __raw_write_unlock
> xeno_nucleus: Unknown symbol __raw_read_unlock
> xeno_nucleus: Unknown symbol __raw_write_lock
> 
> unless the kernel is compiled with:
> 
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_SPINLOCK=y
> 
> Regards
> 
> Anders Blomdell
> 
>

Patch version, please.

> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

