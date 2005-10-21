Message-ID: <43596380.50506@domain.hid>
Date: Fri, 21 Oct 2005 23:54:08 +0200
From: Luotao Fu <devtty0@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Strangeness in named Semaphores(xenomai posix skin)
References: <43590FD1.5030503@domain.hid>
	<17241.17423.857860.990465@domain.hid>
In-Reply-To: <17241.17423.857860.990465@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi,

Gilles Chanteperdrix wrote:
> Luotao Fu wrote:
>  > Hi folks,
>  > 
>  > I got the feeling, that named semaphores in xenomai posix skin don't
>  > work properly. I hacked some simple code to test this and attached the
>  > code to this mail, so that you might have a look of my problem yourself.
> 
> Thanks for reporting, you probably found a bug.

Thanks Gilles, as you surely have noticed, the sem_open() seems to work
properly, As sem_open() called from different threads returns identical
Pointeradresses to Semaphores with same Name. The magic cookie of the
semaphore structure seemed also be set correctly on
PSE51_NAMED_SEM_MAGIC. The Blocking and Unblocking in a single
Mainthread works also fine. What I found strange is that
sem_trywait_internal() don't return EAGAIN like it should, when called
by sem_wait() on a semaphore blocked by another thread. I'm trying to
rip my testcode further down to finer operational calls to locate the
failure. If I found anything interesting or even useful :-), I'll let
you know. It'll also be nice if you could send a mail, as soon as you
find/solve this problem.

> 
> I am on it.
> 

Thanx
Cheers

Luotao Fu

