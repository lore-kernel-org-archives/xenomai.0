Date: Tue, 08 Jan 2013 21:51:56 +0100
From: "Mariusz Janiak" <mariuszjaniak@wp.pl>
Message-ID: <50ec86ecafe0e2.65677797@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Subject: Re: [Xenomai] SIGXCPU with rt_mutex_release
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

> I guess the test could be simpler, simply:
> 
> rt_mutex_acquire
> rt_task_create
> rt_mutex_release
> rt_mutex_acquire
> rt_mutex_release

Yes this is minimal subset. 

> Anyway, calling rt_task_create while holding a real-time mutex is itself
> a priority inversion: any thread in primary mode waiting for the mutex
> will now have to wait for task running in secondary mode, so may be
> block during an unbounded amount of time. So, using a real-time mutex
> for this is completely useless you should be using a glibc
> pthread_mutex_t. If compiling for the posix skin, use
> __real_pthread_mutex_lock.

I deeply understand your point, but in case of OROCOS framework this mutex blocking occurs only during task creation and setting environment up. After that, when real time task perform its job, it run without blocking from secondary domain. Of course you are right that in this case the standard mutex will be better. 

> Now, how this can cause the issue you observe remains to be understood,
> and probably requires a fix.

I will be thankful for your help in solving this problem. Till then I will use Jan's patch. 

Mariusz




