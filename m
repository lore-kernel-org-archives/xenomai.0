Message-ID: <e4ef24880711121452p631a5e05ud7ada7595fd1f4e3@domain.hid>
Date: Mon, 12 Nov 2007 15:52:05 -0700
From: "Robert Gubler" <rgubler@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_22753_10054260.1194907925730"
Subject: [Xenomai-help] Time critical tasks
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

------=_Part_22753_10054260.1194907925730
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I have a task that is very time critical.  I used the xenomai/bin/latency
program to get an idea of my worst case latency; its about 30 us.  Is there
a facility in POSIX or the POSIX skin, that will allow me to account for
this worst case latency? Does clock_nanosleep() provides this?  Essentially
I'd like to wake up 30 us before the deadline and turn off interrupts, and
do a spin lock until the deadline is reached.

-Rob

------=_Part_22753_10054260.1194907925730
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br><br>I have a task that is very time critical.&nbsp; I used the xenomai/bin/latency program to get an idea of my worst case latency; its about 30 us.&nbsp; Is there a facility in POSIX or the POSIX skin, that will allow me to account for this worst case latency? Does clock_nanosleep() provides this?&nbsp; Essentially I&#39;d like to wake up 30 us before the deadline and turn off interrupts, and do a spin lock until the deadline is reached.
<br><br>-Rob<br>

------=_Part_22753_10054260.1194907925730--

