Message-ID: <48A46CF1.1070806@domain.hid>
Date: Thu, 14 Aug 2008 19:35:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20080812075358.4cg1ix9945msccsc@domain.hid>	<48A12EA8.4070601@domain.hid>
	<48A34D75.9090509@domain.hid>	<48A359D4.9090002@domain.hid>
	<48A3D20B.2080509@domain.hid>	<48A3D595.9040607@domain.hid>
	<20080814125307.1uviqgmj95no4k0k@domain.hid>
	<48A43555.3070701@domain.hid>
In-Reply-To: <48A43555.3070701@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBB4C595F78A1FFC876418E0A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [RTnet-users] e1000 & MSI
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main <adeos-main@gna.org>, RTnet-users@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBB4C595F78A1FFC876418E0A
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> bernhard@domain.hid wrote:
>>>> Found it. Could you give this patch a try and report the result?
>>>>
>>>> http://permalink.gmane.org/gmane.linux.kernel/682362
>> Applied and tested, no luck...
>>
>> I-pipe: Detected illicit call from domain 'RTAI'
>>          into a service reserved for domain 'Linux' and below.
>> Pid: 0, comm: swapper Not tainted 2.6.26.2-FuCS #1
>>   [<c0156866>] ipipe_check_context+0xd6/0xf0
>> e1000: rteth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
>>   [<c03e206e>] _spin_lock_irqsave+0x1e/0x80
>>   [<c024a7a6>] pci_bus_read_config_word+0x36/0x80
>>   [<c0254156>] __msi_set_enable+0x46/0x80
>>   [<c01176f3>] ? mcount+0x1f/0x23
>>   [<c0254498>] msi_set_mask_bits+0xd8/0xe0
>>   [<c01176f3>] ? mcount+0x1f/0x23
>>   [<c0254737>] unmask_msi_irq+0x17/0x30
>>   [<c01542da>] default_enable+0x1a/0x30
>>   [<f892f1ee>] rt_enable_irq+0xe/0x10 [rtai_hal]
>>   [<f8dabd99>] ? xnintr_irq_handler+0x149/0x1f0 [rtai_rtdm]
>>   [<f893164b>] rtai_hirq_dispatcher+0xfb/0x430 [rtai_hal]
>>   [<c01021c5>] default_idle+0x45/0x60
>>   [<c0102180>] default_idle+0x0/0x60
>>   [<c0103cc7>] common_interrupt+0x2f/0x54
>>   [<c0102180>] default_idle+0x0/0x60
>>   [<c01500d8>] cgroup_file_write+0x118/0x140
>>   [<c01021c5>] default_idle+0x45/0x60
>>   [<c0101b76>] cpu_idle+0x86/0x140
>>   [<c03dd7fd>] start_secondary+0x16d/0x210
>>   [<c03d3a88>] initialize_secondary+0x8/0x20
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

>> I-pipe tracer log (100 points):
>>   |  +*func                    0 ipipe_trace_panic_freeze+0x9 =20
>=20
> I see no option aside of ironing the inner code that reads/writes the P=
CI
> config, so here is an ugly yet possible solution for x86, that might wo=
rk
> (totally untested):

Very ugly. There is potentially some heavy code under this lock.=20
Wouldn't it be better to switch to soft-disabling directly, also given=20
that not all devices will support that method anyway?

Jan


--------------enigBB4C595F78A1FFC876418E0A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkikbPEACgkQniDOoMHTA+n4/QCcD1cTW1IXgLG6/lYQ4yCdA96Z
/3sAnAlRanZbhWp9+GKf8rNI9tkQ0R40
=0lc4
-----END PGP SIGNATURE-----

--------------enigBB4C595F78A1FFC876418E0A--

