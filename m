Message-ID: <497F07D2.6080501@domain.hid>
Date: Tue, 27 Jan 2009 14:10:42 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <496F0DBE.5010108@domain.hid>	<496F14B9.4010604@domain.hid>	<496F1CF2.1030401@domain.hid>	<496F275E.90407@domain.hid>	<496F4065.9040501@domain.hid>	<496F4558.8080603@domain.hid>
	<49750A32.8080104@domain.hid>	<49750E55.8080000@domain.hid>
	<4975901E.7040408@domain.hid>
In-Reply-To: <4975901E.7040408@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Pending patches
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> We should indeed postpone this just in case the upper layer indexes the extra
> state on the minor value. We can also simplify a few things doing so.
> 
> --- ksrc/nucleus/pipe.c	(revision 4565)
> +++ ksrc/nucleus/pipe.c	(working copy)
> @@ -77,11 +77,9 @@
> 
>  static inline void xnpipe_minor_free(int minor)
>  {
> -	if (minor < 0 || minor >= XNPIPE_NDEVS)
> -		return;
> -
> -	__clrbits(xnpipe_bitmap[minor / BITS_PER_LONG],
> -		  1UL << (minor % BITS_PER_LONG));
> +	/* May be called with nklock free. */
> +	clrbits(xnpipe_bitmap[minor / BITS_PER_LONG],
> +		1UL << (minor % BITS_PER_LONG));

Bad news: This doesn't fly as is. All modifying operations on
xnpipe_bitmap must be atomic and xnpipe_bitmap has to be
xnarch_atomic_t. But then find_first_zero_bit breaks. Is there some
version for atomic arrays? I guess we have to open-code this, at least
down to word-level...

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

