Message-ID: <4B4B4D13.1050206@domain.hid>
Date: Mon, 11 Jan 2010 17:08:51 +0100
From: "Alessio Margan @ IIT" <alessio.margan@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] [PATCH] Sensoray 526 analogy driver
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

I try to configure sensoray counters to generate PWM signal

#define SUBD_CNT 0
#define SUBD_AI 1
#define SUBD_AO 2
#define SUBD_DIO 3

insn.type =3D A4L_INSN_CONFIG;
insn.idx_subd =3D SUBD_COUNTER;
insn.chan_desc =3D CHAN(channel);
insn.data_size =3D sizeof(dataC) / sizeof(dataC[0]);
insn.data =3D data;
data[0] =3D A4L_INSN_CONFIG_GPCT_PULSE_TRAIN_GENERATOR;
data[1] =3D cmReg.value;
data[2] =3D down_ticks;
data[3] =3D up_ticks;

ret =3D a4l_snd_insn(&dsc, &insn);

in a4l_do_insn the subdevice is check in this way but the test for=20
counter, and I think also for dio, fails due
to A4L_SUBD_MASK_SPECIAL bit

#define A4L_SUBD_UNUSED (A4L_SUBD_MASK_SPECIAL|0x1)
#define A4L_SUBD_COUNTER (A4L_SUBD_MASK_SPECIAL|0x40)
#define A4L_SUBD_DIO (A4L_SUBD_MASK_SPECIAL|0x20)

/* Checks the subdevice's characteristics */
if ((subd->flags & A4L_SUBD_UNUSED) !=3D 0) {
__a4l_err("a4l_do_insn: wrong subdevice selected 0x%X\n",subd->flags);
return -EINVAL;
}

there is something wrong or I miss something ?

TIA

Alessio


--=20

ISTITUTO ITALIANO
DI TECNOLOGIA

Alessio Margan
/Senior Technician/
mail me <mailto:alessio.margan@domain.hid>

Via Morego, 30 16163 Genova=20
<http://maps.google.com/maps?f=3Dq&hl=3Den&geocode=3D&q=3Dvia+morego,+30+ge=
nova&sll=3D37.0625,-95.677068&sspn=3D85.420533,191.601563&ie=3DUTF8&ll=3D44=
.474913,8.907037&spn=3D0.004685,0.011652&t=3Dh&z=3D17&iwloc=3Daddr>

www.iit.it <http://www.iit.it>

*Legal Disclaimer*
This electronic message contains information that is confidential. The=20
information is intended for the use of the addressee only. If you are=20
not the addressee we would appreciate your notification in this respect.=20
Please note that any disclosure, copy, distribution or use of the=20
contents of this message is prohibited and may be unlawful. We have=20
taken every reasonable precaution to ensure that any kind of attachment=20
to this e-mail has been swept for viruses. However, we cannot accept=20
liability for any damage sustained as a result of software viruses and=20
would advise you to carry out your own virus checks before opening any=20
attachment.
*Avvertenza legale*
Questo messaggio Email contiene informazioni confidenziali riservate ai=20
soli destinatari. Qualora veniate in possesso di tali informazioni senza=20
essere definito come destinatario vi reghiamo di leggere le seguenti=20
note. Ogni apertura, copia, distribuzione del contenuto del messaggio e=20
dei suoi allegati =E8 proibito e potrebbe violare le presenti leggi.=20
Abbiamo attivato ogni possibile e ragionevole precauzione per assicurare=20
che gli allegati non contengano virus. Comunque non assumeremo alcuna=20
responsabilit=E0 per ogni eventuale danno causato da virus software e=20
simili in quanto =E8 onere del destinatario verificarne l=92assenza in ogni=
=20
allegato attuando propri indipendenti controlli.


