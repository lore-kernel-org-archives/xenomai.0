Message-ID: <4AC6FB78.5090402@domain.hid>
Date: Sat, 03 Oct 2009 09:21:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1f3e02580909300343y3bf44fedh8dbc8d7e27fead4d@domain.hid>	
	<4AC346C7.4040600@domain.hid>	
	<1f3e02580910020652p7bc52284p7e26573669e1a05b@domain.hid>	
	<4AC63536.2010802@domain.hid>
	<1f3e02580910021855i294d2677x8da7cb0539f90490@domain.hid>
In-Reply-To: <1f3e02580910021855i294d2677x8da7cb0539f90490@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Guide] To patch Linux Kernel with Xenomai for
 Unknown core
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Didenko Sergey <didenkos@domain.hid>
Cc: xenomai@xenomai.org

Didenko Sergey wrote:
>> *Gilles:*
> 
>> Then your board does not support GENERIC_CLOCKEVENT and GENERIC_TIME,
>> and you should skip the section about it in the howto.
>>
> 
> *Q1: But, so far as these options are defined in kernel's .config file, does
> it effect somehow on how the kernel's code has been patched when I made
> Xenomai\prepare_kernel?*

If the options are defined in the kernel's .config file, then your board
supports them. So, there should be a next_event() and set_mode()
functions. Note however that the exact name of these functions depend on
the processor (so, it is not exactly pxa_osmr0_set_next_event and
pxa_osmr0_set_mode, as their name suggests, these functions are specific
to the pxa osmr0 timer). The effect of these options on the I-pipe board
support code is explained in the GNERIC_CLOCKEVENT / GENERIC_TIME
section in the howto.

-- 
					    Gilles.

