MIME-Version: 1.0
Message-ID: <OFCB660949.1032EBD1-ONC12571F4.005971C7@domain.hid>
From: "Thomas Necker" <Thomas.Necker@domain.hid>
Date: Thu, 28 Sep 2006 08:48:25 +0200
Content-Type: text/plain; charset="us-ascii"
Subject: [Xenomai-help] Probable sync problem using pSOS skin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Ok, maybe it's best to put the discussion back on the mailing list.
For the audience, what has happened up to now:

> > > Ok, so it's probably an internal sync problem affecting the UVM. The
> > > beast is particularly prone to that over the LinuxThreads,
> > > unfortunately. Actually, what you describe rings a bell now; if you
> > > could reduce the odd behaviour to a simple test case, I would look 
at it
> > > asap.
> > 
> > Here's the test case. It was quite an effort to strip the program 
without
> > losing the error pattern. The problem seems to be heavily timing 
> > dependent.
> > Leave out a printf here or a tm_wkafter there and it works fine. So I 
hope
> > you can repeat the error with your configuration at all. I did it on a 

> > PowerPC
> > using Kernel 2.4.22, ucLibc 0.9.28, Xenomai 2.2.2, gcc 3.3.6 .
 
> > The program starts a MAIN task which in turn starts three tasks and 
idles 
> > afterwards.
> > These three tasks are:
> >  - LHWT that sends a message to LHTX
> >  - LHTX sends an event to TOSV upon receipt of this message
> >  - TOSV receives the event but a call to psos_current_task yields 
LHTX's 
> > task id - BUMMER!.
> >    Also the received event Id is 0.  The program usually would crash 
> > afterwards, but I let it nicely exit instead.

> > > So you fixed it? Does it work for you now? I just looked into the 
commit-
> > > mailing list and tried adding "XNBREAK" to shadow.c - no effect for 
me.
> >
> > Yes, that's the fix. Your test case works properly now on my box, and
> > the fix is directly related to the symptoms you experienced. Could you
> > double-check that your test case still exhibit the issue?

I meanwhile double-double checked it - the problem is not gone, also not 
with
the SVN head for the v2.2.x branch :-( And I could only provoke it 
*without* GDB.
I also asked Wolfgang Grandegger who has a similar setup at hand (2.4 and 
PPC) to
run it - same result (thanks again Wolfgang!).
That leads me to the following conclusions:
- It's not a problem with my local setup of the toolchain, Adeos, Xenomai.
- It doesn't seem to be a problem with uClibc, since Wolfgang uses glibc.
>From my point of view this leaves room for locating the problem in the 
following areas:
- problem is related to the PPC as opposed to x86
- problem is related to kernel 2.4 (or something related to it, e.g. 
thread implementation)
- your hardware simply has a different timing and the problem doesn't show 
up.

Now I'm not sure how to proceed. My personal knowledge of the internals of 
Xenomai is
very probably not sufficient to find this rather tricky problem.

Thomas

