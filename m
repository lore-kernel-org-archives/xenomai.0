Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 Apr 2011 12:05:50 +0200
Message-ID: <DFFBF4EB468A894AB1474ED220F05AF60134C17F@srv-dc.ona-electroerosion.com>
In-Reply-To: <DFFBF4EB468A894AB1474ED220F05AF60134C17E@srv-dc.ona-electroerosion.com>
From: "Asier Tamayo" <asier.tamayo@domain.hid>
Subject: Re: [Xenomai-help] FW: rtdm_iomap_to_user() I-pipe error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hello again,

When one doesn't get replies to his questions, it may be either because: =
i) they are too obvious (RTFM), ii) too difficult, iii) there is little =
information and it makes the checking in one's system impossible, or iv) =
they haven't been correctly explained. It may also be that the help =
demander is not being polite.

As i have received no answer, I will assume I haven't explained my =
problem correctly and will give myself a second chance ;) The following =
lines will just rewrite my question, since I haven't been able to find =
any new clue:

I'm porting a PCI driver to a RTDM, using Xenomai version 2.4.7 and =
Linux 2.6.27, from the ELinOS 5.0 distribution.

I want to allow a RT task to access the PCI memory directly, by calling =
the rtdm_iomap_to_user() function just after mlockall and rt_dev_open, =
and before rt_task_shadow. The function returns me a correct value, but =
then I cannot access the PCI registers by using that address. The mmap =
seems not to be correct. The values I get:

Driver:
	xen_mydriver->location =3D pci_resource_start(dev,0); --> 0x20000000=20
	xen_mydriver->base_address =3D ioremap(xen_mydriver->location, =
xen_mydriver->mem_size); --> 0xe0a00000=20
	*(unsigned short*)(my_context->base_address + 0x100) =3D 0xAAAA; --> It =
works

RT task:
	rtdm_iomap_to_user(user_info,my_context->location, 300, =
PROT_READ|PROT_WRITE, &new_iomap, NULL, NULL); --> 0xb5f6f000=20
	virt_to_phys(new_iomap) --> 0xf5f6f000
	*(unsigned short*)(new_iomap + 0x100) =3D 0xAAAA; --> It doesn't work =
(either in the driver or in the RT task)

Hope this time I'll get some clue. I promise I won't send this question =
again without any new information.

Anyway, thanks for your time. Best regards,

Asier



> -----Original Message-----
> From: xenomai-help-bounces@domain.hid
> [mailto:xenomai-help-bounces@domain.hid Behalf Of Asier Tamayo
> Sent: Thursday, April 14, 2011 11:38 AM
> To: Jan Kiszka
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] FW: rtdm_iomap_to_user() I-pipe error
>=20
>=20
> Hello Jan,
>=20
> First of all, thanks for your quick answer.=20
>=20
> Yes, you're completely right. My user application called=20
> rt_dev_ioctl, which eventually called rtdm_iomap_to_user,=20
> after rt_task_shadow. Now, I call it just after mlockall and=20
> rt_dev_open, and before rt_task_shadow. The=20
> rtdm_iomap_to_user function now seems to be working=20
> correctly, and dmesg no longer shows the previous errors. [By=20
> the way, it could be interesting to add a=20
> rtdm_in_rt_context() check in the rtdm_iomap_to_user=20
> function, which would return an error if in RT]
>=20
> However, when I later try to write to the device, nothing is=20
> written. The mmap seems not to be correct. The following=20
> lines may show the problem:
> 	rtdm_printk("location %lx --> base %p --> iomap_to_user=20
> %p --> virt_to_phys %lx \n",=20
> 		my_context->location, my_context->base_address,=20
> new_iomap, virt_to_phys(new_iomap));
>=20
> gives the following result:
> 	location  20000000 -> base e0a00000 --> iomap_to_user=20
> b5f6f000 --> virt_to_phys f5f6f000
>=20
> where the variables are:
> 	[unsigned long] xen_mydriver->location =3D=20
> pci_resource_start(dev,0);
> 	[void __iomem*] xen_mydriver->base_address =3D=20
> ioremap(xen_mydriver->location, xen_mydriver->mem_size);
> 	[void __iomem*] new_iomap
> 	rtdm_iomap_to_user(user_info,my_context->location, 300,=20
> PROT_READ|PROT_WRITE, &new_iomap, NULL, NULL);
>=20
> If I execute in my RTDM driver:
> 	*(unsigned short*)(my_context->base_address + 0x100) =3D 0xAAAA;
>=20
> I can see that the address is written. However, if I execute=20
> (either in the driver or from the RT task):
> 	*(unsigned short*)(new_iomap + 0x100) =3D 0xAAAA;
> It doesn't work.
>=20
> Does anybody know what is wrong? I'm sure I must be missing=20
> something important, but I can't see what.
>=20
>=20
> Best regards,
>=20
> Asier
>=20
>=20
>=20
> > -----Original Message-----
> > From: Jan Kiszka [mailto:jan.kiszka@domain.hid]
> > Sent: Thursday, April 14, 2011 9:34 AM
> > To: Asier Tamayo
> > Cc: xenomai@xenomai.org
> > Subject: Re: FW: rtdm_iomap_to_user() I-pipe error
> >=20
> >=20
> > On 2011-04-14 08:14, Asier Tamayo wrote:
> > >=20
> > > Hello,
> > >=20
> > > I'm porting a PCI driver to a RTDM. Until now, I have=20
> > successfully done most of the job.
> > >=20
> > > I'm using Xenomai version 2.4.7 and Linux 2.6.27, from the=20
> > ELinOS 5.0 distribution.
> > >=20
> > > My problem appears with the rtdm_iomap_to_user() function.=20
> > I want to allow a RT task to access the PCI memory directly,=20
> > via mmap. As the RTDM has no mmap() function, I'm trying to=20
> > use rtdm_iomap_to_user, but it always gives me the following error:
> > >=20
> > > 	I-pipe: Detected illicit call from domain 'Xenomai'
> > > 	        into a service reserved for domain 'Linux' and below.
> >=20
> > This is also documented: rtdm_iomap_to_user is not supposed=20
> > to be called
> > from RT task context. This means your driver should only=20
> call it from
> > handlers registered for *_nrt entry points.
> >=20
> > Jan
> >=20
> > --=20
> > Siemens AG, Corporate Technology, CT T DE IT 1
> > Corporate Competence Center Embedded Linux
> >=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20

