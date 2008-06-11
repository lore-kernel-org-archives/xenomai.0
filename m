Message-ID: <14821321.1213179993177.JavaMail.ngmail@domain.hid>
Date: Wed, 11 Jun 2008 12:26:33 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Are xmm-registers saved with a (task) context switch
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

Hi!

I want to use the xmm0 register (from the SSE2 extension of a Core2Duo CPU)=
 to do atomic 64bit write/read accesses in
32 bit x86 mode.
My question is: Will the xmm[0..7] registers be saved with a task context s=
witch when running Xenomai real time tasks in user
space or do I have to take care to save them on the stack before using (and=
 restoring them afterwards).
Is it save to use these registers or will they be used by Xenomai (or Linux=
)  internally?

Thanks for any answer on that question.


Regards

Mathias


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Jetzt komfortabel bei Arcor-Digital TV einsteigen: Mehr Happy Ends, mehr He=
rzschmerz, mehr Fernsehen! Erleben Sie 50 digitale TV Programme und optiona=
l 60 Pay TV Sender, einen elektronischen Programmf=FChrer mit Movie Star Be=
wertungen von TV Movie. Au=DFerdem, aktuelle Filmhits und spannende Dokus i=
n der Arcor-Videothek. Infos unter www.arcor.de/tv

