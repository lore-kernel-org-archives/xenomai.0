Message-ID: <493E3ED4.7090405@domain.hid>
Date: Tue, 09 Dec 2008 10:48:04 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Debugging RT threads with GDB on ARM/PowerPC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

Hello,

I understood that GDB can be used to debug Xenomai real-time
applications but it seems not to work with my application on PowerPC or
ARM. The applications looses determinism quickly, mainly because RT
threads switch to secondary mode somehow. Have I missed something? Are
there any known issues with GDB on ARM or PowerPC?

Wolfgang.

