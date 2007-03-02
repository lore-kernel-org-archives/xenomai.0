Message-ID: <bc4264770703021005g52d0e416i359e9de91bcd38c9@domain.hid>
Date: Fri, 2 Mar 2007 18:05:00 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] some problems using RTCAN on PEAK dongle
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

Ok rtcan2 and the peak dongle seem to be working. I am now running
into new problems with my application.

The first question is how do I reset the ctrl_mode to nothing.
Listen-only and loopback are both debugging/testing states but how do
I reset them to ....what is the normal state called? At the moment I
am in loop_back mode all the time.

I am writing to rtcan2 from my application and subsequently reading
from it. Works by the look of things BUT my CPU is working overtime.
syslogd and klogd are consuming 50-60% plus 30-40% of the processor
time. Obviously everything gets sticky but I can still see that the
task times are being maintained and the actual applicaiton is using
less than 3% of the processor time.

Besides this simple can functionality there is nothing happening in
the tasks and this does not happen if I write and read on rtcan0.

Finally after a long while of running and stopping the application I
get the message

rt_dev_bind: -no space left on device.

This bind is called before the read-call.

Can anyone please shed some light on these issues. Much appreciated as usual.

Kind regards,


Roland

