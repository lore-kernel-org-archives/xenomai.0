MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17889.51053.547538.275878@domain.hid>
Date: Sun, 25 Feb 2007 18:29:17 +0100
Subject: Re: [Xenomai-help] timing, scheduling. some theory?
In-Reply-To: <bc4264770702250836j54bed43bxb943d4cc88fbeb99@domain.hid>
References: <bc4264770702250638k6b2a2737raef60866a3dc3401@domain.hid>
	<17889.44695.352072.990692@domain.hid>
	<bc4264770702250836j54bed43bxb943d4cc88fbeb99@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

roland Tollenaar wrote:
 > Hi
 > 
 > > Xenomai kernel implements the so-called "FIFO" scheduling policy, that
 > > is, the task which runs at any time is the task with the highest
 > > priority that has been ready for the longest time. Calling
 > > rt_task_wait_period suspends the calling task, and let other tasks
 > > run.
 > >
 > > If I understand correctly, what you want is to set some outputs at some
 > You understand correctly.
 > 
 > > precise deadline, I see two ways to do what you want:
 > > * either the time when you compute the output has no importance, and the
 > >   only thing that matters is when you set the output, in which case you
 > >   can call rt_task_wait_period right before setting the outputs, your
 > >   task will do
 > >   compute next output
 > >   go to sleep
 > >   set output
 > >   compute next output
 > >   go to sleep
 > >   set output
 > >   etc...
 > Actually this is exactly what I had in mind only it is important
 > (discrete state space controller computations) that the input is also
 > read at exact intervals. So maybe:
 > 
 > compute next output k+1
 > go to sleep
 > read input for k+2 computations
 > set output k+1
 > compute next output k+2
 > go to sleep
 > read input for k+3 computations
 > set output k+2
 > >   etc...
 > 
 > > * or the time between reading input and setting output has to be as
 > >   fixed as possible, in which case what you will have to do is to
 > >   calibrate the WCET (worst case execution time) of the computations on
 > >   the machine you are running, setup rt_task_set_periodic so that your
 > >   task is woken up at (deadline - WCET), and in each loop, do the
 > >   computations, then busy wait until the deadline then set the
 > >   output. In order to busy wait, you may use rt_timer_tsc.
 > 
 > Off hand I am not exactly sure why this second technique would give me
 > a more fixed interval between reading input and writing output than
 > the modified technique 1 I suggest above?

I supposed you had to read input k+1 after having set output k

-- 


					    Gilles Chanteperdrix.

