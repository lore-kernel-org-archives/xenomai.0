MIME-Version: 1.0
From: =?UTF-8?B?0J/QsNGI0LAg0KHQtdGH0LrQvg==?= <bronetemkinponosec@gmail.com>
Date: Fri, 23 Aug 2013 11:47:47 +0300
Message-ID: <CAP=r9tO8PueS5EX_ijQ4uE4oJnaXh1rMZ3T6uDdK=-LzLFH1cQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] xenomai i.MX6 cross-compilation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I am trying to cross-compile a 3.0.35 linux kernel with some custom
development patches for a i.MX6-based board. I've used ipipe-gch repository
as a start point for my work, checked out to ipipe-3.0-imx6q branch,
because it has some files and instructions to work with (arch/arm/mach-mx6
and plat-mxc). I've added some board specific code to them and have
redacted configs so they would compile, and after that I've used
xenomai-2.6.1 release as it was said in the README.INSTALL file. Everything
seemed to be well so far, the kernel has started, and I've got the same
boot lines I've had to get:

I-pipe: head domain Xenomai registered.
Xenomai: hal/arm started.
Xenomai: scheduling class idle registered.
Xenomai: scheduling class rt registered.
Xenomai: real-time nucleus v2.6.1 (Light Years Away) loaded.
Xenomai: debug mode enabled.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.

So the problem is, when I try to start any application, either from the
testsuite or the example I've found in the net (
www.cs.ru.nl/lab/xenomai/exercises/ex01/Exercise-1.html), I get this
message:

xenomai or config_xeno_opt_pervasive disabled
(modprobe xeno_nucleus?)


I've tried compiling the kernel either with built-in and module xenomai,
but I get the same mistake again and again, even if I've just used modprobe
to load xeno_nucleus into the system.


-- 
sincerely, Paul
