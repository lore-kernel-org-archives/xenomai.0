Message-ID: <4B42113B.7060304@domain.hid>
Date: Mon, 04 Jan 2010 17:03:07 +0100
From: "Alessio Margan @ IIT" <alessio.margan@domain.hid>
MIME-Version: 1.0
References: <729c4a400912260654vf4f99d1ta6105bdace1b4098@domain.hid>		<4B3917BF.5070600@domain.hid>	<729c4a400912281740g17ccf7bcn5d2fd7f63e08c2bd@domain.hid>	<4B39BE8D.8060503@domain.hid>	<4B3B6957.4090901@domain.hid>
	<4B3F3C00.4000507@domain.hid>
In-Reply-To: <4B3F3C00.4000507@domain.hid>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [PATCH] Sensoray 526 analogy driver
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

Hi,

> The irq parameter is not used. It's not used in comedi either.
> For the io_port, the command analogy_config analogy0 analogy_s526 0xdc0=20
> works for me...
>
>  =20
not for me ... driver arg 0xdc0 when red by sscanf(opts, "%u",
&res[(*nb) - 1]) in analogy_config.c in function compute_opts is set to
0 due to %u
if I use the decimal value of ioport it works ... analogy_config
analogy0 analogy_s526 3520
> Did you try to acquire data?
>  =20
I try with insn_read command find in src/utils/analogy but seems that
subdevice should have commands enabled subd->flags |=3D A4L_SUBD_CMD;

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
soli destinatari. Qualora veniate in possesso di tali informazioni senza
essere definito come destinatario vi reghiamo di leggere le seguenti
note. Ogni apertura, copia, distribuzione del contenuto del messaggio e
dei suoi allegati =E8 proibito e potrebbe violare le presenti leggi.
Abbiamo attivato ogni possibile e ragionevole precauzione per assicurare
che gli allegati non contengano virus. Comunque non assumeremo alcuna
responsabilit=E0 per ogni eventuale danno causato da virus software e
simili in quanto =E8 onere del destinatario verificarne l=92assenza in ogni
allegato attuando propri indipendenti controlli.



