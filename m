Message-ID: <44C71C43.60900@domain.hid>
Date: Wed, 26 Jul 2006 09:39:47 +0200
From: "Miguel Angel Alvarez" <ma.alvarez@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Newbie and Coldfire
References: <44C4E547.10304@domain.hid> <44C50309.70303@domain.hid>
In-Reply-To: <44C50309.70303@domain.hid>
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Class: urn:content-classes:message
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

Jan Kiszka escribi=F3:
> Miguel Angel Alvarez wrote:
>  =20
>> Hi.
>>
>> I do not know if this in the correct mailing list to do this =
question.
>> If not, please redirect me to the correct one.
>>
>> I am beginning a new proyect using a Coldifre micro (Have previous
>> experience with i386 and PPC). It is also my first proyect with real
>> time linux, so I have began to read articles about preemption =
patches,
>> RTAI...
>>
>> It seems that Xenomai is the best effort to obtain hard real-time
>> characteristics to my system, but... it is not ported to support
>> Coldfire. Could anyone give me an advise on the difficulty of porting
>> the systen to this architecture? Should I consider it just =
impossible?
>>
>>    =20
>
> Disclaimer: No expert on Coldfire speaking here. But given that =
Xenomai
> already runs fine over Blackfin (also a MMU-less arch) and that it has =
a
> clean architecture abstraction: should definitely be feasible.
>
> The first step always involves an Adeos I-pipe patch. Check available
> patches for other archs to assess the required effort for you. Feel =
free
> to drop questions on their design or your Coldfire ideas on
> xenomai-core/help or on adeos-main (similar people will listen).
>
> Jan
>
>
>  =20
Well. In fact I did a mistake in my previous messages. I am dealing with =

a V4Core Coldfire, so I have MMU. However your comments have been useful =

Jan. Thanks.

Miguel =C1ngel=20
=20
----------------------------------------- PLEASE NOTE =
-------------------------------------------
This message, along with any attachments, may be confidential or legally =
privileged.=20
It is intended only for the named person(s), who is/are the only =
authorized recipients.
If this message has reached you in error, kindly destroy it without =
review and notify the sender immediately.
Thank you for your help.
=B5SysCom uses virus scanning software but excludes any liability for =
viruses contained in any attachment.
=20
------------------------------------ ROGAMOS LEA ESTE TEXTO =
-------------------------------
Este mensaje y sus anexos pueden contener informaci=F3n confidencial y/o =
con derecho legal.=20
Est=E1 dirigido =FAnicamente a la/s persona/s o entidad/es rese=F1adas =
como =FAnico destinatario autorizado.
Si este mensaje le hubiera llegado por error, por favor elim=EDnelo sin =
revisarlo ni reenviarlo y notif=EDquelo inmediatamente al remitente. =
Gracias por su colaboraci=F3n. =20
=B5SysCom utiliza software antivirus, pero no se hace responsable de los =
virus contenidos en los ficheros anexos.

