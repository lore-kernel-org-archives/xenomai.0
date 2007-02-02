Message-ID: <26362385.1170425611905.JavaMail.ngmail@domain.hid>
Date: Fri, 2 Feb 2007 15:13:31 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Re: Re: Re: [Xenomai-help] Error: cat: /proc/xenomai/stat: Cannot
In-Reply-To: <22474211.1170411361268.JavaMail.ngmail@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <22474211.1170411361268.JavaMail.ngmail@domain.hid>
	<1170409755.4981.11.camel@domain.hid>
	<19981456.1170405795640.JavaMail.ngmail@domain.hid>
	<1170408789.4981.1.camel@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org

Hi all,

I have now identified the issue and provided a workaround.
I am using a kernel module as a hardware driver.
The kernel module was originally designed for standard linux and I modified=
 it only slightly to=20
have Xenomai support.
For configuring the driver, a /dev/xxx character file is provided.

When this file is opened (which lead to the module's open that is registere=
d via register_chrdev)
an interrupt routine is registered.
I do here a rt_intr_create() followed by a rt_intr_enable().
When the /dev/xxx file is closed, the module's release function is called.
This function calls rt_intr_disable() and rt_intr_delete() to stop using th=
e interrupt.

This looks very fine, however it seems to cause problems.
Having this situation, I get the kernel "cannot allocate memory" message.

I did a restructuring of the kernel module to disable the interrupt routine=
 and to
delete the interrupt object not with the release() function but within
cleanup_module(). And this works now perfect.

I do not understand the reason for this but now it is working.

Thanks for all the hints on that issue.

Regards


Mathias

----- Original Nachricht ----
Von:     "M. Koehrer" <mathias_koehrer@domain.hid>
An:      rpm@xenomai.org
Datum:   02.02.2007 11:16
Betreff: Re: Re: [Xenomai-help] Error: cat: /proc/xenomai/stat: Cannot
 allocate

> Hi!
>=20
> I have one kernel module for a special driver running.
> If I do not load this kernel module, everything seems to work fine.
> That means, this kernel module is probably causing the issue...
> I have to look closer to it...
> Sorry for any confusion!
>=20
> Regards
>=20
> Mathias=20
>=20
>=20
> > On Fri, 2007-02-02 at 10:33 +0100, Philippe Gerum wrote:
> > > On Fri, 2007-02-02 at 09:43 +0100, M. Koehrer wrote:
> > > > Hi everybody,
> > > >=20
> > > > I have a strange issue frequently when reading /proc/xenomai/stat.
> > > > I do a cat /proc/xenomai/stat and I get an "Cannot allocate memory"
> > error.
> > > > This happens typcially after I have started and terminated by
> > application that uses a number of tasks.
> > > > I am able to reproduce it deterministically...
> > > > While the application is running, I can see the stat values
> perfectly.
> > > > Here is the head output of all /proc/xenomai/* files:
> > >=20
> > > At first sight looking at the code, there seems to be a memory leak
> > > caused by an unfree kmalloc() block in the sched & stat sequence
> > > routines. Will confirm and fix. Thanks,
> > >=20
> >=20
> > Not confirmed for the leakage part regarding kmalloc(). We do have a
> > seq_release_private() freeing the allocated block, so back to square #1=
.
> > This said, some kernel memory is not released somewhere, as running
> > vmstat tells me here.
> >=20
> > Btw, is the rest of your system functional after the error occurs, or i=
s
> > a reboot needed afterwise?
> >=20
> > --=20
> > Philippe.
> >=20
> >=20
> >=20
>=20
> --=20
> Mathias Koehrer
> mathias_koehrer@domain.hid
>=20
>=20
> Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
> ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCns=
tig
> und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer=
,
> nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
> http://www.arcor.de/rd/emf-dsl-2
>=20

--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

