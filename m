Message-ID: <4A9E4022.7050705@domain.hid>
Date: Wed, 02 Sep 2009 10:51:30 +0100
From: dev.chmeie@domain.hid
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Any example freezes immediately
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
My current state is as follows:
-2.6.30.5 with ipipe running, apm + cpufreq disabled
-xenomai userland compiled and installed

When I try to run any of the examples I get 2 nice blinking leds on the 
keyboard
and additionally a kernel stack corruption message and a freezed pc.

What could be wrong? Maybe any other kernel options I missed?

By the way, I get some index out of bounds warnings when compiling the 
kernel.
When I recall it correctly it was in a file asm/include/io.h or similar 
of xenomai).
But I still hadn't enough time to look into it.

Thanks

Chris


