Message-ID: <4A5F9E8A.3010906@domain.hid>
Date: Thu, 16 Jul 2009 23:41:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <alpine.DEB.2.00.0907142049190.4341@domain.hid>	<4A5D88E9.2010305@domain.hid>	<Pine.LNX.4.62.0907151048370.24398@domain.hid>
	<Pine.LNX.4.62.0907151610090.24888@domain.hid>
In-Reply-To: <Pine.LNX.4.62.0907151610090.24888@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2E0547AC513F5A6305782F45"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] rtdm_mmap_to_user without MMU
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kolja Waschk <xenoka09@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2E0547AC513F5A6305782F45
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Kolja Waschk wrote:
> Hi,
>=20
> I finally seem to have a complete solution for my case. It's probably
> still missing one or the other detail, but it starts to work. I only
> added a few lines to ksrc/skins/rtdm/drvlib.c in rtdm_do_mmap:
>=20
> 1. Because linux/mm/nommu.c/validate_mmap_request() checks the
> capabilities of the backing dev, and /dev/zero lacks BDI_CAP_MAP_DIRECT=

> capability, the /dev/mem has to be used instead of /dev/zero.
>=20
>> filp =3D filp_open("/dev/mem", O_RDWR, 0);
>=20
> 2. A get_unmapped_area() f_op has to be provided on nommu systems. It i=
s
> also checked by validate_mmap_request(). I just copy in the pointer fro=
m
> old_fops: the /dev/mem f_op->get_unmapped_area simply passes pgoffs.
>=20
>> rtdm_mmap_fops.get_unmapped_area =3D old_fops->get_unmapped_area;
>=20
> 3. Since /dev/mem is used, the offset passed to do_mmap() has to
> point to the actual buffer (probably the physical address, for now I
> just used mmap_data->src_vaddr).
>=20
>> user_ptr =3D (void *)do_mmap(filp, (unsigned long)*pptr, len, prot,
>>            MAP_SHARED, mmap_data->src_vaddr);
>=20

Nice analysis! I tried to fold your findings into a patch (actually,
they will become two in the end), see below. Please check if it works
for you.

In the meantime I need to verify if switching to /dev/mem comes without
side-effects for CONFIG_MMU. Anyone with a rtdm_mmap/iomap_to_user test
case at hand is welcome to check this, too!

Jan

---------->

diff --git a/ksrc/skins/rtdm/drvlib.c b/ksrc/skins/rtdm/drvlib.c
index 9f1cda8..3f37e75 100644
--- a/ksrc/skins/rtdm/drvlib.c
+++ b/ksrc/skins/rtdm/drvlib.c
@@ -1844,8 +1844,24 @@ static int rtdm_mmap_buffer(struct file *filp, str=
uct vm_area_struct *vma)
 	return ret;
 }
=20
+#ifndef CONFIG_MMU
+static unsigned long rtdm_get_unmapped_area(struct file *file,
+					    unsigned long addr,
+					    unsigned long len,
+					    unsigned long pgoff,
+					    unsigned long flags)
+{
+	struct rtdm_mmap_data *mmap_data =3D filp->private_data;
+
+	return mmap_data->src_vaddr;
+}
+#endif /* !CONFIG_MMU */
+
 static struct file_operations rtdm_mmap_fops =3D {
 	.mmap =3D rtdm_mmap_buffer,
+#ifndef CONFIG_MMU
+	.get_unmapped_area =3D rtdm_get_unmapped_area,
+#endif /* !CONFIG_MMU */
 };
=20
 static int rtdm_do_mmap(rtdm_user_info_t *user_info,
@@ -1859,7 +1875,7 @@ static int rtdm_do_mmap(rtdm_user_info_t *user_info=
,
=20
 	XENO_ASSERT(RTDM, xnpod_root_p(), return -EPERM;);
=20
-	filp =3D filp_open("/dev/zero", O_RDWR, 0);
+	filp =3D filp_open("/dev/mem", O_RDWR, 0);
 	if (IS_ERR(filp))
 		return PTR_ERR(filp);
=20


--------------enig2E0547AC513F5A6305782F45
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkpfno8ACgkQniDOoMHTA+lKFQCdHx+f2/rdanVkPQY9dIA2fq/N
fC4AniIw02g/XKem0FiCFOpOQemdz4ZN
=G76o
-----END PGP SIGNATURE-----

--------------enig2E0547AC513F5A6305782F45--

