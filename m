Message-ID: <4414A869.5020809@domain.hid>
Date: Mon, 13 Mar 2006 00:02:01 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.1
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


As Alan B. Shepard once put it, "It's been a long way, but we're here". v2.1 final 
is now on GNA's download area, with only few changes since -rc4. This milestone is 
important in that most - if not all - of the annoying legacy inherited from the 
RTAI/fusion times has been resolutely reworked more sanely. Here are the major 
evolutions you will find in this release, in no particular order:

- Complete integration of Xenomai's kernel components into the Linux kernel build 
system, which among other things, enables static builds of Xenomai within a kernel 
image, while keeping the modular builds available on option.
- Complete decoupling between Xenomai's kernel and user-space components, which in 
turn largely improves friendliness toward other languages than C for application 
developers, and makes an ABI slowly emerge.
- Improved scalability for supporting resource consuming applications.
- Fully compatible backports to Linux 2.4 for x86 and ppc32.
- Two new architecture ports, to ARM and Blackfin.
- Significant extension of the POSIX API accessible from user-space (shm, named 
semaphores, cancellation requests, real-time signals).
- Shared real-time interrupt support.
- Improvement of the Native API.
- Extension of the RTDM support.
- Upgrade of the Adeos support to the latest I-pipe series for all architectures.

And generally speaking, literally tons of fixes, cleanups, optimizations all over 
the map.

Special thanks to the increasing number of people who contributed code, ideas, 
review, documentation, help to newcomers.

http://download.gna.org/xenomai/stable/xenomai-2.1.tar.bz2

-- 

Philippe.

