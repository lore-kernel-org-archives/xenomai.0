Message-ID: <44055575.4000306@domain.hid>
Date: Wed, 01 Mar 2006 09:04:05 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: AW:
	[Xenomai-help]	undefinedreference	__xnarch_xchg_called_with_bad_pointer
References: <5D63919D95F87E4D9D34FF7748CE2C2A1C3DB1@domain.hid>
	<440479E7.7010800@domain.hid> <44049605.2000108@domain.hid>
	<44049F19.3020901@domain.hid>
In-Reply-To: <44049F19.3020901@domain.hid>
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
To: Heikki Lindholm <holindho@domain.hid>
Cc: xenomai@xenomai.org

Heikki Lindholm wrote:
> Philippe Gerum kirjoitti:
> 
>> Heikki Lindholm wrote:
>>
>>> Uh. I guess the compiler isn't killing the *_bad_pointer function as 
>>> dead code when debug is enabled (although it is dead-code.)
>>
>>
>>
>> The optimizer is disabled by --enable-debug so that we don't get 
>> strange jumps while tracing with GDB, I guess that's why the dead code 
>> is not eliminated. What about just killing this check, since the same 
>> code is already validated when compiling it as a kernel module? 
>> (except asm-uvm/system.h, but that's not important).
> 
> 
> Yep. That seems like the way to go. I don't see much to gain from the 
> check. Of course, paranoid way would be to add the __bad_ptr() function 
> with abort() or something inside. Quick patch attached for the former case.

Applied, thanks.

> 
> - hl
> 
> 
> ------------------------------------------------------------------------
> 
> --- atomic.h.orig	2006-02-28 21:01:59.000000000 +0200
> +++ atomic.h	2006-02-28 21:01:34.000000000 +0200
> @@ -142,12 +142,6 @@
>  }
>  #endif
>  
> -/*
> - * This function doesn't exist, so you'll get a linker error
> - * if something tries to do an invalid xchg().
> - */
> -extern void __xnarch_xchg_called_with_bad_pointer(void);
> -
>  static __inline__ unsigned long
>      __xchg(volatile void *ptr, unsigned long x, unsigned int size)
>  {
> @@ -159,7 +153,6 @@
>  	return __xchg_u64(ptr, x);
>  #endif
>      }
> -    __xnarch_xchg_called_with_bad_pointer();
>      return x;
>  }
>  


-- 

Philippe.

