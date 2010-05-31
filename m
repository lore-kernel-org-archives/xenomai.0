Message-ID: <4C0395C1.6050902@domain.hid>
Date: Mon, 31 May 2010 12:56:01 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Analogy: unable to use sampling frequency higher
	that 10kHz
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

Hello. I finally went back to work to my data acquisition
infrastructure. I'm now trying to increase the sampling frequency of my
control loop. I do not have any problem up to 10 kHz, but when I
increase the sampling frequency above this limits the ADC driver stop
working fine. In the kernel log I obtain a huge list of

Analogy: analogy_ni_pcmio: ni_mio_common: interrupt: didn't clear
interrup? status=0x9030

>From where can I start to investigate this problem?

I encounter this problem only when I use analogy commands with the
TRIG_WAKE_EOS flag. If I do not specify this flag all works fine up to
100 kHz. However I need my data in real time, and therefore I need to
specify this flag.

Cheers,
-- 
Daniele

