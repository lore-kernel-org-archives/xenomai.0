Message-ID: <1311186948.84516.YahooMailClassic@domain.hid>
Date: Wed, 20 Jul 2011 11:35:48 -0700 (PDT)
From: Philip Ha <philwman@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1903409025-1311186948=:84516"
Subject: [Xenomai-help] clock problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--0-1903409025-1311186948=:84516
Content-Type: text/plain; charset=us-ascii


Hi All,

I would like to add some more details for the message I posted on 19 July.

The timing period for the testing is 1 second intervals. So every second, I will
call clock_gettime to get the current time, and measures the elapsed time
(or latency) between 2 events (messages).

The event is triggered by the function generator, which send s a pulse signal 
to the serial port at one second intervals.

Can someone please advise me about the unstable elapsed time (latency)
after the reboots.

Regards,
Philip Ha


--0-1903409025-1311186948=:84516
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;"><br>Hi All,<br><br>I would like to add some more details for the message I posted on 19 July.<br><br>The timing period for the testing is 1 second intervals. So every second, I will<br>call clock_gettime to get the current time, and measures the elapsed time<br>(or latency) between 2 events (messages).<br><br>The event is triggered by the function generator, which send s a pulse signal <br>to the serial port at one second intervals.<br><br>Can someone please advise me about the unstable elapsed time (latency)<br>after the reboots.<br><br>Regards,<br>Philip Ha<br><pre><br></pre></td></tr></table>
--0-1903409025-1311186948=:84516--

