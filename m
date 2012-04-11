Message-ID: <4F854F3D.9020007@domain.hid>
Date: Wed, 11 Apr 2012 11:30:37 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4F85479F.1060305@domain.hid> <4F854B8E.7050803@domain.hid>
	<4F854D1E.7010200@domain.hid>
In-Reply-To: <4F854D1E.7010200@domain.hid>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] kernel panic unload xeno_nucleus module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Alessio Margan @ IIT" <alessio.margan@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/11/2012 11:21 AM, Alessio Margan @ IIT wrote:
> On 04/11/2012 11:14 AM, Philippe Gerum wrote:
>> On 04/11/2012 10:58 AM, Alessio Margan @ IIT wrote:
>>> Hi all,
>>>
>>> when I try to unload xeno_nucleus module I get a kernel panic and on the
>>> next power on the bios system date is reset.
>>> when configure xenomai nucleus built into the kernel I can reboot corre=
ctly.
>>>
>> Kernel panic log would help.
>>
> I'll try to get it
>>> In the bios I disabled HPET and most of the things regarding PM and ACP=
I.
>>>
>>> Here attached same info about system and kernel config.
>>>
>>> If possible, I prefer have xenomai configured as modules, is there
>>> anything wrong about my system configuration ?
>>>
>> This should not be a configuration issue. Either some kernel-based
>> Xenomai threads (e.g. RTDM driver thread) are still running when
>> attempting to unload the nucleus, or a real-time IRQ is still hooked to
>> a handler being unmapped, or there is a nucleus bug.
>>
> after boot the only thing I do is load nucleus and unload it, no other
> xenomai modules are loaded

Btw, you should try with the latest Xenomai code from the 2.6.x=20
maintenance branch, to make sure this has not been fixed already.

git://git.xenomai.org/xenomai-2.6.git

>>
> Thanks
> Alessio
>
> --
>
> ISTITUTO ITALIANO
> DI TECNOLOGIA
>
> Alessio Margan
> /Senior Technician/
> mail me <mailto:alessio.margan@domain.hid>
>
> Via Morego, 30 16163 Genova
> <http://maps.google.com/maps?f=3Dq&hl=3Den&geocode=3D&q=3Dvia+morego,+30+=
genova&sll=3D37.0625,-95.677068&sspn=3D85.420533,191.601563&ie=3DUTF8&ll=3D=
44.474913,8.907037&spn=3D0.004685,0.011652&t=3Dh&z=3D17&iwloc=3Daddr>
>
> www.iit.it <http://www.iit.it>
>
> *Legal Disclaimer*
> This electronic message contains information that is confidential. The
> information is intended for the use of the addressee only. If you are
> not the addressee we would appreciate your notification in this respect.
> Please note that any disclosure, copy, distribution or use of the
> contents of this message is prohibited and may be unlawful. We have
> taken every reasonable precaution to ensure that any kind of attachment
> to this e-mail has been swept for viruses. However, we cannot accept
> liability for any damage sustained as a result of software viruses and
> would advise you to carry out your own virus checks before opening any
> attachment.
> *Avvertenza legale*
> Questo messaggio Email contiene informazioni confidenziali riservate ai
> soli destinatari. Qualora  veniate in possesso di tali informazioni
> senza essere definito come destinatario vi reghiamo di leggere le
> seguenti note. Ogni apertura, copia, distribuzione del contenuto del
> messaggio e dei suoi allegati =E8 proibito e potrebbe violare le presenti
> leggi. Abbiamo attivato ogni possibile e ragionevole precauzione per
> assicurare che gli allegati non contengano virus. Comunque non
> assumeremo alcuna responsabilit=E0 per ogni eventuale danno causato da
> virus software e simili in quanto =E8 onere del destinatario verificarne
> l=92assenza in ogni allegato attuando propri indipendenti controlli.
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--=20
Philippe.

