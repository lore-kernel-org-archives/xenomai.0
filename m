Message-ID: <38995.155.253.35.60.1229699424.squirrel@domain.hid>
In-Reply-To: <200812170111.48941.berlemont.hauw@domain.hid>
References: <38108.155.253.35.73.1229336092.squirrel@domain.hid>
	<54299.155.253.35.73.1229341330.squirrel@domain.hid>
	<200812170111.48941.berlemont.hauw@domain.hid>
Date: Fri, 19 Dec 2008 16:10:24 +0100 (CET)
From: "Nicola Pedrocchi" <nicola.pedrocchi@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: xenomai@xenomai.org, Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: matteo.danesi@domain.hid, diego.parazzoli@domain.hid

Thak you very much Alexis,

 I have compiled the trunk as you say and everithing seems ok.

In order to test comedi I was used to associate a driver to a device with
the command
# comedi_config <devicefilenae> <driver>

When I try to execute this command the output is:
"Xenomai: incompatible ABI revision level (neede=3D1, current =3D 2)".
... is it correct?

What I have to do to test Comedi?
What are the step I have to do in order to test the NI board I have
available?
....I read the API documentation in
http://www.xenomai.org/documentation/trunk/html/api/index.html however I
am in lack of the correct logic to write a simple program to test my
experimental set-up.

Should you/someone help me posting a very simple "hello world" program to
test the basic functionalities of xenomai-comedi?

Thanks in advance!!!
Have a good weekend
best regards,
Nicola







> Hi,
>>
>> let me introduce, I am Nicola Pedrocchi, a researcher from the Institu=
te
>>
>> > of Industrial Technology and Automation of the National Research
>> Council
>> > of Italy.
>> > I have to develop a real-time acquisition from an anologic sensor
>> using a
>> > NI board and I wish to use Linux-Xenomai as RTOS and Comedi as drive=
r.
>> >
>> > However,  I have not very well understood the organization of the
>> project
>> > xenomai-comedi (sorry!! I am really new in using Linux-Xenomai :( )
>> >
>> > My doubts are:
>> > 1) What I need :) ???
>> > ...If I have understood correctly, I must use a stable version of
>> > Xenomai, download comedi-rdtm-dev from the xenomai repository and
>> compile
>> > it, is it correct? (I tried, but I have some problems in building
>> phase
>> > concerning undefined reference in the modules linkage...I will post
>> them
>> > in a next mail in the case it is the correct road) Or I have to
>> compile
>> > the xenomai-trunk where comedi files there are already? Or I have to
>> > compile the originary comedi files obtained from www.comedi.org?
>
> You have to compile the xenomai trunk for now.
>
>> > 2) looking for national instruments drivers, I found them in
>> > comedi-rtdm-dev, however I read the threads of the mailing list and =
in
>> my
>> > understanding, they are experimental and not tested yet, is it
>> correct?
>
> Yes. I have on my TODO list, the delivery of a beta version of the
> ni_pcimio
> driver into the xenomai trunk. This driver will match the features rang=
e
> provided by the legacy version (www.comedi.org).
>
> However, you should not use the comedi-rtdm-dev version, that was just =
a
> POC
> for the modified Comedi API.
>
> The trunk version will be available soon.
>
> Best regards.
>
> Alexis.
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>


-------------------------------------------------
Eng. Nicola Pedrocchi, PhD
-------------------------------------------------
phone : +39  02 23699978
mobile: +39 328  9159914
mail  : nicola.pedrocchi@domain.hid
mail  : nicola.pedrocchi@domain.hid
mail  : nicolapedrocchi@domain.hid
web   : http://robotics.ing.unibs.it
                      Thak you for correcting me!
-------------------------------------------------


