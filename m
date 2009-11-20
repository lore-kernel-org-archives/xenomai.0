Message-ID: <4B06BEAD.2060107@domain.hid>
Date: Fri, 20 Nov 2009 17:07:09 +0100
From: "Alessio Margan @ IIT" <alessio.margan@domain.hid>
MIME-Version: 1.0
References: <4B058624.6000401@domain.hid>
	<200911201609.12842.smolorz@domain.hid>
In-Reply-To: <200911201609.12842.smolorz@domain.hid>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] problem with RT-Socket-CAN xeno_can_isa module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Sebastian Smolorz wrote:
> Alessio Margan @ IIT wrote:
>  =20
>> I've got a problem using RT-Socket-CAN with module xeno_can_isa.
>> The system has a pcan-pc/104 board with a sja1000
>> The first tme I load to module with
>> sudo modprobe xeno_can_isa io=3D0x300,0x320 irq=3D10,11
>> everything work fine, then if I try to unload the module seems that the
>> ioport region remain allocated from xeno_can_isa
>> but the module is unloaded and if I try to load it again the command
>> fail with "Device or resource busy" and I have to reboot.
>>    =20
>
> Does this patch work for you?
>
>  =20
Perfect !
Alessio

--=20

ISTITUTO ITALIANO
DI TECNOLOGIA

Alessio Margan
/Senior Technician/
mail me <mailto:alessio.margan@domain.hid>

Via Morego, 30 16163 Genova
<http://maps.google.com/maps?f=3Dq&hl=3Den&geocode=3D&q=3Dvia+morego,+30+ge=
nova&sll=3D37.0625,-95.677068&sspn=3D85.420533,191.601563&ie=3DUTF8&ll=3D44=
.474913,8.907037&spn=3D0.004685,0.011652&t=3Dh&z=3D17&iwloc=3Daddr>

www.iit.it <http://www.iit.it>

*Legal Disclaimer*
This electronic message contains information that is confidential. The
information is intended for the use of the addressee only. If you are
not the addressee we would appreciate your notification in this respect.
Please note that any disclosure, copy, distribution or use of the
contents of this message is prohibited and may be unlawful. We have
taken every reasonable precaution to ensure that any kind of attachment
to this e-mail has been swept for viruses. However, we cannot accept
liability for any damage sustained as a result of software viruses and
would advise you to carry out your own virus checks before opening any
attachment.
*Avvertenza legale*
Questo messaggio Email contiene informazioni confidenziali riservate ai
soli destinatari. Qualora  veniate in possesso di tali informazioni
senza essere definito come destinatario vi reghiamo di leggere le
seguenti note. Ogni apertura, copia, distribuzione del contenuto del
messaggio e dei suoi allegati =E8 proibito e potrebbe violare le presenti
leggi. Abbiamo attivato ogni possibile e ragionevole precauzione per
assicurare che gli allegati non contengano virus. Comunque non
assumeremo alcuna responsabilit=E0 per ogni eventuale danno causato da
virus software e simili in quanto =E8 onere del destinatario verificarne
l=92assenza in ogni allegato attuando propri indipendenti controlli.



