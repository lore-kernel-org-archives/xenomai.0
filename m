Message-ID: <45DB5A29.9080506@domain.hid>
Date: Tue, 20 Feb 2007 21:29:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: [Xenomai-help] pcspeaker
Reply-To: rolandtollenaar@domain.hid
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

Hi

I have some form of kernel recompiled in which I have the power
management turned off. The PCspeaker is also unselected but it comes
alive anyway. This is the result -or so it seems- of the soundcard
driver. I would like to rmmod the sound card driver after booting if
this interferes with xenomai but there are so many dependencies snd-this
and snd-that, that its not trivial.

-Is this sound-card driver a problem for xenomai?
-how can I be sure that the pc speaker is harmless for xenomai

Kind regards,

Roland.


