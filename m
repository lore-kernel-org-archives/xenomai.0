Message-ID: <5431959D.8060504@xenomai.org>
Date: Sun, 05 Oct 2014 21:01:49 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] [ANNOUNCE] Xenomai 3.0-rc1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>


We are pleased to announce the official release of Xenomai 3.0-rc1,
which starts the candidate release cycle for Xenomai 3.

Xenomai 3 is the new architecture of our real-time framework,
which can run its APIs side-by-side with Linux as a co-kernel system
delivering very low latencies, or natively over unmodified Linux
kernels. In the latter case, the mainline kernel can be supplemented by
the preempt-rt patch to meet stricter real-time requirements.

The dual kernel configuration is currently supported over arm 32bit,
powerpc32, powerpc64, x86_32, x86_64 and blackfin, with a port to
aarch64 planned on Q1-2015. The single/native kernel configuration runs
on any CPU architecture Linux supports.

= What's new in Xenomai 3?

http://xenomai.org/introducing-xenomai-3/

= How to migrate from Xenomai 2.x?

http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/

= Where is the code?

http://git.xenomai.org/xenomai-3.git/
http://download.gna.org/xenomai/testing/latest/xenomai-3.0-rc1.tar.bz2

Thanks to all Xenomai contributors, and to the companies who made this
possible, mainly by directly funding the development of some of the
Xenomai 3 features, or giving access to the latest hardware.

-- 
Philippe.


