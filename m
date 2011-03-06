From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTikq49CMPG=-nFDOhc+Qc1iuK3kHyMpsJ+NCzFUX@mail.gmail.com>
References: <AANLkTikq49CMPG=-nFDOhc+Qc1iuK3kHyMpsJ+NCzFUX@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 06 Mar 2011 11:50:19 +0100
Message-ID: <1299408619.2116.0.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Whether can Xenomai bypass the cache?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: arethe rtai <arethe.rtai@domain.hid>
Cc: Xenomai-core@domain.hid

On Sun, 2011-03-06 at 14:05 +0800, arethe rtai wrote:
> Hello:
>     As known, cache can accelerate the memory access, but
> unfortunately, it would decrease the predictability of real-time tasks'
> temporal behaviour. Many tasks of our application prefer
> predictability to the speed of execution. Intel's processors after P6
> include MTRR and PAT, both the two units can be used to bypass the
> cache.
>     I wonder whether Xenomai can bypass the cache, and whether Xenomai
> can manage the MTRR or PAT? 


No.

> If the answers are true, how to use the
> function?
> 3x
> arethe
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core

-- 
Philippe.



