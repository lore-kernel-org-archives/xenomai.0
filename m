Message-ID: <2F8EE677D406514ABE53EF9C0934A666042ABDF6@domain.hid>
From: Laurent.POYART@fr.thalesgroup.com
Date: Fri, 23 Nov 2007 15:04:23 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Subject: [Xenomai-help] Communications between Threads
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

Dear all,

I'm new in using xenomai and I'd like to use it for an embedded application in which I have standard linux drivers and RTDM drivers. I plan to use real-time threads for critical activities and regular linux threads soft real-time activites. Some real-time threads will communicate with regular linux threads (events and/or time notifications for example). As a part of my system, I could have a regular linux thread dynamically configured by another regular linux thread and notified of events by a real-time thread.
I'd like to put in place a framework which encapsulate, among other things,thread communications mechanism and in this way I'd like to avoid multiple mechanisms to communicates between threads (nonRT<->nonRT  / nonRT<->RT) as I could do with a RTOS, but I don't know exactly what is possible to do with xenomai:
*	Is it possible to use a single mechanism to communicate between threads (standard posix message queues, xenomai message pipe, others)? What kind of mechanism? 
*	Is it possible to use a standard posix message queue within a real-time thread and how do I affect the real-time thread behaviour?

Thanks .
L.Poyart.




