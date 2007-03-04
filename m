Message-ID: <45EB4BFD.1090902@domain.hid>
Date: Sun, 04 Mar 2007 23:45:17 +0100
From: Markus Franke <Markus.Franke@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] irqbench && irqloop
Reply-To: Markus.Franke@domain.hid
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

Dear Xenomai Developers/Users,

the results of the measurements with irqbench/irqloop show time
differences of around 1 us between the different latencies observed. I
have chosen an interrupt frequency of 1 ms. An example of my results is
located at:

http://www-user.tu-chemnitz.de/~franm/Xenomai_IRQ_Handler.png.

Where do the discrete distances between the results come from? It looks
as if it is always around 1 us. Why aren't the results distributed
continuously? By the way, my bucket_size wasn't 1 us, rather it was 1
ns, so actually without any buckets.

Regards,
Markus Franke

