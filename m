MIME-Version: 1.0
Date: Tue, 1 Jun 2010 09:44:52 -0700
Message-ID: <AANLkTilOsBQXASMpEHjKs0JwOy8c2EaLG26Vej8sueZC@mail.gmail.com>
From: Ettore Pedretti <epedrett@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] National Instruments PCI-6711
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
Cc: John Monnier <monnier@domain.hid>

Dear All,

Thanks for all the help getting the PCI-6711 running under xenomai. I
have a question about the functionalities implemented by the analogy
driver,

With the NI linux driver we can programme  some waveforms in and let
them run without further intervention. We do not need to change the
waveforms in real time. Is it possible to do this with the analogy
driver?

I guess you should use analogy commands and an asynchronous
acquisition command. All the examples I have seen on comedi/analogy
put the acquisition in a while loop. It seems as if you need to fill
the buffer each time.

What is the closest functionality I can get to programming the card
and letting it run without further intervention?

All the best
Ettore

