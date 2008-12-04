From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Fri, 5 Dec 2008 00:57:00 +0100
References: <4934EB57.9080305@domain.hid>
	<200812040055.02455.berlemont.hauw@domain.hid>
	<4937A50F.6050502@domain.hid>
In-Reply-To: <4937A50F.6050502@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200812050057.00745.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-help] Calling comedi from a RT task
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

>
> At the moment I have not much time to look into the APIs, but we have
> some cards to test with: NI 6220, Adv 1751 and Adv 1720 (and maybe
> more). Of course I would test drivers for you, if there are any prototypes.
>
> What's the effort on porting? Is there much to do or do I have to
> programm a driver from scratch? How do I have to imagine the structure
> of the whole project?

The principles remain the same (subdevices, channels, ranges, commands, 
instructions, etc.). However, there are some differences in both APIs:
- the driver API has evolved a little bit (subdevice registration and 
asynchronous buffer access);
- the comedilib API has been reworked, the comedilib features range has been 
gathered into a smaller set of functions.

Consequently, integrating a driver from the original comedi framework into 
Xenomai's Comedi implies some slight modifications in the driver source. 
However, the whole module should not be rewritten.

And, converting your current program(s) into full RT application(s) is not a 
difficult task. You will have to update the Comedi functions calls.
Ex.: 
- comedi_data_read(), comedi_data_read_hint(), comedi_data_read_delayed() 
become comedi_sync_read()
- comedi_dio_read(), etc. => comedi_sync_read() too
- etc.

> Xenomai ------------> Comedi API    -> driver (e. g. ni_pcimio)
>
>         ---> RTDM --> Comedi RT API (part of Xenomai) -> RT driver


On kernel side: 
Xenomai nucleus <- RTDM skin <- comedi layer <- comedi driver

On user side: 
RTDM user skin (Xeno syscalls) <- Comedilib library <- your user process

> Is the Comedi API that is part of the Xenomai hierachy a Real Time
> substitute for the Comedi API of the original Comedi project? So porting
> is only a litte more than a simple recompile?

The comedi API available in Xenomai is not just a real-time substitute. The 
new comedi core fully relies on RTDM services; then, even an NRT task can use 
the new comedi framework.

> Is this correct? I would welcome any comments on this.
>

Alexis.


