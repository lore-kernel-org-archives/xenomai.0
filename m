Message-ID: <bc4264770703040818l43d966a1tba5d14fa3937c93a@domain.hid>
Date: Sun, 4 Mar 2007 16:18:31 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] syslogd breaking rt behaviour of xenomai?
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

I am using rtcan and so far its working. I have a device on a 1MB/s
CAN line and its working well.

However my 1ms and 2ms periodic tasks start to have badly oscillating
period-times as soon as my device puts so many messages in the message
buffer that it starts overflowing.

At least that is my analysis of the situation. Because as soon as the
bufferoverflows  syslogd starts writing system error messages telling
(if dmesg is called) that the buffer is overflowing and that a message
is discarded.

Now I can make the buffer larger but that will take longer to read out
and I don;t mind losing the messages. So how do i tell syslogd that it
is acceptable that the buffer is overflowing to make it less busy?

How could I make syslogd more quiet in general. It seems that it can
be a major real-time destroyer?

Hope someone can help.

Kind regards,

Roland Tollenaar.

