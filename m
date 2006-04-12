Message-ID: <443D26B5.1080009@domain.hid>
Date: Wed, 12 Apr 2006 12:11:33 -0400
From: Randy Smith <rsmith@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Questions porting existing rtai-24.1.12 app to
	xenomai (PART II)
References: <1CFEB358338412458B21FAA0D78FE86D042A2FEE@rennsmail02.eu.thmulti.com>	<44328187.6080005@domain.hid>	<44327F66.10800@domain.hid>	<44329186.3080908@domain.hid>	<44329D27.1000400@domain.hid>	<4433DC01.6060104@domain.hid>
	<4433F441.2080309@domain.hid> <44342E91.4080007@domain.hid>
In-Reply-To: <44342E91.4080007@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: xenomai@xenomai.org



Randy Smith wrote:
>
>
> Philippe Gerum wrote:
>>
>> Ok, it's a bit early for Xmas gifts, but anyway, try this patch on=20
>> 2.4.25-11 as shipped with the ELDK 3.1:
>>
>> http://download.gna.org/adeos/patches/v2.4/ppc/adeos-ipipe-2.4.25-11-p=
pc-denx-1.0-04.patch=20
>>
>>
> I have downloaded the patch and will try it over the next few days and =

> report back.  Thanks again and Feliz Navidad or perhaps I should say=20
> Joyeux No=EBl?
>
> -Randy
>
Philippe,

Thanks for all your help.  I started from scratch and applied the patch=20
your pointed me to and yes it worked!  I must have had something wrong=20
in my build tree.
I can now build kernel modules and the user side builds and installs=20
correctly.

Thanks again!

-Randy



