Message-ID: <20101222120352.14638lyeejpadxy8@domain.hid>
Date: Wed, 22 Dec 2010 12:03:52 +0100
From: Michel He <michel.he@domain.hid>
References: <20101216130423.19383g369jps4nk0@domain.hid>
	<4D0A0615.5080304@domain.hid>
In-Reply-To: <4D0A0615.5080304@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Gumstix / RTNET / INT Problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, "rtnet-users@domain.hid" <rtnet-users@domain.hid>

Hello Gilles

     Thank you for your help and quick answer. Currently I have =20
another problem in RTNet, it occured during the TDMA initialization :

This is the DMESG log:
...
<4>[   79.155764] initializing loopback...
<4>[   79.161636] RTnet: registered rtlo
<4>[   79.268076] RTcfg: init real-time configuration distribution protocol
<4>[   79.355733] RTmac: init realtime media access control
<4>[   79.428991] RTmac/TDMA: init time division multiple access =20
control mechanism
<6>[   80.465015] Xenomai: suspending kernel thread bf0087b0 =20
('rtnet-stack') at 0xbf05266c after exception #8

I'd like to know what is the exception #8 ? what could be the cause ?

Thank you very much again


Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> a =C3=A9crit=C2=A0:

> Michel He wrote:
>> Hello All,
>>
>>      I'm currently developing a RTNet RTDM driver for the chip SMSC
>> Lan9221 in Gumstix expansion board. I'm using the patch from
>> blog.gmane.org/gmane.linux.real-time...overo-sakoman.diff for Linux
>> 2.6.33.
>
> What version of Xenomai? What version of the I-pipe patch? why do you
> need an additional patch, why not using mainline + I-pipe?
>
> Also, you do not give us a full URL to the patch you are talking about,
> so we can not download it?
>
> --
>                                                                 Gilles.
>



