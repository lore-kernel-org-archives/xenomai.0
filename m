Date: Wed, 25 Jun 2008 09:33:56 +0200
Message-Id: <838862596@domain.hid>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@domain.hid>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] latency in kernel mode
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

Hi

I still don't know what to do with the latency test in kernel mode. Every others test works fine except for the IRQ test, but I was told this is normal for an non x86 architecture. Can anybody give me a hint what I can do? What would probably be the problem? How important is it, that that test won't work? Should I ignore it and start with programming some real-time-stuff? But if I start now and get problems later I would always think, the failed test could be the reason for the problem too....

Here's the output:
---------------------------------------------------------------------------------------------
bash-3.00# cd /usr/xenomai/testsuite/latency/
bash-3.00# ./run -- -t1
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel periodic task
== All results in microseconds
latency: failed to start in-kernel timer benchmark, code -25
---|------------|------------|------------|--------|-------------------------
RTS|  267928.028|  805352.732|      32.768|       0|    00:00:10/00:00:10
bash-3.00#
----------------------------------------------------------------------------------------------

Thanks for your help and patience.
Joachim
____________________________________________________________________
Ihre Messenger, Communities und E-Mails jetzt in einem Programm!
WEB.DE MultiMessenger http://www.produkte.web.de/messenger/?did=3071


