Message-ID: <1ce16a2c0709130245m6c73abd3tc8023237e03f70f2@domain.hid>
Date: Thu, 13 Sep 2007 11:45:37 +0200
From: "Bachman Kharazmi" <bahkha@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] too fast write to serialport?
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

Hi!
I try to print to serialport using rtdm according to: http://pastebin.ca/695418

But if I don't have sleep(1) only "hello   " or similar is written to
the serialport.
But if I've sleep(1) "helloworld" is written every second as expected.

Is this some kind of limit how quickly I can write stuff on the rtser0?
How do I handle this?

/Bachman

