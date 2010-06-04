Message-ID: <4C093C93.4000907@domain.hid>
Date: Fri, 04 Jun 2010 19:49:07 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] NI 6251 "wrong" samples
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Comedi@domain.hidControlandMeasurementDeviceInterface, comedi_list@domain.hid
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello.

I'm working with a NI PCI 6251 ADC board. I configured it to sample
channels 6 and 7, configured as differential analog inputs, at 50 kHz
with a conversion time of 2000 ns. I'm using a Xenomai kernel and the
Analogy drivers, a port of comedi drivers over the Xenomai real time
device driver abstraction layer.

The systems works well (I do not fully understand the properties fo the
noise spectrum of the sample data, see my other email to the mailing
list, but this is quite mynor) except that now and then I receive a
clearly "wrong" sample from the board.

I think I receive a wrong sample because I'm testing the system
acquiring a simple sine wave generated from a function generator, and
sometimes I obtain a sample that is clearly not where expected and I I
hardly believe that the discrepancy is due to physical noise.

I'm unable to identify a pattern of when those "wrong" samples appear in
my output, so I do not believe the issue is due to wrong FIFO
synchronization.

Has someone ever observed a similar behavior? Does someone has a
suggestion on how I can try to investigate it?

Thanks. Cheers,
-- 
Daniele

