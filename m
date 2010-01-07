Message-ID: <4B4632D1.3020709@domain.hid>
Date: Thu, 07 Jan 2010 20:15:29 +0100
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

I've got a doubt about s526 driver on reading analog input.

I read analog data in this way

sampl_t data;
a4l_insn_t insn_tab =3D {
.type =3D A4L_INSN_READ,
.idx_subd =3D idx_subd,
.chan_desc =3D CHAN(idx_chan),
.data_size =3D sizeof(data),
.data =3D &data};

/* Sends the read instruction to the Analogy layer */
ret =3D a4l_snd_insn(&dsc, &insn_tab);

on driver side data_size is the number of samples not the nr of byte to=20
read,
the driver expect data_size to be the number of samples and data to be a=20
vector of samples

uint16_t *data =3D (uint16_t *)insn->data;

/* convert n samples */
for (n =3D 0; n < insn->data_size; n++) {
/* trigger conversion */
outw(value, ADDR_REG(REG_ADC));
a4l_info(dev, "s526_ai_rinsn: Wrote 0x%04x to ADC\n", value);
a4l_info(dev, "s526_ai_rinsn: ADC reg=3D0x%04x\n", inw(ADDR_REG(REG_ADC)));

#define TIMEOUT 100

/* wait for conversion to end */
for (i =3D 0; i < TIMEOUT; i++) {
status =3D inw(ADDR_REG(REG_ISR));
if (status & ISR_ADC_DONE) {
outw(ISR_ADC_DONE, ADDR_REG(REG_ISR));
break;
}
}
if (i =3D=3D TIMEOUT) {
a4l_warn(dev, "s526_ai_rinsn: ADC(0x%04x) timeout\n",=20
inw(ADDR_REG(REG_ISR)));
return -ETIMEDOUT;
}

/* read data */
d =3D inw(ADDR_REG(REG_ADD));
a4l_info(dev, "s526_ai_rinsn: AI[%d]=3D0x%04x\n", n, (unsigned short)(d &=20
0xFFFF));

/* munge data */
data[n] =3D d ^ 0x8000;
}

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


