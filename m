From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17655.28122.163232.842311@domain.hid>
Date: Fri, 1 Sep 2006 01:16:42 +0200
Subject: Re: [Xenomai-help] Kernel panic with Xenomai SMP kernel
In-Reply-To: <44F75C54.90608@domain.hid>
References: <44F6E774.2000701@domain.hid> <44F72F35.4070109@domain.hid>
	<44F75C54.90608@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Webb <jeff.webb@domain.hid>
Cc: xenomai@xenomai.org

Jeff Webb wrote:
 > Hello Xenomai crew,
 > 
 > A few months ago, I tried out xenomai 2.1-rc3 and 2.1-rc4 on my Fedora Core 1 system.  (2.4 kernel / standard AMD Athlon XP machine.)  At that time, I was able to patch the kernel and install xenomai without too much trouble.
 > 
 > Now, I am setting up a new machine to start the more serious work of
 > porting our existing rtlinux simulation to xenomai.  The new machine
 > is an Athlon64 X2 processor running Fedora Core 5.  I realize that
 > the x86_64 architecture is not supported, so I installed the 32-bit
 > version of FC5 on a second partition for use with xenomai.  I
 > attempted to compile a xenomai-patched SMP kernel using my 32-bit OS,
 > but got a kernel panic when I tried to boot it.  After much fiddling
 > with config options, I discovered that if I disable SMP, the kernel
 > will boot fine, and the xenomai latency test appears to give good
 > results.  This is a good sign, but I would obviously prefer to use my
 > second processor, if possible.  I am hoping someone on this list will
 > be able to help me track down the problem. 

Do you have spinlock debugging enabled ? If yes, try turning it
off. Could you also post your full .config ?


-- 


					    Gilles Chanteperdrix.

