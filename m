MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18046.43281.454448.814965@domain.hid>
Date: Sun, 24 Jun 2007 19:25:37 +0200
In-Reply-To: <f48df4840706240643j2046afa0pd69452874264fb1f@domain.hid>
References: <f48df4840706240643j2046afa0pd69452874264fb1f@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Problem building and running demos
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bruno Rouchouse <brouchouse@domain.hid>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

Bruno Rouchouse wrote:
 > Hi Xeno users !
 > 
 > just trying to play with Xenomai's demos but I'm having some problems
 > compiling and running some of them.
 > 
 > Satch for the native skin
 > ==============
 > 
 > I have some troubles here compiling satch.
 > 
 > bruno@domain.hid$ make
 > cc -o satch satch.c -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT
 > -D__XENO__ -L/usr/xenomai/lib -lpthread -lnative
 > /usr/lib/gcc/i486-linux-gnu/4.1.2/../../../../lib/crt1.o: In function
 > `_start':
 > ../sysdeps/i386/elf/start.S:115: undefined reference to `main'
 > collect2: ld returned 1 exit status
 > 
 > Satch for the posix skin
 > ==============
 > 
 > Building process works fine but running satch fails :
 > My .runinfo file looks like:
 > satch:posix:!./satch_rt;popall:control_c
 > 
 > bruno@domain.hid$ xeno-load ./:satch
 > *
 > *
 > * Type ^C to stop this application.
 > *
 > *
 > Satch: producer module not running, please launch producer module before
 > launching consumer application.
 > __xeno_user_init: 2
 > 
 > I understand from xenomai/ksrc/skins/posix/demos/Kbuild and going quickly
 > through satch.c code that there should be a first module to insmod before
 > using the consumer module but how/when is the producer module supposed to be
 > built? I don't find any other module in my xenomai built tree or in my
 > /lib/modules/*-ipipe kernel.

You are supposed to run:
make -C /path/to/your/kernel/sources M=$PWD modules
because you know how to compile kernel modules outside of the kernel
tree. You then have a ksatch.ko kernel module. It does not even work
with 2.4 kernels.

This was more intended as a test for posix shared memory and
message queues support, than as a real demo for users. I just did not
find anywhere else to put it.

What we could do is to compile the default version with -DPRODUCER
-DCONSUMER so that it would be standalone.

-- 


					    Gilles Chanteperdrix.

