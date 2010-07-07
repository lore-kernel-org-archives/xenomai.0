Message-ID: <4C347815.9050107@domain.hid>
Date: Wed, 07 Jul 2010 14:50:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <181804936ABC2349BE503168465576460F3847C2@domain.hid>
In-Reply-To: <181804936ABC2349BE503168465576460F3847C2@domain.hid>
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
> Is it in general valid to mix calls from different skins?  In
> particular, can I expect the native skin calls to work as POSIX
> cancellation points?  For example, if I have a POSIX thread with a
> pthread_t identifier which I know calls rt_cond_wait somewhere, will it
> work as a cancellation point when I call pthread_cancel?
> 
> The example program attached will not cancel if I have CANCEL_DEFERRED
> defined as 1 at the top, which sets the cancel type to deferred.  This
> is on a PowerPC with Xenomai 2.5.3.  I think this worked with Xenomai
> 2.4.10.

Hi,

I had a look at the code, and chances are, that in fact it never worked.
The native skin threads are created with asynchronous type, and the rest
 of the skin assumes that it is always the case. To kill a native skin
thread, you are supposed to use rt_task_delete instead of
pthread_cancel, and if you did not change the thread cancellation type,
it will work. If you are interested in waiting for the thread deletion,
you can create the thread joinable with T_JOINABLE, then wait for it
with rt_task_join.

We can, of course, modify the code to allow changing the native thread
cancellation type. But the question is: what is the use-case?


-- 
					    Gilles.

