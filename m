Message-ID: <485F7999.8040502@domain.hid>
Date: Mon, 23 Jun 2008 12:23:21 +0200
From: Antoine Nourry <nourry@domain.hid>
MIME-Version: 1.0
References: <485E48A0.6050706@domain.hid>
	<200806230031.32512.berlemont.hauw@domain.hid>
In-Reply-To: <200806230031.32512.berlemont.hauw@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Daq System Compatibility
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

Alexis Berlemont a =E9crit :
> Hi,
>
>  =20
>> i need to buy an USB DAQ system and use it with Xenomai. I have an eye
>> on the National Instruments USB 6218 which is provided with linux driv=
ers.
>> How can we know if an hardware will be usable with Xenomai ?=20
>> Do we need=20
>> the driver sources in order to be able to rewrite it for real time
>> purposes ?
>>    =20
>
> A nice way would be to recover the Linux driver and make it work with C=
omedi=20
> (which is a kind of framework for acquisition drivers, an RTDM port is=20
> available).
>
> Do you have the driver sources ? Just to see how it works...
>
> To fully comply with real-time constraints, maybe usb20rt might be=20
> necessary...
>
> Best regards.
>
> Alexis.
>
>
>
>  =20
First of all, thank you for your answer.

I would appreciate to make it this way. The problem is that i don't know
if NI give its sources (i'm downloading an ISO from their site...), and
i can't afford to buy a system i won't be able to use.
Generally speaking, what do we need to make a DAQ system work on a
real-time linux solution ?

Do we absolutely need the native driver sources or can we find the
necessary answers for making a new real-time driver in documentation and
hardware specifications ?

Anyway, it seems to be a harsh task to write a new driver according to
many comments.



