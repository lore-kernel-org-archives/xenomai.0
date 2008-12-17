From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Wed, 17 Dec 2008 01:11:48 +0100
References: <38108.155.253.35.73.1229336092.squirrel@domain.hid>
	<54299.155.253.35.73.1229341330.squirrel@domain.hid>
In-Reply-To: <54299.155.253.35.73.1229341330.squirrel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200812170111.48941.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-help] Xenomai-Comedi: How to?
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
> let me introduce, I am Nicola Pedrocchi, a researcher from the Institute
>
> > of Industrial Technology and Automation of the National Research Council
> > of Italy.
> > I have to develop a real-time acquisition from an anologic sensor using a
> > NI board and I wish to use Linux-Xenomai as RTOS and Comedi as driver.
> >
> > However,  I have not very well understood the organization of the project
> > xenomai-comedi (sorry!! I am really new in using Linux-Xenomai :( )
> >
> > My doubts are:
> > 1) What I need :) ???
> > ...If I have understood correctly, I must use a stable version of
> > Xenomai, download comedi-rdtm-dev from the xenomai repository and compile
> > it, is it correct? (I tried, but I have some problems in building phase
> > concerning undefined reference in the modules linkage...I will post them
> > in a next mail in the case it is the correct road) Or I have to compile
> > the xenomai-trunk where comedi files there are already? Or I have to
> > compile the originary comedi files obtained from www.comedi.org?

You have to compile the xenomai trunk for now.

> > 2) looking for national instruments drivers, I found them in
> > comedi-rtdm-dev, however I read the threads of the mailing list and in my
> > understanding, they are experimental and not tested yet, is it correct?

Yes. I have on my TODO list, the delivery of a beta version of the ni_pcimio 
driver into the xenomai trunk. This driver will match the features range 
provided by the legacy version (www.comedi.org).

However, you should not use the comedi-rtdm-dev version, that was just a POC 
for the modified Comedi API.

The trunk version will be available soon. 

Best regards.

Alexis.


