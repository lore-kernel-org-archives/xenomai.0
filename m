From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Mon, 23 Jun 2008 00:31:32 +0200
References: <485E48A0.6050706@domain.hid>
In-Reply-To: <485E48A0.6050706@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200806230031.32512.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-help] DAQ SYSTEM COMPATIBILITY
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

> i need to buy an USB DAQ system and use it with Xenomai. I have an eye
> on the National Instruments USB 6218 which is provided with linux drivers.
> How can we now if an hardware will be usable with Xenomai ? 
> Do we need 
> the driver sources in order to be able to rewrite it for real time
> purposes ?

A nice way would be to recover the Linux driver and make it work with Comedi 
(which is a kind of framework for acquisition drivers, an RTDM port is 
available).

Do you have the driver sources ? Just to see how it works...

To fully comply with real-time constraints, maybe usb20rt might be 
necessary...

Best regards.

Alexis.


