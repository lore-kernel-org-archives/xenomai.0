Message-ID: <4AC463C5.1060702@domain.hid>
Date: Thu, 01 Oct 2009 10:09:41 +0200
From: Matthieu Nottale <nottale@domain.hid>
MIME-Version: 1.0
References: <4AC1BCF9.8050908@domain.hid> <4AC4561B.5070004@domain.hid>
	<4AC45853.2040107@domain.hid> <4AC45D39.3010605@domain.hid>
In-Reply-To: <4AC45D39.3010605@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [bug] accept() in non-blocking mode fails with
 EPERM instead of EAGAIN
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>   
>> Jan Kiszka wrote:
>>     
>>> Matthieu Nottale wrote:
>>>       
>>>> Hi,
>>>>
>>>> I believe I found a bug in the Xenomai Posix skin while trying to use
>>>> boost::asio: The accept() call in asychronous mode
>>>> fails with ENOPEM instead of EAGAIN. Other than that, the call 'works'
>>>> in the sense that calling it again after a connection is established
>>>> returns a new file descriptor.
>>>>         
>>> On what kind of file descriptor descriping what kind of socket are you
>>> calling accept()? So far I'm not aware of any RTDM driver providing the
>>> corresponding service - well, at least not a public one (our RT-TCP
>>> stack is yet to be released). Or is it intended to pass the call to
>>> plain Linux, switching the caller into secondary more?
>>>       
>> There's a sample attached. Yes, it is a TCP stream. Howeve accept is
>> wrapped, so it may happen that EPERM is the result of the wrapping.
>>
>>     
>
> Oops, missed that. Indeed, patch below should fix it.
>
> Jan
>
> diff --git a/src/skins/posix/rtdm.c b/src/skins/posix/rtdm.c
> index 6e347fb..4e6685f 100644
> --- a/src/skins/posix/rtdm.c
> +++ b/src/skins/posix/rtdm.c
> @@ -404,18 +404,21 @@ int __wrap_accept(int fd, struct sockaddr *addr, socklen_t * addrlen)
>  
>  		pthread_setcanceltype(oldtype, NULL);
>  
> -		if (fd >= 0)
> -			fd += __rtdm_fd_start;
> +		if (fd < 0)
> +			return set_errno(fd);
> +
> +		return fd + __rtdm_fd_start;
>  	} else {
>  		fd = __real_accept(fd, addr, addrlen);
>  
>  		if (fd >= __rtdm_fd_start) {
>  			__real_close(fd);
> -			fd = -EMFILE;
> +			errno = EMFILE;
> +			fd = -1;
>  		}
> -	}
>  
> -	return set_errno(fd);
> +		return fd;
> +	}
>  }
>  
>  int __wrap_getsockname(int fd, struct sockaddr *name, socklen_t * namelen)
>
>   
Thank you very much for this quick correction, without much knowledge of 
xenomai I was afraid the fix would be much more complicated.


Best regards,

    Matthieu

