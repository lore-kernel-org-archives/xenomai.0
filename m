Message-ID: <43FE4785.90204@domain.hid>
Date: Fri, 24 Feb 2006 00:38:45 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rtdm_mmap_to_user()
References: <200602141114.23856.lbocseg@domain.hid>	<200602161514.44451.lbocseg@domain.hid>	<1140707273.8504.27.camel@domain.hid>
	<200602231443.05861.lbocseg@domain.hid>
In-Reply-To: <200602231443.05861.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDC1846D92BC597C076A38187"
Sender: jan.kiszka@domain.hid
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDC1846D92BC597C076A38187
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Hi Alessio, Jan has already provided such example on the list.
>=20
> For your easy, I'm re-sending it to you.
>=20

Yep, just ignore the patch.

Hannes has prepared some demo driver which I promised to review - I
still haven't done this :-(. But we already identified one pitfall in my
demo: before freeing the shared memory block again, you should call
ClearPageReserved analogously to SetPageReserved.

=2E..
>> ----------------------------------------------------------------------=
--
>>
>> #include <linux/mman.h>
>>
>> #include <rtdm/rtdm_driver.h>
>>
>>
>> #define BUFFER_SIZE     100000
>>
>>
>> struct demodrv_context {
>>     void *buf;
>> };
>>
>>
>> static void demo_vm_close(struct vm_area_struct *vma)
>> {
>>     printk("releasing %p, data =3D %p\n", vma, vma->vm_private_data);
>> }
>>

This hook is useful to detect when the user voluntarily released the
last reference to the mapped block. Alternative, you can rip it away via
rtdm_munmap (e.g. on device close). Just avoid freeing the memory from
kernel space as long as it's mapped and the user has a reference.

>>
>> static struct vm_operations_struct mmap_ops =3D {
>>     .close =3D demo_vm_close,
>> };
>>
>>
>> int demo_open_rt(struct rtdm_dev_context    *context,
>>                  rtdm_user_info_t           *user_info,
>>                  int                        oflags)
>> {
>>     struct demodrv_context  *my_context;
>>     unsigned long vaddr;
>>
>>
>>     my_context =3D (struct demodrv_context *)context->dev_private;
>>
>>     my_context->buf =3D kmalloc(BUFFER_SIZE, 0);
>>     /* mark pages reserved so that remap_pfn_range works */
>>     for (vaddr =3D (unsigned long)my_context->buf;
>>          vaddr < (unsigned long)my_context->buf + BUFFER_SIZE;
>>          vaddr +=3D PAGE_SIZE)
>>         SetPageReserved(virt_to_page(vaddr));
>>     *(int *)my_context->buf =3D 1234;
>>
>>     return 0;
>> }
>>
>>
>> int demo_close_rt(struct rtdm_dev_context   *context,
>>                   rtdm_user_info_t          *user_info)
>> {
>>     struct demodrv_context  *my_context;
>>
>>
>>     my_context =3D (struct demodrv_context *)context->dev_private;
>>
>>     printk("%d\n", *((int *)my_context->buf + 1000));
>>

Here is that ClearPageReserved missing...

>>     kfree(my_context->buf);
>>
>>     return 0;
>> }
>>
>>
>> int demo_ioctl_rt(struct rtdm_dev_context   *context,
>>                   rtdm_user_info_t          *user_info,
>>                   int                       request,
>>                   void                      *arg)
>> {
>>     struct demodrv_context  *my_context;
>>     int err;
>>
>>
>>     my_context =3D (struct demodrv_context *)context->dev_private;
>>
>>     printk("buf =3D %p:%x\n", my_context->buf, *(int *)my_context->buf=
);
>>
>>     err =3D rtdm_mmap_to_user(user_info, my_context->buf, BUFFER_SIZE,=

>>                             PROT_READ|PROT_WRITE, (void **)arg, &mmap_=
ops,
>>                             0x12345678);
>>     printk("rtdm_mmap =3D %p %d\n", *(void **)arg, err);
>>
>>     return 0;
>> }
>>
>>
>> static struct rtdm_device demo_device =3D {
>>     struct_version:     RTDM_DEVICE_STRUCT_VER,
>>
>>     device_flags:       RTDM_NAMED_DEVICE,
>>     context_size:       sizeof(struct demodrv_context),
>>     device_name:        "demodev0",
>>
>>     open_rt:            NULL,
>>     open_nrt:           demo_open_rt,
>>
>>     ops: {
>>         close_rt:       NULL,
>>         close_nrt:      demo_close_rt,
>>
>>         ioctl_rt:       NULL,
>>         ioctl_nrt:      demo_ioctl_rt,
>>
>>         read_rt:        NULL,
>>         read_nrt:       NULL,
>>
>>         write_rt:       NULL,
>>         write_nrt:      NULL,
>>
>>         recvmsg_rt:     NULL,
>>         recvmsg_nrt:    NULL,
>>
>>         sendmsg_rt:     NULL,
>>         sendmsg_nrt:    NULL,
>>     },
>>
>>     device_class:       RTDM_CLASS_EXPERIMENTAL,
>>     device_sub_class:   222,
>>     driver_name:        "demodrv",
>>     peripheral_name:    "demodev",
>>     provider_name:      "-",
>>     proc_name:          demo_device.device_name,
>> };
>>
>> int init_module(void)
>> {
>>     int ret;
>>
>>
>>     ret =3D rtdm_dev_register(&demo_device);
>>     printk("rtdm_dev_register =3D %d\n", ret);
>>
>>     return ret;
>> }
>>
>>
>> void cleanup_module(void)
>> {
>>     rtdm_dev_unregister(&demo_device, 1000);
>> }
>>
>> ----------------------------------------------------------------------=
--
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help

Jan


--------------enigDC1846D92BC597C076A38187
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD/keFniDOoMHTA+kRAo2IAJ4h7qj38cwymr8q75lXm6SqyaQoCACeMIE7
bCi/KtN5fQwjfxQZEXR7L18=
=NIzi
-----END PGP SIGNATURE-----

--------------enigDC1846D92BC597C076A38187--

