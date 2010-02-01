From: Sinisa Denic <sinisa.denic@domain.hid>
Date: Mon, 1 Feb 2010 12:32:29 +0100
References: <fd55ced7db48fe30f8139df895fb9d4c.squirrel@domain.hid>
	<4B655C00.6090809@domain.hid>
In-Reply-To: <4B655C00.6090809@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201002011232.30431.sinisa.denic@domain.hid>
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
To: xenomai@xenomai.org.

On Sunday 31 January 2010 11:31:28 Gilles Chanteperdrix wrote:
> This is bad news, the problem is that uclibc's stdio.h needs pthread.h,
> which because of the -I flags we pass is xenomai's pthread.h, which
> includes asm/syscall.h, which needs stdio.h.

Same thing,
I can't figure out which file to include in pthread.h
posix/init.c - same error
include/asm-arm/xenomai/syscall.h - produce error from start building rtdm ...

