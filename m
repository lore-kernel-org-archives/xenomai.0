From: Travis Stratman <tstratman@domain.hid>
In-Reply-To: <4BED7D5B.6050605@domain.hid>
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D72A@alpine.pivotalsys.com>
	<4BED7D5B.6050605@domain.hid>
Date: Fri, 14 May 2010 14:40:35 -0500
Message-Id: <1273866035.6334.435.camel@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_mutex created prior to main causes board
	to	freeze?
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

Gilles,

I provided the Xenomai build for this board so I thought that it would
be appropriate for me to pick up for Sherk at this point.

On Fri, 2010-05-14 at 18:42 +0200, Gilles Chanteperdrix wrote:
> Sherk Chung wrote:
> > We are using Xenomai on an AT91 ARM board.  We wrote a program that
> > creates multiple Xenomai tasks, which use rt_mutexes to when accessing
> > some shared global variables.  The rt_mutexes used are declared
> > globally, as in the example below.  Since the objects sharedVar1,
> > shredVar2, etc. are declared on the global stack, the rt_mutexes are
> > created prior to main() getting executed.  The problem we are having is
> > that our program is causing our HW to freeze up on program load, it
> > never gets to the first line of main(), and our HW supplier pointed out
> > that we must call mlockall() and the set up the signal handlers before
> > creating the mutexes.
> > 
> >  
> > 
> > Is there a problem with creating rt_mutexes the way we are doing, and
> > should that cause the ARM board to freeze?  (the same program loads fine
> > on an x86)
> 
> No, there should not be any problem. Creating a mutex does not require a
> particular context, only locking it does.
> 
> Which version of Xenomai do you sue, with which version of the I-pipe patch?

The port is for a custom AT91-based (AT91SAM9G20) board, but we apply
the Xenomai patches directly. The kernel is 2.6.28 with the AT91 patches
and a couple of custom drivers that should not impact Xenomai. The first
build that I provided was Xenomai 2.5.2 with ipipe 1.12-07. After the
problem was reported, I tested it on a version that has been used by
several of our customers on large projects with the same board -- 2.4.8
w/ ipipe 1.12-02. I saw the same results on both.

There is no kernel output or output from running the application (ipipe
debugging is disabled). The board will not respond to any input from any
interface. 

Using strace I was able to determine that the first statements in main()
were not even reached. The strace output would generally stop on access
to /dev/rtheap or rt_sigaction(SIGXCPU...). My suspicion was the global
object instantiation calling rt_mutex_create().

Here's how I came to the conclusion that this needed to be placed inside
the application after mlockall():

First test:
I changed the global objects to pointers. The code that I was provided
had a Global.c file with these in it so I changed the code commented out
below to the pointers:
----
/*
SyncObject<int> g_terminate("terminate");
SyncObject<int> g_log_level("log level");
SyncObject<int> g_temperature("temperature");
SyncObject<SetPoint> g_set_point("Set Point");
SyncObject<int> g_decimation("decimation");
SyncObject<int> g_flow_feedback("flow feedback");
SyncObject<int> g_valve_override("valve override");
*/
SyncObject<int> * g_terminate;
SyncObject<int> * g_log_level;
SyncObject<int> * g_temperature;
SyncObject<SetPoint> * g_set_point;
SyncObject<int> * g_decimation;
SyncObject<int> * g_flow_feedback;
SyncObject<int> * g_valve_override;
----
Then, in main(), I added the following:
----

  g_terminate = new SyncObject<int>("terminate");
  g_log_level = new SyncObject<int>("log level");
  g_temperature = new SyncObject<int>("temperature");
  g_set_point = new SyncObject<SetPoint> ("Set Point");
  g_decimation = new SyncObject<int>("decimation");
  g_flow_feedback = new SyncObject<int>("flow feedback");
  g_valve_override = new SyncObject<int>("valve override");

----
This was located before mlockall() and setting up signals:
----
  signal(SIGTERM, handleShutdownSignal);
  signal(SIGINT, handleShutdownSignal);
  signal(SIGXCPU, handleTaskModeChange);
  mlockall(MCL_CURRENT | MCL_FUTURE);
----

Results:
The code always froze the board just as before. Using strace the code
would always stop output at rt_sigaction(SIGXCPU...) but it was not
actually reaching the signal() call in the application.

Second test:
I moved the object instantiation below mlockall() and the signal()
calls.

Results:
The application always completes successfully.

I can provide any other information that might be helpful. Any ideas on
what would be causing this if rt_mutex_create() can be called during the
object instantiation at a global level? Any pointers will be
appreciated!

Thanks,

TAS




