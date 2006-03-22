Message-ID: <4421D87C.8010404@domain.hid>
Date: Thu, 23 Mar 2006 00:06:36 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] 2.6.16-rc6 support
References: <441DD358.8010307@domain.hid> <441E71BB.6010906@domain.hid>
In-Reply-To: <441E71BB.6010906@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Jan Kiszka wrote:
> 
>>Hi,
>>
>>Jeroen reported success much earlier, now I had to rebase my box on
>>upcoming 2.6.16. So I would like to post the result, maybe others are
>>interested in starting an early test as well. Attached is a cleanly
>>applying Ipipe patch for -rc6 and a fix for a name collision in
>>posix/syscall.c (there are other mutex functions in the kernel now...).
>>
> 
> 
> Uups, someone must have whispered to me that 2.6.16 will come out very
> soon, and now it happened. The final patch seems to cause no problems to
> the ipipe patch as well.
> 

Looks ok here too. I will upgrade the Adeos x86 support on this base. 
Thanks.

> Jan
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

