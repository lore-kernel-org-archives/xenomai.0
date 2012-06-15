Message-ID: <4FDB96AE.4090008@antcom.de>
Date: Fri, 15 Jun 2012 22:10:22 +0200
From: Roland Stigge <stigge@antcom.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Debian bug report #677633: Xenomai posix skin : bug with
 nanosleep function
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Hi,

may I present the below bug report from Debian to the noble ranks of
Xenomai developers.

See also http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=677633

Bug or feature? ;-)

Thanks in advance,

Roland

=========================================================================
Package: xenomai
Version: 2.6.0

Kernel:2.6.38.8 - Xenomai:2.6.0
arch:i686 i386 GNU/Linux

Hi,

The nanosleep_test.c code shows a malfunction of the nanosleep function
when a timer periodically triggering a signal.
When nanosleep is interrupted the variable holding the rest of the time
to sleep is immediately zero.



However, no bug is reported without the xenomai's posix skin.


Duchesne Alexandre
duch.alexandre@gmail.com

