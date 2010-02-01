Message-ID: <4B66D203.7000309@domain.hid>
Date: Mon, 01 Feb 2010 14:07:15 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <fd55ced7db48fe30f8139df895fb9d4c.squirrel@domain.hid>	<4B655C00.6090809@domain.hid>
	<201002011232.30431.sinisa.denic@domain.hid>
In-Reply-To: <201002011232.30431.sinisa.denic@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai 2.5.0 uclibc 0.30 compatibility?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sinisa Denic <sinisa.denic@domain.hid>
Cc: xenomai@xenomai.org

Sinisa Denic wrote:
> On Sunday 31 January 2010 11:31:28 Gilles Chanteperdrix wrote:
>> This is bad news, the problem is that uclibc's stdio.h needs pthread.h,
>> which because of the -I flags we pass is xenomai's pthread.h, which
>> includes asm/syscall.h, which needs stdio.h.
> 
> Same thing,
> I can't figure out which file to include in pthread.h
> posix/init.c - same error
> include/asm-arm/xenomai/syscall.h - produce error from start building rtdm ...

In every .c file where you get the error, you should try and include
pthread.h before anything else.

-- 
					    Gilles.

