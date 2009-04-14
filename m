Message-ID: <49E48C89.1050806@domain.hid>
Date: Tue, 14 Apr 2009 15:15:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <Pine.LNX.4.64.0904131821010.12546@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0904131821010.12546@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Fixing xeno-test
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Martin Shepherd <mcs@domain.hid>
Cc: xenomai@xenomai.org

Martin Shepherd wrote:
> I have been working on fixing the problems in xeno-test that I
> reported a few days ago. After spending most of yesterday fighting
> with the broken signal-handling behavior of the various bourne-shell
> derivatives, I came to the conclusion that it was impossible to
> reliably and portably clean up background workload processes using
> just shell signal handling. I thus decided to write a separate program
> that xeno-test could invoke, which would take care of running the
> background processes, restart any that terminated before xeno-test
> ended, and terminate them when xeno-test either exited normally or was
> terminated by a signal. I have done this now, incorporated it into
> xeno-test, and tested it while running xeno-test under bash, dash and
> busybox. My question is whether this approach is acceptible, and if
> so, how I should submit it for incorporation in xenomai?

I'd prefer to avoid adding this new program. xeno-test is already more
complicated than I would like, and I am almost sure that we can handle
differences between the shells by testing what shell we are running (for
instance using the SHELL variable) and using some explicit "ifs" in the
script.

> 
> In particular, for the program that manages the background workload
> processes (which is currently called xeno-stress), should I create a
> new directory for this under xenomai-head/src/testsuite/, and set up
> makefiles etc there, or should it go somewhere else?
> 
> In case anybody wants to see the code first, you can find the program
> source code and a simple makefile for compiling it, at:
> 
>    http://www.astro.caltech.edu/~mcs/xenomai/xeno-stress.c

I get a 404.

-- 
                                                 Gilles.

