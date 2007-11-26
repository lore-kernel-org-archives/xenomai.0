Message-ID: <e4ef24880711260132h730207b3j5629ff42805add6d@domain.hid>
Date: Mon, 26 Nov 2007 01:32:44 -0800
From: "Robert Gubler" <rgubler@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_5983_29654020.1196069564443"
Subject: [Xenomai-help] Xenomai on a Dell 6850; /usr/xenomai/bin/latency
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

------=_Part_5983_29654020.1196069564443
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am trying to get Xenomai 2.4-rc6 running on an SMP machine.  I am running
a 2.6.22 kernel, with adeos-ipipe-2.6.23-i386-1.10-12.patch.

After building the kernel I ran /usr/xenomai/bin/latency as a sanity check.
This is what I am getting as output:

== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:09  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|     -32.686| -352137.118| -230860.905|249855280|     -32.686| -
230860.905
RTD|     -36.039| -609219.441| -883326.616|481801356|     -36.039| -
883326.616
RTD|     -31.010| -259632.371| -151198.013|735561242|     -36.039| -
883326.616
RTD|     -32.686| -578358.265| 1084683.558|968914361|     -36.039|
1084683.558



It took a few attempts to Xenomai to build, in a way that the executables in
/usr/xenomai/bin/ would execute without complaining:

(required="sep tsc", present="sep", missing="tsc").

The arguments that ended up making it work were:

./configure --enable-x86-sep --disable-x86-tsc


Any thoughts or suggestions as to whats going on?  This machine has
considerably more 'horsepower' than the Desktop machines I am also running
Xenomai on.  But, these latency times are *way* out there.

-Rob

------=_Part_5983_29654020.1196069564443
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am trying to get Xenomai 2.4-rc6 running on an SMP machine.&nbsp; I am running a 2.6.22 kernel, with adeos-ipipe-2.6.23-i386-1.10-12.patch.<br><br>After building the kernel I ran /usr/xenomai/bin/latency as a sanity check.&nbsp; This is what I am getting as output:
<br><br>== Sampling period: 100 us<br>== Test mode: periodic user-mode task<br>== All results in microseconds<br>warming up...<br>RTT|&nbsp; 00:00:09&nbsp; (periodic user-mode task, 100 us period, priority 99)<br>RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp; -32.686| -352137.118| -230860.905|249855280|&nbsp;&nbsp;&nbsp;&nbsp; -32.686| -230860.905<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp; -36.039| -609219.441| -883326.616|481801356|&nbsp;&nbsp;&nbsp;&nbsp; -36.039| -883326.616<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp; -31.010| -259632.371| -151198.013|735561242|
&nbsp;&nbsp;&nbsp;&nbsp; -36.039| -883326.616<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp; -32.686| -578358.265| 1084683.558|968914361|&nbsp;&nbsp;&nbsp;&nbsp; -36.039| 1084683.558<br><br><br><br>It took a few attempts to Xenomai to build, in a way that the executables in /usr/xenomai/bin/ would execute without complaining: 
<br><br>(required=&quot;sep tsc&quot;, present=&quot;sep&quot;, missing=&quot;tsc&quot;).&nbsp; <br><br>The arguments that ended up making it work were:<br><br>./configure --enable-x86-sep --disable-x86-tsc<br><br><br>Any thoughts or suggestions as to whats going on?&nbsp; This machine has considerably more &#39;horsepower&#39; than the Desktop machines I am also running Xenomai on.&nbsp; But, these latency times are *way* out there.
<br><br>-Rob<br><br><br><br><br><br>

------=_Part_5983_29654020.1196069564443--

