From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17534.51974.92955.465953@domain.hid>
Date: Thu, 1 Jun 2006 13:09:58 +0200
Subject: Re: [Xenomai-help] How to make main sleep ? clock_nanosleep
	?	rt_alarm_wait ?
In-Reply-To: <447EB4A8.5090809@domain.hid>
References: <447E9A1B.10507@domain.hid>
	<17534.43220.103310.355438@domain.hid>
	<447EB4A8.5090809@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Lionel Perrin <perrin@domain.hid>
Cc: xenomai@xenomai.org

Lionel Perrin wrote:
 > Thanks for your answer. That's really great to have support so quickly. :)
 > >  > I got some difficulties to use either rt_alarm_wait or clock_nanosleep.
 > >  > It seems i haven't understood what's a "context that can sleep".
 > >  > 
 > >  > First of all, what do we need to use clock_nanosleep ?
 > >  > Is it impossible to use this function in the main thread ?
 > >
 > > Xenomai clock_nanosleep, nanosleep or rt_alarm_wait services are
 > > reserved to Xenomai real-time threads, and will return an error of EPERM
 > > otherwise.
 > >   
 > Ok. So the thread "main" is not a Xenomai real-time,  right ?
 > 
 > > If you want to obtain a Xenomai real-time thread using the posix skin
 > > you have to make it use the SCHED_FIFO policy, either by creating it
 > > with the pthread_create service, specifying non null creation attributes
 > > or by changing the scheduling policy of an existing thread with
 > > the pthread_setschedparam service.
 > >   
 > Is it possible to apply those methods to the thread "main" ?

You can not create the main thread with pthread_create, but you can make
it real-time with pthread_setschedparam.


 > There's still my sched_setscheduler enigma.
 > Why the following program need the commented line to run perfectly, and 
 > why nanosleep failed without those lines  ?

Maybe because the default value of the inheritsched attribute is not
what you expect ? You can check if a thread uses a real-time scheduling
policy with pthread_getschedparam.

 > (...)
 >     if(pthread_attr_init(&th_attr))
 >         perror("pthead_attr_init");
 >    
 >     if (pthread_attr_setschedpolicy(&th_attr, SCHED_FIFO))
 >         perror("pthread_attr_setschedpolicy");
 >    
 >     if (pthread_create(&th, &th_attr, task, NULL))
 >         perror("pthread_create");;
 >    
 >     if(pthread_join(th, NULL))
 >         perror("pthread_join");
 > (...)

perror will not work with pthread_* services: they do not use errno,
they return errors directly.

-- 


					    Gilles Chanteperdrix.

