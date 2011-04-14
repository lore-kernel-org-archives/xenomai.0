Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Apr 2011 11:38:11 +0200
Message-ID: <DFFBF4EB468A894AB1474ED220F05AF60134C17E@srv-dc.ona-electroerosion.com>
In-reply-to: <4DA6A36D.6070908@domain.hid>
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

Hello Jan,

First of all, thanks for your quick answer.=20

Yes, you're completely right. My user application called rt_dev_ioctl, =
which eventually called rtdm_iomap_to_user, after rt_task_shadow. Now, I =
call it just after mlockall and rt_dev_open, and before rt_task_shadow. =
The rtdm_iomap_to_user function now seems to be working correctly, and =
dmesg no longer shows the previous errors. [By the way, it could be =
interesting to add a rtdm_in_rt_context() check in the =
rtdm_iomap_to_user function, which would return an error if in RT]

However, when I later try to write to the device, nothing is written. =
The mmap seems not to be correct. The following lines may show the =
problem:
	rtdm_printk("location %lx --> base %p --> iomap_to_user %p --> =
virt_to_phys %lx \n",=20
		my_context->location, my_context->base_address, new_iomap, =
virt_to_phys(new_iomap));

gives the following result:
	location  20000000 -> base e0a00000 --> iomap_to_user b5f6f000 --> =
virt_to_phys f5f6f000

where the variables are:
	[unsigned long] xen_mydriver->location =3D pci_resource_start(dev,0);
	[void __iomem*] xen_mydriver->base_address =3D =
ioremap(xen_mydriver->location, xen_mydriver->mem_size);
	[void __iomem*] new_iomap
	rtdm_iomap_to_user(user_info,my_context->location, 300, =
PROT_READ|PROT_WRITE, &new_iomap, NULL, NULL);

If I execute in my RTDM driver:
	*(unsigned short*)(my_context->base_address + 0x100) =3D 0xAAAA;

I can see that the address is written. However, if I execute (either in =
the driver or from the RT task):
	*(unsigned short*)(new_iomap + 0x100) =3D 0xAAAA;
It doesn't work.

Does anybody know what is wrong? I'm sure I must be missing something =
important, but I can't see what.


Best regards,

Asier



> -----Original Message-----
> From: Jan Kiszka [mailto:jan.kiszka@domain.hid]
> Sent: Thursday, April 14, 2011 9:34 AM
> To: Asier Tamayo
> Cc: xenomai@xenomai.org
> Subject: Re: FW: rtdm_iomap_to_user() I-pipe error
>=20
>=20
> On 2011-04-14 08:14, Asier Tamayo wrote:
> >=20
> > Hello,
> >=20
> > I'm porting a PCI driver to a RTDM. Until now, I have=20
> successfully done most of the job.
> >=20
> > I'm using Xenomai version 2.4.7 and Linux 2.6.27, from the=20
> ELinOS 5.0 distribution.
> >=20
> > My problem appears with the rtdm_iomap_to_user() function.=20
> I want to allow a RT task to access the PCI memory directly,=20
> via mmap. As the RTDM has no mmap() function, I'm trying to=20
> use rtdm_iomap_to_user, but it always gives me the following error:
> >=20
> > 	I-pipe: Detected illicit call from domain 'Xenomai'
> > 	        into a service reserved for domain 'Linux' and below.
>=20
> This is also documented: rtdm_iomap_to_user is not supposed=20
> to be called
> from RT task context. This means your driver should only call it from
> handlers registered for *_nrt entry points.
>=20
> Jan
>=20
> --=20
> Siemens AG, Corporate Technology, CT T DE IT 1
> Corporate Competence Center Embedded Linux
>=20

