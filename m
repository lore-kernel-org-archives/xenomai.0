From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17435.1835.845947.604189@domain.hid>
Date: Fri, 17 Mar 2006 19:59:55 +0100
Subject: Re: [Xenomai-help] Valgrind and xenomai?
In-Reply-To: <4419D38E.7060007@domain.hid>
References: <4419D38E.7060007@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Josh Bowman <jbowman@domain.hid>
Cc: xenomai@xenomai.org

Josh Bowman wrote:
 > Has anyone made Valgrind work on a xenomai user-space application?
 > 
 > My attempts so far (with valgrind 2.4.0 and 3.1.0 from gentoo) has lead to:
 > 
 >   --25174-- WARNING: unhandled syscall: 555
 >   --25174-- Do not panic.  You may be able to fix this easily.
 >   --25174-- Read the file README_MISSING_SYSCALL_OR_IOCTL.
 >   Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
 >   (modprobe xeno_native?)
 > 
 > The native skin *was* loaded (the program runs without valgrind).  I
 > think this means that valgrind needs to have code added to handle the
 > xenomai system calls

Yes, I am afraid. And looking at README_MISSING_SYSCALL_OR_IOCTL, there
is a lot of code to add.

But there is a way to run your programs with valgrind: use Xenomai
discrete event simulator, configured with the --enable-atomic-core
flag.

-- 


					    Gilles Chanteperdrix.

