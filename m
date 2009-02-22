Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Feb 2009 15:41:22 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D590F8C@slcmail.slc.mew.int>
In-Reply-To: <49A1D243.6060801@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D590F8B@slcmail.slc.mew.int>
	<49A1D243.6060801@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] xenomai on atom
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe,=20

Next time I ask such a question I'll be sure to specify --verbose=3D0 :)

Thanks,
Steven

> -----Original Message-----
> From: Philippe Gerum [mailto:rpm@xenomai.org]
> Sent: Sunday, February 22, 2009 3:32 PM
> To: Steven Seeger
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] xenomai on atom
>=20
> Steven Seeger wrote:
> > Would there be any issue running Xenomai on an atom processor?
> >
>=20
> atom login: root
> # dmesg
>=20
> <snip>
>=20
> Detected 1596.202 MHz processor.
> I-pipe 2.2-06: pipeline enabled.
> Console: colour VGA+ 80x25
> console [ttyS0] enabled
> Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
> Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
> Checking aperture...
> No AGP bridge found
> Memory: 2047812k/2087936k available (3426k kernel code, 1128k absent,
> 38372k
> reserved, 1269k data, 364k init)
> hpet clockevent registered
> HPET: 3 timers in total, 0 timers will be used for per-cpu timer
> Calibrating delay loop (skipped), value calculated using timer
> frequency..
> 3192.40 BogoMIPS (lpj=3D6384808)
> Mount-cache hash table entries: 256
> Initializing cgroup subsys ns
> Initializing cgroup subsys cpuacct
> CPU: L1 I cache: 32K, L1 D cache: 24K
> CPU: L2 cache: 512K
> CPU: Physical Processor ID: 0
> CPU: Processor Core ID: 0
> ACPI: Core revision 20080926
> Setting APIC routing to flat
> ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
> CPU0: Intel(R) Atom(TM) CPU  230   @ 1.60GHz stepping 02
> Booting processor 1 APIC 0x1 ip 0x6000
> Initializing CPU#1
> Calibrating delay using timer specific routine.. 3192.15 BogoMIPS
> (lpj=3D6384309)
> CPU: L1 I cache: 32K, L1 D cache: 24K
> CPU: L2 cache: 512K
> CPU: Physical Processor ID: 0
> CPU: Processor Core ID: 0
> x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
> CPU1: Intel(R) Atom(TM) CPU  230   @ 1.60GHz stepping 02
> checking TSC synchronization [CPU#0 -> CPU#1]: passed.
> Brought up 2 CPUs
> Total of 2 processors activated (6384.55 BogoMIPS).
>=20
> <snip>
>=20
> NET: Registered protocol family 2
> IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
> TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
> TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
> TCP: Hash tables configured (established 262144 bind 65536)
> TCP reno registered
> NET: Registered protocol family 1
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/x86_64 started.
> Xenomai: real-time nucleus v2.4.6 (Bamboo) loaded.
>=20
>=20
> >
> >
> > Thanks,
> >
> > Steven
> >
> >
> >
> >
> >
---------------------------------------------------------------------
> ---
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
>=20
>=20
> --
> Philippe.

