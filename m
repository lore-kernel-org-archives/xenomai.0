Message-ID: <903621.1170329457132.JavaMail.ngmail@domain.hid>
Date: Thu, 1 Feb 2007 12:30:57 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Re: Re:: [Xenomai-help] Running real time task on one of the cores
	of a Dual
In-Reply-To: <2284653.1170323957613.JavaMail.ngmail@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <2284653.1170323957613.JavaMail.ngmail@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, jan.kiszka@domain.hid

Hi Jan,

>> I also use rtnet. Unfortunately I am not able to force rtnet (RTDM based=
) to run on CPU core 1
>> without patching the RTDM code.
>> A couple of months ago, I already asked for this issue.
>> Jan, can you tell me the latest news regarding this issue?
>
>The global affinity mask is now part of Xenomai 2.3 (though I haven't
>tested it again after it was merged).=20

Ah, I didn't know that! How can I set the affinity mask?
Perhaps this is the problem I have...

>What part of RTnet precisely is
>resisting to move to CPU 1, or what do you currently have to patch?

Currently I see the rtnet tasks "rtnet-stack" and "rtnet-rtpc" to be assign=
ed to CPU 0.
I have patched xenomai/ksrc/skins/rtdm/drvlib.c in the call
to xnpod_start_thread(). I replace XNPOD_ALL_CPUS by cpumask_of_cpu(1).

Regards

Mathias

=20

--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

