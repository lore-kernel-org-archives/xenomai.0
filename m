From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Tue, 4 Nov 2008 00:57:47 +0100
References: <9c789a000811031222oab34c08n32d94f83288154f3@domain.hid>
In-Reply-To: <9c789a000811031222oab34c08n32d94f83288154f3@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200811040057.47372.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-help] SegFault on Comedi-rtdm for Xenomai!!
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

> I have some questions regarding the use of Comedi over Xenomai .So I have
> developed a distributed control application using Comedi over RTAI on x86
> and now I have to port it to Xenomai on PPC ARCH and NI PCI 6024E DAQ card.
> My question is regarding my current status, so I have a linux kernel-2.6-24
> with Xenomai on my PPC board and I've just compiled Comedi for it and
> loaded succesfully comedi.ko, ni_mite.ko and ni_pcimio.ko. 

Where did you get the modules ni_mite.ko ni_pcimio.ko ? Did you perform the 
porting or did you use the version I made (as POC) ? If you use mine, take 
great care: as I have no NI acquisition card, I was unable to validate the 
drivers (that is the reason why the driver is not in the trunk). I just 
ported them so as to find some flaws in the reworked Comedi kernel API.

> But when I try 
> to run a sample app like the simple cmd_read I get Segementation Fault!
> Where could be the the error?

Could send more data on that point ? Did you get an OOPS in the kernel 
traces ?

Alexis.


