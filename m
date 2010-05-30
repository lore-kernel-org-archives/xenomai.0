MIME-Version: 1.0
Date: Sun, 30 May 2010 09:14:46 -0700
Message-ID: <AANLkTimHOPpI3mst8-fM4Atf6V_-kurbqD-RKZdWDbUY@mail.gmail.com>
From: Ettore Pedretti <epedrett@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] How to generate a waveform / digital output (Alexis)
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

Hi,

I finally managed to return to the site where we have the National
Instruments PCI-6711 board. The old problem with analogy_ni_pcimio
seem solved. I can attach the driver and cmd_write seems to work.

I have been trying unsuccessfully to modify cmd_write to generate a
waveform. What I would like to do is to generate a sawtooth waveform
and send a digital pulse (trigger for an infrared camera) at the end
of the waveform. That should be running continuously until stopped.

I tried to modify your example "cmd_write" and the comedi programme
called "ao_waveform.c ". Many commands seem not to be implemented on
the analogy side. I tried to use the documentation on the comedi site
and the API description on the xenomai/analogy side but I got  even
more confused. It does not seem like a simple matter of exchanging
comedi_  for a4l_ as you indicated in one thread.

Do you have any example similar to ao_waveform.c I could try to modify
for my application? That would be a start. I have been unsuccessfully
searching the threads for something vaguely similar.

All the best
Ettore


-- 
Ettore Pedretti, SUPA
School of Physics and Astronomy
University of St Andrews, North Haugh,
St Andrews, Fife, KY16 9SS, Scotland
Ph: +44-1334-461666, Fax: +44-1334-463104
The University of St Andrews is a charity registered in Scotland : No SC013532

