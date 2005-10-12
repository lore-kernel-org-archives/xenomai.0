From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17229.12621.620087.85940@domain.hid>
Date: Wed, 12 Oct 2005 17:52:45 +0200
Subject: Re: [Xenomai-help] Kernel oops on posix threads
In-Reply-To: <434D2CCD.4070802@domain.hid>
References: <434D2CCD.4070802@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Luotao Fu <devtty0@domain.hid>
Cc: xenomai@xenomai.org

Luotao Fu wrote:
 > Hi folks,
 > 
 > I found out that parallel threads using the Posix skin cause kernel oops
 > somewhere between the finishing of the threads and the main thread. I
 > have two threads, say thread A and thread B. Both created as joinable
 > threads and they have both the same priority 99. The main routine hold a
 > semaphore semA to synchronize the threads. After the creation thread A
 > waits on the Semaphore semA, while the thread B runs and releases semA,
 > so that semA can finish. On exiting the thread B I always get a Kernel
 > ooops. The kernerl says:
 > 
 > unable to handle kernel paging request at virtual address 6b6b6b77
 > etc.......

Thanks a lot for your report, it is almost perfect. However, it would be
really helpful to have the "etc...." in order to have a stack dump and
have a quick look at the code before trying to reproduce the situation
here.

 > 
 > I scratched some simple code which causes this Kernel Ooops. Packed a
 > tar ball together with the makefile and attached the tar ball it to this
 > mail so that you might have a look at it yourself.
 > I'm using
 > Kernel: Vanilla 2.6.12 patched with adeos-linux-2.6.12-i386-r12.patch
 > Distr. Debian 3.1
 > Testhost: vmware 5.0
 > compiler gcc 3.3.5
 > 
 > I also wrote some code doing the same tasks in RTAI native context and
 > it ran without problems. Hence I suppose the problem to be in the posix
 > skin.
 > Am I making any mistakes in the code or have I evtl. found a bug in the
 > posix skin?

A kernel oops is almost always certainly a bug... Could you tell me
whether this happens even the first time after insertion of the
rtai_posix module ?
Also, why do you link your program with the rtai library, rtai-config
--posix-ldflags should be enough ?

-- 


					    Gilles Chanteperdrix.

