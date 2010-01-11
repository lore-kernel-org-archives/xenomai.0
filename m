MIME-Version: 1.0
Sender: alexis.berlemont@domain.hid
In-Reply-To: <4B4B4D13.1050206@domain.hid>
References: <4B4B4D13.1050206@domain.hid>
Date: Mon, 11 Jan 2010 17:22:45 +0100
Message-ID: <72cf3fb1001110822q3b29b915j7fa5dac9571aea44@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Content-Type: text/plain; charset=windows-1252
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
To: "Alessio Margan @ IIT" <alessio.margan@domain.hid>
Cc: Xenomai-core@domain.hid

Hi,

On Mon, Jan 11, 2010 at 5:08 PM, Alessio Margan @ IIT
<alessio.margan@domain.hid> wrote:
> Hi,
>
> I try to configure sensoray counters to generate PWM signal
>
> #define SUBD_CNT 0
> #define SUBD_AI 1
> #define SUBD_AO 2
> #define SUBD_DIO 3
>
> insn.type =3D A4L_INSN_CONFIG;
> insn.idx_subd =3D SUBD_COUNTER;
> insn.chan_desc =3D CHAN(channel);
> insn.data_size =3D sizeof(dataC) / sizeof(dataC[0]);
> insn.data =3D data;
> data[0] =3D A4L_INSN_CONFIG_GPCT_PULSE_TRAIN_GENERATOR;
> data[1] =3D cmReg.value;
> data[2] =3D down_ticks;
> data[3] =3D up_ticks;
>
> ret =3D a4l_snd_insn(&dsc, &insn);
>
> in a4l_do_insn the subdevice is check in this way but the test for
> counter, and I think also for dio, fails due
> to A4L_SUBD_MASK_SPECIAL bit
>
> #define A4L_SUBD_UNUSED (A4L_SUBD_MASK_SPECIAL|0x1)
> #define A4L_SUBD_COUNTER (A4L_SUBD_MASK_SPECIAL|0x40)
> #define A4L_SUBD_DIO (A4L_SUBD_MASK_SPECIAL|0x20)
>
> /* Checks the subdevice's characteristics */
> if ((subd->flags & A4L_SUBD_UNUSED) !=3D 0) {
> __a4l_err("a4l_do_insn: wrong subdevice selected 0x%X\n",subd->flags);
> return -EINVAL;
> }
>
> there is something wrong or I miss something ?
You miss nothing. There was a bug in the subdevice's flags checking line:
The problem is here: if ((subd->flags & A4L_SUBD_UNUSED) !=3D 0) {

I fixed it in my git repo one week ago.

Either you clone my git repot or you wait for the pull request I will
make tonight.

Regards,

>
> TIA
>
> Alessio
>
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
> soli destinatari. Qualora veniate in possesso di tali informazioni senza
> essere definito come destinatario vi reghiamo di leggere le seguenti
> note. Ogni apertura, copia, distribuzione del contenuto del messaggio e
> dei suoi allegati =E8 proibito e potrebbe violare le presenti leggi.
> Abbiamo attivato ogni possibile e ragionevole precauzione per assicurare
> che gli allegati non contengano virus. Comunque non assumeremo alcuna
> responsabilit=E0 per ogni eventuale danno causato da virus software e
> simili in quanto =E8 onere del destinatario verificarne l=92assenza in og=
ni
> allegato attuando propri indipendenti controlli.
>
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>
>
Alexis.

