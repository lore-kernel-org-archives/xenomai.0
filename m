Message-ID: <e4ef24880711091329g3dd27f0ds6fe033ef79993022@domain.hid>
Date: Fri, 9 Nov 2007 14:29:26 -0700
From: "Robert Gubler" <rgubler@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_14288_25562194.1194643766375"
Subject: [Xenomai-help] Synchronizing CLOCK_REALTIME between networked
	computers
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

------=_Part_14288_25562194.1194643766375
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I'd like to synchronize CLOCK_REALTIME between some computers that share an
Ethernet switch.  I am using RTNet as my networking stack.  My approach
right now is very simplistic.  I have a central server that will be sending
out one 1 packet per second, with its struct timespec it got as a result of
calling clock_gettime(CLOCK_REALTIME,...). The computers listening for this
packet would then call clock_settime(CLOCK_REALTIME,..).

In the Xenomai POSIX skin API doc it says clock_settime() isn't supported.
Is there a recommended approach to accomplishing this?   I am using Xenomai
2.4-rc4.

-Rob

------=_Part_14288_25562194.1194643766375
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br><br>I&#39;d like to synchronize CLOCK_REALTIME between some computers that share an Ethernet switch.&nbsp; I am using RTNet as my networking stack.&nbsp; My approach right now is very simplistic.&nbsp; I have a central server that will be sending out one 1 packet per second, with its struct timespec it got as a result of calling clock_gettime(CLOCK_REALTIME,...). The computers listening for this packet would then call clock_settime(CLOCK_REALTIME,..).&nbsp; 
<br><br>In the Xenomai POSIX skin API doc it says clock_settime() isn&#39;t supported.&nbsp; Is there a recommended approach to accomplishing this?&nbsp;&nbsp; I am using Xenomai 2.4-rc4.<br><br>-Rob<br>

------=_Part_14288_25562194.1194643766375--

