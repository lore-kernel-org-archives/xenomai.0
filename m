Message-ID: <9FB3A1B49A25D711A70700A0C9E1FABC017145F6@domain.hid>
From: "Weber, Jeff" <JWeber@domain.hid>
Date: Thu, 21 Sep 2006 17:54:17 -0400
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Xenomai-help] difficulties with simulator
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "'xenomai@xenomai.org'" <xenomai@xenomai.org>

Hello:

I am having considerable difficulties building and running
the Xenomai simulator.  My goals are to run Xenomai
real time applications under both the Valgrind memory debugger
and gdb.  Is the Xenomai simulator the only environment for
doing these?

Initially, I was not able to build my application for the simulator,
due to inability to find header files, like system.h; as well as missing
__xeno_user_init(), __xeno_user_exit symbols, and symbol main defined twice.
Googling turned up Jan's invaluable demo application code for the simulator.
It would be very handy to include this demo code with the simulator.

Currently, I am not able to build my C++ application for the simulator,
using
the gcic (gcc-2.95.3) instrumentor.  The older instrumenter is simply not
able
to parse newer constructs, like variable argument macros, __deprecated__
attributes
etc.  My application currently builds under gcc-3.3.6.  The associated
header files
are the source of many problems for the older gcic instrumentor.  I can
direct
gcic to use my gcc-3.3.6 preprocessor, but then the gcic (gcc-2.95.3)
compiler
cc1 starts encountering parsing errors.

I would welcome any suggestions for building my application for the
simulator.

(summary of my config:
xenomai-2.2.0  (frozen at this version for now)
xenosim-2.2.0
Linux-2.6.17.4
arch = i686
gcic = gcc-2.95.3
gcc = 3.3.6
)

many thanks,
Jeff Weber
American SuperConductor

