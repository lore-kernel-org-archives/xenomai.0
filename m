Message-ID: <3d3b73870711050333y67cc2e1n98a5c96c3633c656@domain.hid>
Date: Mon, 5 Nov 2007 08:33:02 -0300
From: "Hugo Braga" <hugovaz@domain.hid>
Sender: hugobraga@domain.hid
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1187_32298303.1194262382222"
Subject: [Xenomai-help] xeno-test failed to start in-kernel timer benchmark,
	code -25
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

------=_Part_1187_32298303.1194262382222
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I ran xeno-test and I got the following failed message:

Seg Nov  5 10:30:38 BRT 2007
running: ./run -- -sh -T 120 -t1 # latency
*
*
* Type ^C to stop this application
*
*
== Sampling period: 100 us
== Test mode: in-kernel periodic task
== All results in microseconds
latency: failed to start in-kernel timer benchmark, code -25

I enabled the following options as module in the kernel's configuration
file:
Real-time sub-system->Drivers->Testing drivers:
*Timer benchmark driver
* IRQ benchmark driver
* Context switch unit testing driver

Also the system stopped when this message has been shown and I had to reboot
the machine.
My machine is:
Intel Core 2 Duo 2.00GHz
Intel Deskop Board D946GZIS
I built linux 2.6.19.7 linux kernel with xenomai 2.3.4 and
adeos-ipipe-2.6.19-i386-1.7-03.patch. I unchecked CPU frequency scaling,
unchecked ACPI->Processor and unchecked APM.
Please help me to solve the issue.

Thanks,
Hugo

ps: Sorry if I made some mistakes in the statements above because I am
learning English at this time.

------=_Part_1187_32298303.1194262382222
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I ran xeno-test and I got the following failed message:<br><br>Seg Nov&nbsp; 5 10:30:38 BRT 2007<br>running: ./run -- -sh -T 120 -t1 # latency<br>*<br>*<br>* Type ^C to stop this application<br>*<br>*<br>== Sampling period: 100 us
<br>== Test mode: in-kernel periodic task<br>== All results in microseconds<br>latency: failed to start in-kernel timer benchmark, code -25 <br><br>I enabled the following options as module in the kernel&#39;s configuration file:
<br>Real-time sub-system-&gt;Drivers-&gt;Testing drivers:<br>*Timer benchmark driver<br>* IRQ benchmark driver<br>* Context switch unit testing driver<br><br>Also the system stopped when this message has been shown and I had to reboot the machine.
<br>My machine is:<br>Intel Core 2 Duo 2.00GHz<br>Intel Deskop Board D946GZIS<br>I built linux <a href="http://2.6.19.7">2.6.19.7</a> linux kernel with xenomai 2.3.4 and adeos-ipipe-2.6.19-i386-1.7-03.patch. I unchecked CPU frequency scaling, unchecked ACPI-&gt;Processor and unchecked APM.
<br>Please help me to solve the issue.<br><br>Thanks,<br>Hugo<br><br>ps: Sorry if I made some mistakes in the statements above because I am learning English at this time.<br>

------=_Part_1187_32298303.1194262382222--

