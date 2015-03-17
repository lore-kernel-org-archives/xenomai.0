MIME-Version: 1.0
Date: Tue, 17 Mar 2015 09:19:29 -0700
Message-ID: <CAEMXjGwam0jjOrUBgBY_FyFOaT15qHdobMo96G3bEsWx6rEcpA@mail.gmail.com>
From: Steve B <sbattazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Building with hard float: cannot open shared object file
	libpthread_rt.so.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hello all,

It has come to my attention that when compiling with arm-linux-gnueabi-gcc
my application is using a libm that seems to be doing soft floating point
routines when I really want to be using hard float.
I built a simple test application for now that does just one math operation
and measures the amount of time taken.

Switching my compiler to arm-linux-gnueabihf and adding the -mhard-float
flag, I get this error immediately at runtime:
error while loading shared libraries: libpthread_rt.so.1: cannot open
shared object file: No such file or directory

If I take away the -mhard-float flag, the program runs but the one math
operation (with a corner case argument that I found to take a long time to
compute) takes about 3000 microseconds to run.
If I put the -mhard-float flag back in and take away Xenomai and run as a
regular Linux application, the same operation takes around 60 microseconds.

I also tried building the Xenomai on my target system with the
arm-linux-gnueabihf compiler and the -mhard-float flag at configure time,
but this didn't fix the problem.
Has anybody run across this before?

Thanks,

Steve
