Date: Thu, 3 Jun 2010 00:12:43 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20100602221243.GC2590@domain.hid>
References: <AANLkTilOsBQXASMpEHjKs0JwOy8c2EaLG26Vej8sueZC@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTilOsBQXASMpEHjKs0JwOy8c2EaLG26Vej8sueZC@mail.gmail.com>
Subject: Re: [Xenomai-help] National Instruments PCI-6711
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ettore Pedretti <epedrett@domain.hid>
Cc: xenomai@xenomai.org, John Monnier <monnier@domain.hid>

Hi,

Ettore Pedretti wrote:
> Dear All,
> 
> Thanks for all the help getting the PCI-6711 running under xenomai. I
> have a question about the functionalities implemented by the analogy
> driver,
> 
> With the NI linux driver we can programme  some waveforms in and let
> them run without further intervention. We do not need to change the
> waveforms in real time. Is it possible to do this with the analogy
> driver?

I remember having read in the DAQ STC manual that such a feature was
available for the digital output subdevice. So, it may not be
surprising that it is also available for the analog output device.

> 
> I guess you should use analogy commands and an asynchronous
> acquisition command. All the examples I have seen on comedi/analogy
> put the acquisition in a while loop. It seems as if you need to fill
> the buffer each time.

Precisely, even if the hardware is able to work like you expect, the
command API does not support it. The command structure
(inherited from Comedi) defines via the stop_src and stop_arg fields
the length of the asynchronous acquisition and all the data are to be
going through the application. 

On the other side, that is just the theory. I would not be surprised
to find a Comedi driver which proposes the behaviour you ask thanks to
a driver-specific hidden cheat flag somewhere in the structure.

> 
> What is the closest functionality I can get to programming the card
> and letting it run without further intervention?
> 

I have no answer so far. That would need an extension of the framework.

> All the best
> Ettore
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Alexis.

