Subject: Re: RTDM read/write callback with parameters
References: <ab28815f-96f0-606f-bb0d-c812678ef97b@aim-online.com>
 <ec089a4c-25df-2d75-c996-1b96a200398b@siemens.com>
From: Martin Haag <haag@aim-online.com>
Message-ID: <bae46ee6-4cc3-bf74-5eae-4e09eb87ba1e@aim-online.com>
Date: Wed, 23 Sep 2020 10:00:54 +0200
In-Reply-To: <ec089a4c-25df-2d75-c996-1b96a200398b@siemens.com>
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org


Am 22=2E09=2E2020 um 17=3A18 schrieb Jan Kiszka=3A
=3E On 21=2E09=2E20 15=3A49=2C Martin Haag via Xenomai wrote=3A
=3E=3E Dear list members=2C
=3E=3E
=3E=3E I am porting a Linux PCI character device driver to Xenomai 2=2E6=2E=
5=2E
=3E=3E
=3E=3E I can not find a RTDM expression for the =22parameters=22 argument o=
f the
=3E=3E struct file=5Foperations read callback=2E
=3E=3E
=3E=3E struct file=5Foperations=3A
=3E=3E ssize=5Ft aim=5Fread=28struct file* file=2C char =5F=5Fuser *paramet=
ers=2C size=5Ft
=3E=3E parameterSize=2C loff=5Ft* offset=29=3B
=3E=3E
=3E=3E struct rtdm=5Foperations=3A
=3E=3E ssize=5Ft aim=5Frtdm=5Fread=28struct rtdm=5Fdev=5Fcontext *context=
=2C rtdm=5Fuser=5Finfo=5Ft
=3E=3E *user=5Finfo=2C void *buf=2C size=5Ft nbyte=29
=3E=3E
=3E
=3E buf would map to parameter in the kernel interface=2C and there is no=
=20
=3E equivalent of offset=2E
=3E
=3E HTH=2C
=3E Jan
=3E
Thanks for the confirmation=2E This is what I found out when I tried to=20=

use =22buf=22 as input yesterday=2E I guess what confused me was the =22buf=
=22=20
parameter being documented as =22=5Bout=5D=22 for the read callback=2E


=3E typedef ssize=5Ft=28* rtdm=5Fread=5Fhandler=5Ft=29=28struct rtdm=5Fdev=
=5Fcontext=20
=3E *context=2C rtdm=5Fuser=5Finfo=5Ft *user=5Finfo=2C void *buf=2C size=5F=
t nbyte=29
=3E Read handler=2E
=3E
=3E Parameters
=3E =5Bin=5D=C2=A0=C2=A0 =C2=A0context=C2=A0=C2=A0 =C2=A0Context structure=
 associated with opened device=20
=3E instance
=3E =5Bin=5D=C2=A0=C2=A0 =C2=A0user=5Finfo=C2=A0=C2=A0 =C2=A0Opaque pointer=
 to information about user mode=20
=3E caller=2C NULL if kernel mode call
=3E =5Bout=5D=C2=A0=C2=A0 =C2=A0buf=C2=A0=C2=A0 =C2=A0Input buffer as passe=
d by the user
=3E =5Bin=5D=C2=A0=C2=A0 =C2=A0nbyte=C2=A0=C2=A0 =C2=A0Number of bytes the=
 user requests to read


Best Regards=2C
Martin




AIM - Gesellschaft f=C3=BCr angewandte Informatik und Mikroelektronik m=2Eb=
=2EH
Registered Office=3A Freiburg
District Court of Freiburg HRB 3520
Managing Directors=3A Hansj=C3=B6rg Frey=2C Joachim Schuler

This E-mail and any attachment=28s=29 to it are for the addressee=27s use o=
nly=2E
It is strictly confidential and may contain legally privileged information=
=2E=20
No confidentiality or privilege is waived or lost by any mistransmission=2E=

If you are not the intended addressee=2C then please delete it from your sy=
stem and notify the sender immediately=2E=20
You are hereby notified that any use=2C disclosure=2C copying or any action=
 taken in reliance on it is strictly prohibited and may be unlawful=2E
 - Thank you=2E


