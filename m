Date: Wed, 30 May 2012 11:08:08 +0200 (CEST)
From: aubin.rebillat@free.fr
Message-ID: <35191140.199124743.1338368888649.JavaMail.root@spooler3-g27.priv.proxad.net>
In-Reply-To: <2129974902.198997874.1338366582292.JavaMail.root@spooler3-g27.priv.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Feature synchronisation with FASTSYNCH on TS-7553
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I made a Xenomai 2.6 port on the TS-7553 SBC based on the cns2132/str8132 
SoC (armv4 CPU) with a kernel 2.6.24. I wanted to test the port using the 
Xenomai tests binaries (switchtest, clocktest, latency,...) but I'm having 
configuration issues in the feature synchronisation between user-space 
and kernel-space:        
$ /usr/xenomai/bin/switchtest
Xenomai : incompatible feature set
(userland requires "fastsynch nosmp", kernel provides "sa1100 eabi tsc 
nofastsynch", missing="fastsynch").

I compiled the kernel and user-space following exactly the procedure for 
ARM in the README.INSTALL.
In the kernel configuration for the CPU (arch/arm/mm/Kconfig), CPU_32v4 is 
selected which disables XENO_FASTSYNCH_DEP. 
Therefore the kernel configuration has correct features but in the log of 
the user-space configure script CONFIG_XENO_FASTSYNCH_TRUE is set.

I understood that the user-space configuration is based on the kernel 
.config but in my case the .config does not contain any line with 
CONFIG_XENO_FASTSYNCH (not even a commented one), it contains only
CONFIG_CPU_32v4 set to y.

Does anybody have an idea about what i missed ?
By the way, what is this FASTSYNCH feature and what does it provide ?

Thank you,

-- 
REBILLAT Aubin

