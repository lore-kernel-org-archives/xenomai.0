Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Apr 2011 08:14:20 +0200
Message-ID: <DFFBF4EB468A894AB1474ED220F05AF60134C17D@srv-dc.ona-electroerosion.com>
From: "Asier Tamayo" <asier.tamayo@domain.hid>
Subject: [Xenomai-help] FW: rtdm_iomap_to_user() I-pipe error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


Hello,

I'm porting a PCI driver to a RTDM. Until now, I have successfully done =
most of the job.

I'm using Xenomai version 2.4.7 and Linux 2.6.27, from the ELinOS 5.0 =
distribution.

My problem appears with the rtdm_iomap_to_user() function. I want to =
allow a RT task to access the PCI memory directly, via mmap. As the RTDM =
has no mmap() function, I'm trying to use rtdm_iomap_to_user, but it =
always gives me the following error:

	I-pipe: Detected illicit call from domain 'Xenomai'
	        into a service reserved for domain 'Linux' and below.
	Pid: 991, comm: demo Not tainted 2.6.27.31-ELinOS-59 #66
	 [<c013682b>] ipipe_check_context+0x90/0x9a
	 [<c017ca34>] kmem_cache_alloc+0x23/0xd2
	 [<c0180038>] ? get_empty_filp+0x51/0xc0
	 [<c010db8f>] ? mcount+0x1f/0x23
	 [<c0180038>] get_empty_filp+0x51/0xc0
	 [<c0186ba9>] __path_lookup_intent_open+0x1e/0x7b
	 [<c0186c1b>] path_lookup_open+0x15/0x17
	 [<c01875aa>] do_filp_open+0x82/0x5c8
	 [<c010db8f>] ? mcount+0x1f/0x23
	 [<c0187af8>] ? filp_open+0x8/0x1c
	 [<c0187b07>] filp_open+0x17/0x1c
	 [<c016383d>] rtdm_do_mmap+0x27/0xb3
	 [<c01638f8>] rtdm_iomap_to_user+0x2f/0x31
	(...)
	 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	I-pipe tracer log (100 points):
	    + func                    0 ipipe_trace_panic_freeze+0x9 =
(ipipe_check_context+0x3f)
	    + func                    0 ipipe_check_context+0x9 =
(kmem_cache_alloc+0x23)
	    + func                    0 kmem_cache_alloc+0xe =
(get_empty_filp+0x51)
	    + func                   -1 get_empty_filp+0xa =
(__path_lookup_intent_open+0x1e)
	    + func                   -2 __path_lookup_intent_open+0xe =
(path_lookup_open+0x15)
	    + func                   -2 path_lookup_open+0x8 =
(do_filp_open+0x82)
	    + func                   -3 do_filp_open+0xe (filp_open+0x17)
	    + func                   -4 filp_open+0x8 (rtdm_do_mmap+0x27)
	    + func                   -4 rtdm_do_mmap+0xe =
(rtdm_iomap_to_user+0x2f)
	    + func                   -5 rtdm_iomap_to_user+0xb =
(filstrup_rt_ioctl+0x102 [filstrup1_drv])
	(...)
	filstrup1_drv: rtdm_mmap =3D b5f02000 (retval 0)
	filstrup1_drv: rtdm_mmap =3D b5f02000 (retval 0)

My code is the following (simplified):

	struct xen_mydriver_context *xen_mydriver;

	int mydriver_rt_ioctl(struct rtdm_dev_context *context, =
rtdm_user_info_t *user_info, unsigned int cmd, void *arg)
	{
		(...)
		my_context =3D (struct xen_mydriver_context *)context->dev_private;
		switch(cmd)=20
		{
		case IOCTL_MMAP:
			retval =3D rtdm_iomap_to_user(user_info,my_context->location, 300, =
PROT_READ|PROT_WRITE, (void**)arg, NULL, NULL);
			break;
		(...)
	}

	static int __devinit mydriver_probe(struct pci_dev *dev, const struct =
pci_device_id *id)
	{
		struct rtdm_device *rtdm_dev;
		(...)
		ret_val =3D pci_enable_device(dev);
		(...)
		xen_mydriver->location =3D pci_resource_start(dev,0);	// Physical =
address
		xen_mydriver->mem_size =3D pci_resource_len(dev,0);
		rtdm_dev =3D rtdm_malloc(sizeof(struct rtdm_device));
		(...)
		request_mem_region(xen_mydriver->location, xen_mydriver->mem_size, =
rtdm_dev->device_name);
		xen_mydriver->base_address =3D ioremap(xen_mydriver->location, =
xen_mydriver->mem_size);
		(...)
		ret_val =3D rtdm_dev_register(rtdm_dev);
	}

The value of xen_mydriver->location is 0x20000000. The value of =
xen_mydriver->base_address is 0xe0a00000.

My driver runs correctly until I call the IOCTL_MMAP ioctl. I can write =
to the PCI device directly in the RTDM driver by using the =
xen_mydriver->base_address pointer, but can't do it from the RT task.

I have searched the lists, but found no piece of information that could =
help me. I've found some clues (pci_alloc_consistent, rt_heap_*, =
/dev/rtheap, ...), but it has been impossible for me to solve this =
problem.

Can anyone help me with this issue? Has anyone got an example of how to =
use rtdm_iomap_to_user()?=20

Thanks in advance,=20

Asier




