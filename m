Message-ID: <1ce16a2c0709140419t768d81e1i5a2fcac6949c66bb@domain.hid>
Date: Fri, 14 Sep 2007 13:19:01 +0200
From: "Bachman Kharazmi" <bahkha@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] realtime - device file - userland
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai <xenomai@xenomai.org>

Hi,
As I've understood it rtser0 is a non-linux device not existing in
/dev. But what I would like is a device file somewhere on my
filesystem which I can write to from userland. If it's a virtual
device file or not d oesn't matter, but it should be a accessable file
from linux userland.

What are the options to achive something similar?

Of course I don't expect the gap between
userland<=>(virtual?)/dev/myDevice to be realtime.

What I will try to do is that as user I want to be able to write data
to the device. Then with native code do periodic checks, if there's
any data, write it to serial.

Are there any examples/documentation that do show more on this?

thanks guys.
Bachman

