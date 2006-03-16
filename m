Message-ID: <4419D38E.7060007@domain.hid>
Date: Thu, 16 Mar 2006 16:07:26 -0500
From: Josh Bowman <jbowman@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Valgrind and xenomai?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Has anyone made Valgrind work on a xenomai user-space application?

My attempts so far (with valgrind 2.4.0 and 3.1.0 from gentoo) has lead to:

  --25174-- WARNING: unhandled syscall: 555
  --25174-- Do not panic.  You may be able to fix this easily.
  --25174-- Read the file README_MISSING_SYSCALL_OR_IOCTL.
  Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
  (modprobe xeno_native?)

The native skin *was* loaded (the program runs without valgrind).  I
think this means that valgrind needs to have code added to handle the
xenomai system calls-- but I could find no mention of xenomai on
valgrind.org (including the release notes archives).

Thanks in advance!
Josh Bowman



