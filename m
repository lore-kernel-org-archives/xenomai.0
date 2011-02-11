Message-ID: <4D5517B4.8060007@domain.hid>
Date: Fri, 11 Feb 2011 12:04:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <21119302.61297421436968.JavaMail.SYSTEM@pc-msalvini>
In-Reply-To: <21119302.61297421436968.JavaMail.SYSTEM@pc-msalvini>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Signal mask inheritance
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mauro Salvini <mauro.salvini@domain.hid>
Cc: xenomai@xenomai.org

Mauro Salvini wrote:
> Hi to all,
> 
> I would build an application where only one of real-time tasks
> executes a custom signal handler to respond to a set of signals (ex
> SIGINT, SIGTERM). Xenomai tasks are also POSIX threads, so I think
> that at creation they inherits all signal masks and handlers from
> parent thread.

Handlers are per-process, not per-thread.

> So, what I can do in my app is reset signal mask to
> block all signals when new task starts.

Why do this? Why not only mask the signals you want to handle in the
separate thread?

And yes, you must let Xenomai thread handle SIGWINCH

> By the way, is there a method in Xenomai to initialize all RT_TASK
> structure fields without use field names (eg
> PTHREAD_MUTEX_INITIALIZER )? I use this simple define:

Well, as you found out, one of the members of the RT_TASK structure is
the pthread_t identifier of the corresponding thread, so, how do you
figure it would be possible to initialize the RT_TASK in advance before
the thread is even created?

And by the way, POSIX has PTHREAD_MUTEX_INITIALIZER, not
PTHREAD_INITIALIZER. So, you are comparing things which are not really
comparable.

Listen, we do have limited ressources to answer your questions, so
please take time to read some documentation, and think a bit before
asking questions.

-- 
					    Gilles.

