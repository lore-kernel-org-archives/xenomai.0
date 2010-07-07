Message-ID: <4C34B60D.1010402@domain.hid>
Date: Wed, 07 Jul 2010 19:14:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <181804936ABC2349BE503168465576460F3847C2@domain.hid>
	<4C347815.9050107@domain.hid>
	<181804936ABC2349BE503168465576460F384F38@domain.hid>
	<4C34AD18.9090902@domain.hid>
	<181804936ABC2349BE503168465576460F3850F3@domain.hid>
In-Reply-To: <181804936ABC2349BE503168465576460F3850F3@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Mixing skin calls (cancellation points)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: xenomai@xenomai.org

Steve Deiters wrote:
>> I already answered that: yes, the thread will re-acquire the 
>> mutex. The pthread_cleanup_push/pthread_cleanup_pop services 
>> can be called from a native skin thread, they are part of the 
>> glibc, not of Xenomai posix skin, so you do not need to link 
>> against the Xenomai posix skin library.
>>
>> Anyway, the proper way to fix this, which we use in the POSIX 
>> skin, is to set the cancellation type to asynchronous just 
>> before calling rt_cond_wait, saving the previoys cancellation 
>> type, then restore the cancellation type after rt_cond_wait.
> 
> This is probably the best solution for me.  Can I also use
> pthread_setcanceltype without linking to the POSIX skin or is there some
> method in the native skin to change the cancellation type?  Can I assume
> anything not wrapped in the posix.wrappers is provided by glibc?

Yes, anything not wrapped in posix.wrappers is provided by glibc. It is
safe to call pthread_setcanceltype without linke to the POSIX skin library.

-- 
					    Gilles.

