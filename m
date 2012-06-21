MIME-Version: 1.0
Date: Thu, 21 Jun 2012 22:14:18 +0200
Message-ID: <CA+K6ZL0db_K0NsuEcKrQO9rcJ4myrx6QVge6i7HyMEkDhkwWww@mail.gmail.com>
From: Remco den Breeje <remco@vioco.nl>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] ARM I-pipe patch for 3.1+ kernels
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Gilles et.al.,

I'm interested in running a Xenomai patched system on a Raspberry Pi
computer[1] that compromises a ARM11 CPU (ARMv6 architecture). The Linux
kernels supported on the Raspberry are either Linux 3.1 or 3.2 [2,3], while
the most recent ARM ipipe patch is written for a 3.0 kernel. Looking at
your ipipe git[4], there hasn't been ARM related work for more recent
kernels.
What are the changes of a forward port, rebased on 3.1 or 3.2 kernels? Are
there underlying technical difficulties?

I'm aware that even if there was a >3.0 ARM patch available, the Raspberry
specific code needs to be ported. However, being a ARM-newby, porting board
specific code together with porting the ipipe code is one step too far ;)

Many thanks,

Remco den Breeje

[1] http://en.wikipedia.org/wiki/Raspberry_Pi
[2] https://github.com/raspberrypi/linux
[3] https://github.com/bootc/linux
[4] http://git.denx.de/?p=ipipe.git;a=summary
