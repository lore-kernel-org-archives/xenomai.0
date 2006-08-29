Message-ID: <75975c320608290736r52e642fcrc2e9c5edb1551d03@domain.hid>
Date: Tue, 29 Aug 2006 10:36:18 -0400
From: "Paul Ianna" <paulianna2002@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] rt_dev_ioctl serialization
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

Greetings,

Background:

I have not (yet) studied or written a linux or rtdm device driver.  I
am, however, using one whose source with which I am unfamiliar.  My
particular scenario involves a communications device driver written to
by many asynchronous tasks with varying priorities.  I am concerned
that I may need to provide protections in front of the rt_dev_ioctl
call to ensure coherency.


Question:

Does a call to rt_dev_ioctl implicitly handle serialization or is it
each driver's  (or application's) responsibility to take care of
serialization/reentrancy issues?


Thanks in advance,
Paul

