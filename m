Message-ID: <4B8BB7E8.2020304@domain.hid>
Date: Mon, 01 Mar 2010 13:49:44 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1Nl4tX-0001N9-Hb@domain.hid>	<4B881E9D.1050101@domain.hid>	<4B88203F.2020907@domain.hid>	<4B8903E1.3020805@domain.hid>
	<4B8B7540.609@domain.hid>	<4B8B84BC.90300@domain.hid>
	<4B8B971D.5080807@domain.hid>	<4B8B98F5.10602@domain.hid>
	<4B8BA361.1040807@domain.hid> <4B8BB71C.1060509@domain.hid>
In-Reply-To: <4B8BB71C.1060509@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : RTDM+POSIX: Avoid
 leaking binding objects on errors
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Wait! When the sync object behind some file descriptor is deleted but
>>>>>> the descriptor itself is still existing, we rather have to return that
>>>>>> fd signaled from select() instead of letting the call fail. I beed to
>>>>>> look into this again.
>>>>> It looks to me like a transitory state, we can wait for the sync object
>>>>> to be deleted to have the fd destructor signaled. It should not be long.
>>>> That's not an issue of waiting for this. See e.g. TCP: peer closes
>>>> connection -> internal sync objects will be destroyed (to make
>>>> read/write fail). But the fd will remain valid until the local side
>>>> closes it as well.
>>> It looks to me like this is going to complicate things a lot, and will
>>> be a source of regressions. Why can we not have sync objects be
>>> destroyed when the fd is really destroyed and use a status bit of some
>>> kind to signal read/write that the fd was closed by peer?
>> It is way easier and more consistent to unblock reader and writers via
>> destroying the sync object than to signal it and add tests for specific
>> states to detect that. Keep in mind that this pattern is in use even
>> without select support. Diverging from it just to add select awareness
>> to some driver would be a step back.
>>
> 
> First draft of a fix that so far does what it is supposed to do,
> comments welcome:
> 
> diff --git a/ksrc/skins/posix/syscall.c b/ksrc/skins/posix/syscall.c
> index 959b61c..4e46cb6 100644
> --- a/ksrc/skins/posix/syscall.c
> +++ b/ksrc/skins/posix/syscall.c
> @@ -2298,24 +2298,30 @@ static int select_bind_one(struct xnselector *selector, unsigned type, int fd)
>  }
>  
>  static int select_bind_all(struct xnselector *selector,
> -			   fd_set *fds[XNSELECT_MAX_TYPES], int nfds)
> +			   fd_set *in_fds[XNSELECT_MAX_TYPES],
> +			   fd_set *out_fds[XNSELECT_MAX_TYPES], int nfds)
>  {
>  	unsigned fd, type;
> +	int pending = 0;
>  	int err;
>  
>  	for (type = 0; type < XNSELECT_MAX_TYPES; type++) {
> -		fd_set *set = fds[type];
> +		fd_set *set = in_fds[type];
>  		if (set)
>  			for (fd = find_first_bit(set->fds_bits, nfds);
>  			     fd < nfds;
>  			     fd = find_next_bit(set->fds_bits, nfds, fd + 1)) {
>  				err = select_bind_one(selector, type, fd);
> -				if (err)
> -					return err;
> +				if (err) {
> +					if (err != -EIDRM)
> +						return err;
> +					__FD_SET(fd, out_fds[type]);
> +					pending++;
> +				}
>  			}
>  	}
>  
> -	return 0;
> +	return pending;
>  }
>  
>  /* int select(int, fd_set *, fd_set *, fd_set *, struct timeval *) */
> @@ -2387,7 +2393,7 @@ static int __select(struct pt_regs *regs)
>  
>  		/* Bind directly the file descriptors, we do not need to go
>  		   through xnselect returning -ECHRNG */
> -		if ((err = select_bind_all(selector, in_fds, nfds)))
> +		if ((err = select_bind_all(selector, in_fds, out_fds, nfds)))
>  			return err;
>  	}
>  
> @@ -2395,7 +2401,8 @@ static int __select(struct pt_regs *regs)
>  		err = xnselect(selector, out_fds, in_fds, nfds, timeout, mode);
>  
>  		if (err == -ECHRNG) {
> -			int err = select_bind_all(selector, out_fds, nfds);
> +			int err = select_bind_all(selector, out_fds, out_fds,
> +						  nfds);

Mmh, this is probably no good idea, need to truly split in (aka "no yet
bound") and out (aka "pending") sets here as well.

>  			if (err)
>  				return err;
>  		}

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

