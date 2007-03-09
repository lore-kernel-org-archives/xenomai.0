Message-ID: <bc4264770703091023q585b5204x7333c0e8b9a4022d@domain.hid>
Date: Fri, 9 Mar 2007 18:23:55 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] RTCAN latency and RTR
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

Hi,

I was wondering whether someone could shed some light on an RTR based
approach. If (which I hope not but do fear) the 200 microsecond Rx-ISR
engagement time cannot be reduced or overcome, would an RTR approach
offer an alternative?

The thought:
If I make an RTR call to my node at the beginning of the period and
catch the response all within say 250microsec, I have 750 micoseconds
for task "work" as long as I can suppress any further disruption from
the Rx-ISR (i.e. block the rx interrupt or something during that
period)

I have never used RTR before but can imagine that it relies on the
normal receiving mechanism of the CAN driver to be up which of course
would not help.

Are there any generic (userspace) C calls with which interrupts can be
disabled (e.g. ioctl kind of things) which I could use to keep the
Rx-ISR quiet during the 750ms?

Regards,

Roland.

