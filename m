From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4E00B9BA.2050306@domain.hid>
References: <4E00B9BA.2050306@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 21 Jun 2011 18:05:17 +0200
Message-ID: <1308672317.2125.105.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Number of arguments
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: zenati <omar.zenati@domain.hid>
Cc: Xenomai-core@domain.hid

On Tue, 2011-06-21 at 17:33 +0200, zenati wrote:
> Dear,
> 
> As known, the norm arinc653 is very strict and the API proposed should 
> be respected. Some functions of the API need more than five arguments. 
> However, the "SKINCALL" is limited to 5. If I want to increase, I have 
> to modify the following files :
>   - ./xenomai-2.5.6/include/asm-arm/syscall.h
>   - ./xenomai-2.5.6/include/asm-blackfin/syscall.h
>   - ./xenomai-2.5.6/include/asm-x86/syscall.h
>   - ./xenomai-2.5.6/include/asm-powerpc/syscall.h
>   - ./xenomai-2.5.6/include/asm-nios2/syscall.h
> 
> Is it possible? Is is a good idea ?

No, dead end. You should group arguments in a struct and pass the
address of such struct to kernel land for decoding.

> 
> Thank you for your attention and your help.
> Sincerely
> 
> Omar ZENATI
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core

-- 
Philippe.



