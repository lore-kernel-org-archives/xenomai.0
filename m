Message-ID: <9212697.1166778373331.JavaMail.ngmail@domain.hid>
Date: Fri, 22 Dec 2006 10:06:13 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <458ACFDA.8070300@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <458ACFDA.8070300@domain.hid>
	<b647ffbd0612210509r7494454fqc820f83a4b1f8719@domain.hid>	
	<2890274.1166696466862.JavaMail.ngmail@domain.hid>	
	<16382545.1166699974895.JavaMail.ngmail@domain.hid>	
	<1166700491.4936.5.camel@domain.hid>	
	<25528819.1166701882755.JavaMail.ngmail@domain.hid>	
	<13574091.1166708188484.JavaMail.ngmail@domain.hid>	
	<1166710393.4960.13.camel@domain.hid>	
	<12420573.1166713240349.JavaMail.ngmail@domain.hid>	
	<b647ffbd0612210717u4b8f0505m65d01bc2824a144a@domain.hid>	
	<8403506.1166715370788.JavaMail.ngmail@domain.hid>
	<b647ffbd0612210743m2b208cb2w6e9054336fd68028@domain.hid>
Subject: [Xenomai-help] Re: Re: A fairly small rtnet/Xenomai...
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org, dmitry.adamushko@domain.hid
Cc: xenomai@xenomai.org

Good morning everybody,

here are some more news concerning the Xenomai crash issue.=20
1) I have tried to enable the CONFIG_DEBUG_SPINLOCK and CONFIG_DEBUG_SPINLO=
CK_SLEEP
kernel config parameters. But I did not get any messages before the kernel =
freezes.

2) I have tried to link a static application (using -lstatic). When I pass
the -L/usr/lib/nptl  option to force the linker to use the nptl libs, the e=
ffect is the same.
Well, I have now a static binary that freezes the system.
I can mails you the binary file (about 280kByte bz2 file) if you like.
I think this file is too large to be posted to the list.

One additional question comes in my mind:
As I learned from all that things that are related to the issue, it seems t=
o be fairly
critical to fork out of a real time task or to create new processes out of =
it.
My question is now:
Is it possible to force a real time task back to standard linux task behavi=
our,
in this state the critical calls can be made. After it a move back to the o=
rigin
real time state would be nice. In the native skin there is the rt_task_shad=
ow()
call that allows to move a standard linux task to a real time task.
For moving a real time task to a standard task (and back) something like
rt_task_movetostandard(&state) that saves the real time state in a variable
and a rt_task_movebacktorealtime(&state) would be helpful.

>From the user point all that would be something like a critical region,=20
I enter a region where I can do really everything and then I move back
to the real time domain.

Regards

Mathias


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

