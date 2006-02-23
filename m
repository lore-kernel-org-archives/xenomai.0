Date: Thu, 23 Feb 2006 15:01:31 -0800
From: Steven Seeger <steve@domain.hid>
Message-ID: <C0237ECB.24E3%steve@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
Subject: [Xenomai-help] problems solved
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Well, I solved my problems by getting rid of the geode. On a 400 mhz celeron
board, everything works great. My software used 100% of the CPU on the geode
and locked up the Linux side when the stepper motor would run, but on the
celeron it uses a negligible amount of the CPU. This is good for me to see
that the problem isn't with my code probably, but bad that Xenomai seems to
have issues on the Geode that RTAI/fusion did not.

Just giving you all a heads up. The geode sucks anyway.


