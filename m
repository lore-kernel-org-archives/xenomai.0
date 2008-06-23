Message-ID: <485F5ABB.8080007@domain.hid>
Date: Mon, 23 Jun 2008 10:11:39 +0200
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <485E48A0.6050706@domain.hid>
	<200806230031.32512.berlemont.hauw@domain.hid>
In-Reply-To: <200806230031.32512.berlemont.hauw@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: xenomai@xenomai.org

Alexis Berlemont wrote:
> Hi,
> 
>> i need to buy an USB DAQ system and use it with Xenomai. I have an eye
>> on the National Instruments USB 6218 which is provided with linux drivers.
>> How can we now if an hardware will be usable with Xenomai ? 
>> Do we need 
>> the driver sources in order to be able to rewrite it for real time
>> purposes ?
> 
> A nice way would be to recover the Linux driver and make it work with Comedi 
> (which is a kind of framework for acquisition drivers, an RTDM port is 
> available).
> 
> Do you have the driver sources ? Just to see how it works...
> 
> To fully comply with real-time constraints, maybe usb20rt might be 
> necessary...
Another thing to keep in mind when using USB, is that USB microframes/frames are
only sent each 125 us/1 ms which gives a limit to how fast a control loop can
possibly be closed over USB (8kHz/1kHz, which is way below what can achieved
with USB if only data acquisition is needed).

Best regards

Anders Blomdell


-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

