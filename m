Message-ID: <20101222161628.168821tlu4jc9wss@domain.hid>
Date: Wed, 22 Dec 2010 16:16:28 +0100
From: Michel He <michel.he@domain.hid>
References: <20101216130423.19383g369jps4nk0@domain.hid>
	<4D0A0615.5080304@domain.hid>
	<20101222120352.14638lyeejpadxy8@domain.hid>
In-Reply-To: <20101222120352.14638lyeejpadxy8@domain.hid>
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
To: Michel He <michel.he@domain.hid>
Cc: xenomai@xenomai.org, "rtnet-users@domain.hid" <rtnet-users@domain.hid>

So here, I add some debug info:

<6>[  172.419753] Xenomai: suspending kernel thread bf062500 =20
('rtnet-stack') at 0xbf0ac72c after exception #8

bf062500 u STACK_manager        [rt_loopback]

Now, let's find 0xbf0ac72c
00000000 a tdma_proto.c [tdma]
bf0abd7c t $a   [tdma]
bf0abdf4 t $d   [tdma]
bf0abdf8 t $a   [tdma]
bf0abee0 t $d   [tdma]
bf0abee4 t $a   [tdma]
bf0abfcc t $d   [tdma]
bf0abfd4 t $a   [tdma]
bf0ac1fc t $d   [tdma]
bf0ac208 t $a   [tdma]
bf0acb28 t $d   [tdma]
bf0acb40 t $a   [tdma]
bf0acd70 t $d   [tdma]

bf0ac72c - bf0abd7c =3D 9b0


0000048c <tdma_packet_rx>:
...
      9b0:=09e186200c =09orr=09r2, r6, ip

However I have no idea how to correspond the 9b0 to which line of =20
codes from tdma_proto.c ?? Any idea ?


Thank you


Michel He <michel.he@domain.hid> a =C3=A9crit=C2=A0:

> Hello Gilles
>
>     Thank you for your help and quick answer. Currently I have =20
> another problem in RTNet, it occured during the TDMA initialization :
>
> This is the DMESG log:
> ...
> <4>[   79.155764] initializing loopback...
> <4>[   79.161636] RTnet: registered rtlo
> <4>[   79.268076] RTcfg: init real-time configuration distribution protoco=
l
> <4>[   79.355733] RTmac: init realtime media access control
> <4>[   79.428991] RTmac/TDMA: init time division multiple access =20
> control mechanism
> <6>[   80.465015] Xenomai: suspending kernel thread bf0087b0 =20
> ('rtnet-stack') at 0xbf05266c after exception #8
>
> I'd like to know what is the exception #8 ? what could be the cause ?
>
> Thank you very much again
>
>
> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> a =C3=A9crit=C2=A0=
:
>
>> Michel He wrote:
>>> Hello All,
>>>
>>>     I'm currently developing a RTNet RTDM driver for the chip SMSC
>>> Lan9221 in Gumstix expansion board. I'm using the patch from
>>> blog.gmane.org/gmane.linux.real-time...overo-sakoman.diff for Linux
>>> 2.6.33.
>>
>> What version of Xenomai? What version of the I-pipe patch? why do you
>> need an additional patch, why not using mainline + I-pipe?
>>
>> Also, you do not give us a full URL to the patch you are talking about,
>> so we can not download it?
>>
>> --
>>                                                                Gilles.
>>
>
>



