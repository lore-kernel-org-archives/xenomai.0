Message-ID: <9FB3A1B49A25D711A70700A0C9E1FABC017145F7@domain.hid>
From: "Weber, Jeff" <JWeber@domain.hid>
Subject: RE: [Xenomai-help] difficulties with simulator
Date: Fri, 22 Sep 2006 09:06:36 -0400
MIME-Version: 1.0
Content-Type: text/plain
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

Philippe:

-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org] 
 Subject: Re: [Xenomai-help] difficulties with simulator

On Thu, 2006-09-21 at 17:54 -0400, Weber, Jeff wrote:
> Hello:
> 
> I am having considerable difficulties building and running
> the Xenomai simulator.  My goals are to run Xenomai
> real time applications under both the Valgrind memory debugger
> and gdb.  Is the Xenomai simulator the only environment for
> doing these?

At the moment, yes. Making Valgrind aware of Xenomai syscalls so that it
does not choke on them is on the todo list.

Are there other non-proprietary memory debuggers that currently work with
Linux/Xenomai?

> 
> Initially, I was not able to build my application for the simulator,
> due to inability to find header files, like system.h;

This is very likely an installation issue. Those files should be
available under $prefix/include/asm-sim after "make install" has run.

Indeed the correct headers were installed, in $prefix/include/asm-sim.
However, gcic was not initially able to find the system.h header file
referenced from $prefix/include/nucleus/types.h :

#include <asm/xenomai/system.h>
              ^^^^^^^

Manually creating the $prefix/include/asm-sim/xenomai directory symlink
solved the problem.


Thanks for your help.
Jeff Weber

