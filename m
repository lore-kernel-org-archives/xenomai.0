Message-ID: <4B5473FE.7050704@domain.hid>
Date: Mon, 18 Jan 2010 15:45:18 +0100
From: "Alessio Margan @ IIT" <alessio.margan@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] thread and posix skin
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

Hi,

I've got problem using pthread_make_periodic_np and pthread_wait_np.
Should I make some particular initializations ?
CONFIG_XENO_OPT_TIMING_PERIOD=3Dy have sense ?
In the examples and testsuite I 've just seen the use of clock_nanosleep=20
with pthread,
should I use it instead of pthread_make_periodic_np ?

This is the thread routine, I get error on pthread_wait_np() return code=20
110.


void * rt_thread(void * arg, rt_thread_hook_t * hook)
{
thread_info_t * th_info =3D (thread_info_t *)arg;
int ret =3D 0;
struct timespec starttp, periodtp;
//
if ( hook ) { hook->init(0); }

printf("THREAD INIT: name =3D %s, period %ld us\n",
th_info->name, th_info->period.period.tv_usec);

ret =3D pthread_set_name_np(pthread_self(), th_info->name);
if ( ret !=3D 0 ) {
printf("%s : pthread_set_name_np() return code %d\n",
th_info->name, ret);
exit(1);
}

periodtp.tv_sec =3D 0ULL;
periodtp.tv_nsec =3D th_info->period.period.tv_usec * 1000ULL;
clock_gettime(CLOCK_REALTIME, &starttp);

starttp.tv_sec +=3D 1ULL;
starttp.tv_nsec +=3D periodtp.tv_nsec;

ret =3D pthread_make_periodic_np(pthread_self(), &starttp, &periodtp);
if ( ret !=3D 0 ) {
printf("%s : pthread_make_periodic_np() return code %d\n",
th_info->name, ret);
exit(1);
}

while (loop) {

if ( hook ) { hook->loop(0); }

// return 0 if the period expires as expected
ret =3D pthread_wait_np(NULL);
if ( ret !=3D 0 ) {
printf("%s : pthread_wait_np() return code %d\n", th_info->name, ret);
exit(1);
}

}

//
if ( hook ) { hook->shutdown(0); }

printf("THREAD %s ENDS\n", th_info->name);

return 0;
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


