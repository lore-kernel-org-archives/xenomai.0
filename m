Message-ID: <4C177276.7060005@domain.hid>
Date: Tue, 15 Jun 2010 14:30:46 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] How to avoid a tight real time loop
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

Hello. In my application I need to read data from an ADC card in blocks
of a given number of samples. For efficiency I'm using an mmapped buffer
to exchange data with the ADC driver. I'm setting up the acquisition,
and then calling a loop like this:

unsigned int required = <compute required number of bytes>;
unsigned int read = 0;
while (1) {
  while (read < required) {
    read = a4l_pool(...);
  }
  process(buffer, ...);
}

However if I run this loop in a real time thread the tight while loop is
an obvious cpu hog: the watchdog kicks in and kills the thread.

There is not an analogy API that can be used to require a certain amount
of data to the ADC driver. How can I code this loop to let other
processes to run?

Thanks. Cheers,
-- 
Daniele

