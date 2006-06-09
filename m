From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17545.24482.769468.81330@domain.hid>
Date: Fri, 9 Jun 2006 13:46:42 +0200
Subject: Re: [Xenomai-help] shm_open, ftruncate
In-Reply-To: <448937A5.7080701@domain.hid>
References: <4480595D.7040203@domain.hid>
	<17536.29324.723709.385494@domain.hid>
	<4484365A.7090007@domain.hid>
	<17540.21517.871383.751462@domain.hid>
	<44856CA7.30802@domain.hid>
	<17541.29542.312486.329018@domain.hid>
	<44859C28.3090600@domain.hid>
	<17541.49945.431732.834139@domain.hid>
	<4486CCDF.2070409@domain.hid>
	<17542.59422.109900.142889@domain.hid>
	<448937A5.7080701@domain.hid>
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
 >  
 > >  > > I can confirm that a few fixes in v2.1 were missing, so trunk works
 > >  > > correctly, didn't you forget to rebuild the kernel when building trunk ?
 > >  > > Attached is a patch to v2.1 that contain the fixes backported from
 > >  > > trunk. Please try this patch and tell me if this works for you.
 > >  > >   
 > >  > In fact, I've downloaded the last version of trunk before your mail and 
 > >  > the patch. You're right that works pretty good with this version... :)
 > >  > 
 > >  > Unfortunately, it seem's that we can't share between a real time process 
 > >  > and a non real one ?
 > >
 > > Sharing memory should work, could you explain what happens ? Note that
 > > you may use Linux regular shared memory services in the real-time
 > > process by calling __real_shm_open instead of shm_open.
 > >   
 > Ok,
 > But I'd like a real time behaviour of shared memory for my real time 
 > task... so I can't use __real_shm_open, etc...
 > 
 > Here is the little code I've developped to access shared memory. May be 
 > there some mistakes...
 > I compile it with or without xeno-config --posix-cflags, xeno-config 
 > --posix-ldflags to get two executables.
 > I launch these two executables and the shared_memory seem's to be 
 > different in these two cases.
 > All Xenomai processes are accessing the same shared_memory while all 
 > non-xenomai processes are accessing another one shared memory.

That is the expected behaviour: xenomai posix skin shared memory is
different from Linux regular shared memory. In the same vein, xenomai
posix skin semaphores are different from Linux regular semaphores.

But there is no problem using Linux regular shared memory in a real-time
thread, providing that you call mlockall. Using a Linux regular
semaphore in a real-time thread is also possible by using
__real_sem_post or __real_sem_wait, but the real-time
thread will migrate to secondary mode.

The alternative is to compile the two processes with the flags given by
xeno-config, and to create non real-time threads in one process using
__real_pthread_create.

-- 


					    Gilles Chanteperdrix.

