Message-ID: <4B17B9F9.7070409@domain.hid>
Date: Thu, 03 Dec 2009 14:15:37 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <EA8B423DB69FD24FA233008019A052AE015C06A9@domain.hid>
In-Reply-To: <EA8B423DB69FD24FA233008019A052AE015C06A9@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with pthread_cond_wait
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Soboljew, Patrick" <Patrick.Soboljew@domain.hid>
Cc: xenomai@xenomai.org

Soboljew, Patrick wrote:
> Hello all,
> 
> I have a strange problem concerning the posix skin of xenomai (Ver.
> 2.4.9.1). Whenever two or more threads call 'pthread_cond_wait' and I
> want to interrupt the program with SIGINT (CTRL-c) only the main thread
> and the first thread that called 'pthread_cond_wait' get the signal. The
> remaining threads are not interrupted so I have created some zombies
> here. I discovered this problem when I tried to debug some code with the
> ACE/TAO Framework which calls these functions in a similar way. The
> debugger also has problems to interrupt these threads.
> 
> The small code example illustrates what I did.
> 
> Has anyone an idea what exactly causes this problem?

I believe the problem is that the other threads are blocked on the mutex
relocking by pthread_cond_wait. I believe this issue has just been
solved in 2.5 by the rework of pthread_cond_wait. I need to check with
your test program.

Getting the current situation to work implies handling the SIGINT (or
SIGTERM) by cancelling all threads. Then in each thread doing a
pthread_cond_wait registers a cleanup handler (pthread_cleanup_push)
that releases the mutex.

If I am right, I will check if it is possible to backport the
pthread_cond_wait rework without breaking the ABI.

-- 
                                          Gilles


