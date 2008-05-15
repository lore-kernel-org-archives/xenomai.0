Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 May 2008 23:30:07 +0200
Message-ID: <4B2EEE69E41E524EB7FCDC62A15D68D8EA1D3C@ARVMAIL1.mra.roland-man.biz>
From: <Thomas.Debes@domain.hid>
Subject: [Xenomai-help] Problems using rtdm_iomap_to_user
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

Hi,
=20
we are currently implementing an RTDM driver for our PCI based fieldbus =
card running in a MPC5200 system (Xenomai 2.3.5/Kernel 2.4 PPC). In =
order to provide backward compatibility for existing applications (using =
an older Linux version of the driver) we need an ioctl to let those =
applications read/write to a mapped io memory. Therefore we used the =
following (incomplete)  piece of code :
=20
void map_dpm_to_user(pcidev_t *pcidev,  rtdm_user_info_t *user_info,  =
void *arg)
 {
        unsigned long memaddr =3D 0, memlen =3D 0;
        unsigned char *dpm =3D NULL;

        /* Get start address and length of resource */
        memaddr =3D pci_resource_start(pcidev, 2);
        memlen =3D pci_resource_len(pcidev, 2);

        memaddr &=3D PCI_BASE_ADDRESS_IO_MASK;

        /* Request resource */
        request_mem_region(memaddr, memlen, NULL);

        /* Remap for direct access in kernel space */
        dpm =3D (unsigned char*)ioremap(memaddrmask, memlen);

        /* Map to user */
        rtdm_iomap_to_user(user_info, memaddr, memlen,
                         PROT_READ|PROT_WRITE, (void **)arg, NULL, =
NULL);
}
=20
This code executes without errors but the application freezes on =
accessing the mapped memory. There was a similar question posted earlier =
(https://mail.gna.org/public/xenomai-core/2007-09/msg00030.html) but the =
suggested solution can not be used with a 2.4 kernel because =
phys_mem_access_prot was introduced with the kernel version 2.6 (afaik). =
 Can you confirm this problem? Are there any related patches in the =
current Xenomai version (2.4.x)?
=20
Thanks
Thomas=20

MAN Roland Druckmaschinen AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle   =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592   =20
USt-Ident-Nr. DE 250200933

