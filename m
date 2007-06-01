Message-ID: <465FE1D5.6070906@domain.hid>
Date: Fri, 01 Jun 2007 11:07:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Problem trying to find secondary mode switches.
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


Hi,

I am using the XNTRAPSW option to try and find secondary mode switches
in some piece of code for which I do not have the sources. I have
installed the usual signal handler which dumps the backtrace, just as in
ksrc/skins/native/snippet/sigxcpu.c. But the problem is that the
backtrace is not helpful, it show addresses in libpthread and
libpthread_rt global destructor sections.

By adding some printks in shadow.c I know that what causes the mode
switch is the linux arm syscall 78 aka gettimeofday.

So, my question is: is there any chance that the signal sent by send_sig
in xnshadow_relax could be received by another thread than send_sig
target ? If not, where should I look for the reason of this wrong
backtrace ?


-- 
                                                 Gilles Chanteperdrix

