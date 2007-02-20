Message-ID: <bc4264770702201537x2bd55cc1l713471dafc23f301@domain.hid>
Date: Tue, 20 Feb 2007 23:37:56 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] tsc enable or disable
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

I have a  xenomai kernel running!

I have tested using the testsuit latency ./run program. initially I
got this message

Xenomai: incompatible feature set.
(required="sep tsc", present= "sep", missing="tsc")

Which I "sorted" by configuring the user part of xenomai with --disable-x86-tsc

However I understood from previous mails that TSC was good. Did I miss
a setting when configuring the kernel?

What does this TSC mean. The documentation is very spars about this.

Ehh and while I think about it, what is displayed by the latency test. I get

lat min  lat ave latmax overrun lat best
20.11   29.33   52.79  0            19.276

typical.

The period seems to be 100micro seconds so what do the figures above
mean? 20 microseconds is typically the shortest period I could run at?
Or >52.79? Some light on this would be great.

Kind regards,

And thanks for all the help.

Roland.

