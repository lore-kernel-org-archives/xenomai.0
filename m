From: witzel.thomas@domain.hid
Date: Mon, 13 Nov 2006 14:00:00 +0000
Message-Id: <111320061400.15794.45587A600000DBC400003DB222070229339C0E0301089BD2040A969B0799@domain.hid>
Subject: [Xenomai-help] waiting in rtdm drivers
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

Hello all,

I'm making slow progress with the sound driver. One question has been bothering me. How do I wait properly in a rtdm driver routine, i.e. I need to wait a few microseconds for a register to "settle" or for the codecs to come back from reset. This would be required in both routines that can be called from realtime as well as non-realtime tasks.

Thanks, Thomas

