Message-ID: <472B242F.4020805@domain.hid>
Date: Fri, 02 Nov 2007 14:20:47 +0100
From: lastella raffaele <dunkelnacht@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Rtnet - rtt-sender
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

Hi, I'm an Italian student in Computer Science Engineering and I'm
working with Xenomai and Rtnet for a graduation thesis in Telematics. I
must use Rtnet in a wireless scenario with a Ralink RT2500 chipset. My
work aims to modify the driver in order to ensure that the transmission
of packets is successfully done after a certain amount of time using
real time tasks and disabling the transmission interrupts. I'm using the
rtt-sender provided with the RTnet suite and I've seen that, disabling
the transmission interrupts, the sender can't free the sockets and gives
the following message:  socket busy - waiting...
There's a way to free or close in any case the sockets ? I must modify
the sender or the driver program?
Thanks 

