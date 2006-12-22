Message-ID: <9386881.1166783234553.JavaMail.ngmail@domain.hid>
Date: Fri, 22 Dec 2006 11:27:14 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <458BB057.9090009@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <458BB057.9090009@domain.hid> <458ACFDA.8070300@domain.hid>	
	<25528819.1166701882755.JavaMail.ngmail@domain.hid>	
	<13574091.1166708188484.JavaMail.ngmail@domain.hid>	
	<1166710393.4960.13.camel@domain.hid>	
	<12420573.1166713240349.JavaMail.ngmail@domain.hid>	
	<b647ffbd0612210717u4b8f0505m65d01bc2824a144a@domain.hid>	
	<8403506.1166715370788.JavaMail.ngmail@domain.hid>	
	<b647ffbd0612210743m2b208cb2w6e9054336fd68028@domain.hid>	
	<9212697.1166778373331.JavaMail.ngmail@domain.hid>	
	<458BA432.2000205@domain.hid>
	<b647ffbd0612220140m504db8e4x52ca45477e425d44@domain.hid>
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

Hi Gilles,

> fault_vm is safe to use only if you are calling fork at a time when
> there is only one thread. So, if your application is forking at init, it
> should be OK.
Do you mean there must be only one real time thread?=20
That means, when I have an application that creates multiple real time thre=
ads,
I can not rely on fault_vm() ?
In this case I have to do the "hard" way by using a different (non real tim=
e)
context to do the forks and system() calls.
As this is hard to understand, I strongly recommend that there is Xenomai s=
upport
for this! I.e. a Xenomai API that can be called with a (callback-)function =
pointer and
a user data pointer.=20
When a (realtime) thread calls this function, the real time thread is block=
ed.=20
The callback function is then called from a safe context and
after exit of the callback function the real time thread is resumed.

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

