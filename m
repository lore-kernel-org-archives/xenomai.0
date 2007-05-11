Message-ID: <27223852.1178871002720.JavaMail.ngmail@domain.hid>
Date: Fri, 11 May 2007 10:10:02 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <46441EC7.4000603@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <46441EC7.4000603@domain.hid>
	<15183185.1178867312688.JavaMail.ngmail@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and futexes - Native API optimized
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org

Hi Jan,

> As an experiment, you could try implementing the cpuid lookup via
> raw_smp_processor_id(), given you use 2.6.20. Hmm, maybe/likely some
> Xenomai tuning is required as well to make sure that the PDA is set
> correctly when a Xenomai task is created/migrated. Results welcome!

I have applied a patch (below) to my SMP kernel 2.6.20.4.
And actually the results are now much better.
I have been back on my "original" kernel version without the oprofile suppo=
rt.
The "original" ipipe.c delivered times of 4.5 us per step with my test proj=
ect.
The patched ipipe.c (using raw_smp_processor_id()) delivers 1.25 us per ste=
p!
This is really an excellent improvement!
I do not know if there are any side effects - if not: why not using this me=
thod instead
of the previous one...

Regards

Mathias

------------------------- patch start ------------------
--- ipipe.c.orig        2007-05-09 16:16:32.000000000 +0200
+++ ipipe.c     2007-05-11 10:00:44.000000000 +0200
@@ -74,6 +74,7 @@

 static notrace int __ipipe_hard_cpuid(void)
 {
+#if 0
        unsigned long flags;
        int cpu;

@@ -81,6 +82,9 @@
        cpu =3D __ipipe_apicid_2_cpu[GET_APIC_ID(apic_read(APIC_ID))];
        local_irq_restore_hw_notrace(flags);
        return cpu;
+#endif
+        return raw_smp_processor_id();
+
 }

 #endif /* CONFIG_SMP */
------------------------- patch end ------------------


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

