Subject: Re: [Xenomai-help] difficulties with simulator
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <9FB3A1B49A25D711A70700A0C9E1FABC017145F6@domain.hid>
References: <9FB3A1B49A25D711A70700A0C9E1FABC017145F6@domain.hid>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 08:46:14 +0200
Message-Id: <1158907574.4968.17.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Weber, Jeff" <JWeber@domain.hid>
Cc: "'xenomai@xenomai.org'" <xenomai@xenomai.org>

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

> 
> Initially, I was not able to build my application for the simulator,
> due to inability to find header files, like system.h;

This is very likely an installation issue. Those files should be
available under $prefix/include/asm-sim after "make install" has run.

>  as well as missing
> __xeno_user_init(), __xeno_user_exit symbols, and symbol main defined twice.
> Googling turned up Jan's invaluable demo application code for the simulator.
> It would be very handy to include this demo code with the simulator.
> 

ksrc/skins/vxworks,psos/demos contain examples including the proper
Makefile to use for building applications over the simulator. On needs
to use root_thread_init/exit as application entry/cleanup routines,
which are going to be mapped to __xeno_user_init/exit, depending on the
context (e.g. simulator or UVM).

> Currently, I am not able to build my C++ application for the simulator,
> using
> the gcic (gcc-2.95.3) instrumentor.  The older instrumenter is simply not
> able
> to parse newer constructs, like variable argument macros, __deprecated__
> attributes
> etc.  My application currently builds under gcc-3.3.6.  The associated
> header files
> are the source of many problems for the older gcic instrumentor.  I can
> direct
> gcic to use my gcc-3.3.6 preprocessor, but then the gcic (gcc-2.95.3)
> compiler
> cc1 starts encountering parsing errors.
> 
> I would welcome any suggestions for building my application for the
> simulator.

C++ is a showstopper if you need recent constructs to be supported. You
could still work around a few issues (__deprecated__ should be fixable
by some hack for instance), but others might be unsolvable. The
instrumenter is actually a patch against GCC, and it has never been
upgraded beyond 2.95.3 due to a lack of resources. Applications coded in
C language are much better supported (actually we use the simulator to
write new skins and debug generic portions of the nucleus), but this is
not going to help you, I guess.

> 
> (summary of my config:
> xenomai-2.2.0  (frozen at this version for now)
> xenosim-2.2.0
> Linux-2.6.17.4
> arch = i686
> gcic = gcc-2.95.3
> gcc = 3.3.6
> )
> 
> many thanks,
> Jeff Weber
> American SuperConductor
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



