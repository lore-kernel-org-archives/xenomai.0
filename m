Message-ID: <18504269.1212502025901.JavaMail.ngmail@domain.hid>
Date: Tue, 3 Jun 2008 16:07:05 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] TSCs synchron on multi-core CPUs?
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

Hi everybody,

I have a question concerning the time stamp counters of the Intel core2duo/=
quad CPUs.
They will be used e.g. with the Xenomai native skin call rt_time_tsc which =
ends up in
an assembler statement "rdtsc".
My question is now:
Are the values of TSC synchron with dual/quad core CPUs? Or is there a poss=
ible drift between
the CPUs?
Background of the question is:
I want to measure the time of a event that occurs within one task.
A second event is checked in another task on a different core. The time dif=
ference between the
events has to be checked.
Can this be done precisely with rdtsc() or is a mechanism required that use=
s the TSC of exactly one=20
core?

Thanks for all hints on that question!

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

