Message-ID: <4CD55D61.7050208@domain.hid>
Date: Sat, 06 Nov 2010 14:51:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTimpz6=DWjrKLRoG6O5XGotgQX6FTZR+U2b54awU@mail.gmail.com>
In-Reply-To: <AANLkTimpz6=DWjrKLRoG6O5XGotgQX6FTZR+U2b54awU@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] detect mode switches to primary mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Pastor <peter.pastor@domain.hid>
Cc: xenomai@xenomai.org

Peter Pastor wrote:
> Dear all,
> 
> I am running several boarder line threads that are running in primary
> mode only when accessing some shared memory, otherwise I want them to
> run in secondary mode. I have used rt_task_set_mode to warn me upon
> switches to secondary modes, however, my question is, is there a similar
> way to detect mode switches to primary mode ?
> 
> I have figured out a workaround using pthread_set_mode_np to force the
> thread to run in secondary mode (after shared memory access) and right
> before I force it back to primary mode do a printf and see whether I get
> a warning of switching into secondary mode (if so, then I know that the
> thread was running in primary mode, if not, then the thread was running
> in secondary mode.)
> 
> Again, my question is, is there an elegant way to detect mode switches
> from secondary mode to primary mode ?

No there is not. The reason to detect switches from primary to secondary
mode is to debug issues of threads which should remain in primary mode,
nothing else. And pthread_set_mode_np(PTHREAD_PRIMARY) is deprecated.

If you have a borderline thread sharing memory with a primary-mode only
thread, you are supposed to protect the accesses to the shared memory
with a mutex, then the borderline thread will automatically switch to
primary mode when it acquires the mutex. When it gets out of this
critical section and it calls a function which requires running in
secondary mode, then it will switch automatically to secondary mode.

Next versions of Xenomai will get this borderline thread to switch
automatically to secondary mode when it releases the mutex (the patch
already exists).

-- 
                                                                Gilles.

