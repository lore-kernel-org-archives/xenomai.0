From: Jeremy Friesner <jaf@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Wed, 6 Jul 2011 13:38:20 -0700
Message-Id: <C15B4995-28DC-403B-8117-B9F8062571D4@domain.hid>
Mime-Version: 1.0 (Apple Message framework v1084)
Subject: [Xenomai-help] Xenomai 2.5.3 vs gettimeofday() --> livelock?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi all,

I'm developing a product that consists of a small number of x86 Linux =
boxes connected over a LAN.  These boxes run Debian Linux with Xenomai =
2.5.3 installed.  In order to co-ordinate their activities, they all run =
ptpd (as a Linux userspace daemon) to synchronize their clocks, as =
returned by gettimeofday().

The issue we're having is that occasionally (maybe once or twice a week, =
or even less), at a seemingly random time, one of these boxes (not =
always the same one) will simply quit working... it stops responding to =
pings, stops sending or receiving network traffic, etc.   We suspect =
(but haven't yet proved) that this is due to the box's Xenomai real-time =
thread spinning in-place somewhere, causing the Linux kernel to quit =
running.

Our Xenomai real-time thread doesn't do much (mainly ot just copies a =
fixed amount of data from one location to another), but it does =
occasionally call gettimeofday(), in order to record the current =
correlation between the PTP-based Linux clock and the Xenomai =
rt_timer_tsc() clock, so that it can account for drift between them.

=46rom reading this post, it seems like the call to gettimeofday() might =
be the culprit:

	http://www.mail-archive.com/xenomai@xenomai.org

My first question is:  Am I right in suspecting that gettimeofday() can =
occasionally spin/livelock, when called from a Xenomai 2.5.3 real-time =
thread?  FWIW, it gets called from the real-time thread once every =
333mS.

And if that is the case, my second question is:  Is there an alternative =
"safe" way to call gettimeofday() (or something equivalent) so that the =
real-time thread can find out the current PTP system time?  Or do I need =
to re-write my code so that the real-time thread never calls =
gettimeofday()?

Is there a recommended practice for using Xenomai threads in conjunction =
with PTP?

Thanks,
Jeremy


