Message-ID: <43E8DB10.5000901@domain.hid>
Date: Tue, 07 Feb 2006 18:38:24 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM mmap alternative
References: <20060203192739.87567.qmail@domain.hid>
	<43E4A197.6030801@domain.hid> <43E4A102.4070207@domain.hid>
	<200602061900.35411.lbocseg@domain.hid>
In-Reply-To: <200602061900.35411.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC60E4D3B9A76AB9F3493CD09"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC60E4D3B9A76AB9F3493CD09
Content-Type: multipart/mixed; boundary="------------030206040902080005060602"

This is a multi-part message in MIME format.
--------------030206040902080005060602
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

[snmp on web.de down, switching account]

Rodrigo Rosenfeld Rosas wrote:
> Hi Jan,
>=20
>> ...
>> What precisely? I suggested to look at remap_pfn_range() or
>> io_remap_page_range(). Do you see problems when using one of them?
>=20
> This is the function prototype:
>=20
> int remap_pfn_range(struct vm_area_struct *vma,
> unsigned long virt_addr, unsigned long pfn,
> unsigned long size, pgprot_t prot);
>=20
> When a mmap call is issued, the vma structure is already initially fill=
ed. I=20
> don't know how to fill it and LDD3 doesn't explain it:
>=20
> "The arguments to remap_pfn_range are fairly straightforward, and most =
of them=20
> are already provided to you in the VMA when your mmap method is called.=
"
>=20
> "Note that the kernel maintains lists and trees of VMAs to optimize are=
a=20
> lookup, and several fields of vm_area_struct are used to maintain this =

> organization. Therefore, VMAs can?t be created at will by a driver, or =
the=20
> structures break."
>=20
> So, I don't know how to implement a mmap like ioctl. Any sugestions?
>=20

Well, I have to say sorry. I was obviously too optimistic about an easy
way to implement mmap-features outside a mmap handler. It's far more
complex.

Ok, we need some helper function in RTDM to make life easier for
driver developers. Attached is a draft to implement

void *rtdm_mmap_to_user(void *buffer, size_t length);

It can only be invoked on continuous kernel memory (kmalloc'ed or
ioremap'ped), but this should be sufficient for the intended
applications. And it only runs in Linux context of course.

I tested it (after figuring out what to do at all, and how to get it
working then...) with a simple demo that returns a shared kernel memory
block, mapped into user-space via an RTDM-IOCTL. I think you should
easily (now really!) adapt it to your needs. Please check if this
functions meets your requirements and works for more than one scenario.
If so, I will add it to official RTDM.


@all: I would be curious to hear any comment on my /dev/zero-trick to
invoke mmap in kernel-space. Is this an ugly hack or may it be worth
considering to apply on /dev/rtheap as well - to overcome the need for
this device (and related user errors...)?

Jan

--------------030206040902080005060602
Content-Type: text/plain;
 name="rtmmap_drv.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="rtmmap_drv.c"

#include <linux/mman.h>

#define XENO_HEAP_MODULE
#include <asm-generic/system.h>
#include <rtdm/rtdm_driver.h>


#define BUFFER_SIZE     100000


struct demodrv_context {
    void *buf;
};


int demo_open_rt(struct rtdm_dev_context    *context,
                 rtdm_user_info_t           *user_info,
                 int                        oflags)
{
    struct demodrv_context  *my_context;
    unsigned long vaddr;


    my_context =3D (struct demodrv_context *)context->dev_private;

    my_context->buf =3D kmalloc(BUFFER_SIZE, 0);
    /* mark pages reserved so that remap_pfn_range works */
    for (vaddr =3D (unsigned long)my_context->buf;
         vaddr < (unsigned long)my_context->buf + BUFFER_SIZE;
         vaddr +=3D PAGE_SIZE)
        SetPageReserved(virt_to_page(vaddr));
    *(int *)my_context->buf =3D 1234;

    return 0;
}


int demo_close_rt(struct rtdm_dev_context   *context,
                  rtdm_user_info_t          *user_info)
{
    struct demodrv_context  *my_context;


    my_context =3D (struct demodrv_context *)context->dev_private;

    printk("%d\n", *((int *)my_context->buf + 1000));

    kfree(my_context->buf);

    return 0;
}


/* *** RTDM mmap helper *** */

static int rtdm_mmap_buffer(struct file *filp, struct vm_area_struct *vma=
)
{
    return xnarch_remap_page_range(vma, vma->vm_start,
                                   virt_to_phys(filp->private_data),
                                   vma->vm_end - vma->vm_start, PAGE_SHAR=
ED);
    return 0;
}


static struct file_operations rtdm_mmap_fops =3D {
    .mmap =3D rtdm_mmap_buffer,
};


void *rtdm_mmap_to_user(void *buffer, size_t length)
{
    struct file *filp;
    struct file_operations *old_fops;
    void *old_priv_data;
    void *user_addr;

    filp =3D filp_open("/dev/zero", O_RDWR, 0);
    if (IS_ERR(filp)) {
        printk("open failed\n");
        return filp;
    }

    old_fops =3D filp->f_op;
    filp->f_op =3D &rtdm_mmap_fops;

    old_priv_data =3D filp->private_data;
    filp->private_data =3D buffer;

    down_write(&current->mm->mmap_sem);
    user_addr =3D (void *)do_mmap(filp, 0, length, PROT_READ|PROT_WRITE, =
MAP_SHARED, 0);
    up_write(&current->mm->mmap_sem);

    filp->f_op =3D old_fops;
    filp->private_data =3D old_priv_data;

    filp_close(filp, current->files);

    return user_addr;
}

/* *** End of RTDM mmap helper *** */


int demo_ioctl_rt(struct rtdm_dev_context   *context,
                  rtdm_user_info_t          *user_info,
                  int                       request,
                  void                      *arg)
{
    struct demodrv_context  *my_context;


    my_context =3D (struct demodrv_context *)context->dev_private;

    printk("buf =3D %p:%x\n", my_context->buf, *(int *)my_context->buf);

    *(void **)arg =3D rtdm_mmap_to_user(my_context->buf, BUFFER_SIZE);
    printk("rtdm_mmap =3D %p %d\n", *(void **)arg, *(int *)arg);

    return 0;
}


static struct rtdm_device demo_device =3D {
    struct_version:     RTDM_DEVICE_STRUCT_VER,

    device_flags:       RTDM_NAMED_DEVICE,
    context_size:       sizeof(struct demodrv_context),
    device_name:        "demodev0",

    open_rt:            NULL,
    open_nrt:           demo_open_rt,

    ops: {
        close_rt:       NULL,
        close_nrt:      demo_close_rt,

        ioctl_rt:       NULL,
        ioctl_nrt:      demo_ioctl_rt,

        read_rt:        NULL,
        read_nrt:       NULL,

        write_rt:       NULL,
        write_nrt:      NULL,

        recvmsg_rt:     NULL,
        recvmsg_nrt:    NULL,

        sendmsg_rt:     NULL,
        sendmsg_nrt:    NULL,
    },

    device_class:       RTDM_CLASS_EXPERIMENTAL,
    device_sub_class:   222,
    driver_name:        "demodrv",
    peripheral_name:    "demodev",
    provider_name:      "-",
    proc_name:          demo_device.device_name,
};

int init_module(void)
{
    int ret;


    ret =3D rtdm_dev_register(&demo_device);
    printk("rtdm_dev_register =3D %d\n", ret);

    return ret;
}


void cleanup_module(void)
{
    rtdm_dev_unregister(&demo_device, 1000);
}


--------------030206040902080005060602
Content-Type: text/plain;
 name="rtmmap.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="rtmmap.c"

#include <stdio.h>
#include <unistd.h>
#include <rtdm/rtdm.h>

int main()
{
    int f =3D rt_dev_open("demodev0", 0);
    void *p;
    printf("open =3D %d\n", f);
    printf("ioctl =3D %d\n", rt_dev_ioctl(f, 0, &p));
    printf("*p =3D %d, p =3D %p\n", *((int *)p), p);
    sleep(10);
    *((int *)p + 1000) =3D 5678;
    printf("close =3D %d\n", rt_dev_close(f));
    return 0;
}


--------------030206040902080005060602
Content-Type: text/plain;
 name="GNUmakefile"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="GNUmakefile"

all:
	make -C /usr/src/linux-2.6.14-ipipe SUBDIRS=3D/usr/src/rtmmap modules
	gcc -o rtmmap rtmmap.c `/usr/src/xenomai/bin/bin/xeno-config --xeno-cfla=
gs` `/usr/src/xenomai/bin/bin/xeno-config --xeno-ldflags` -lrtdm


--------------030206040902080005060602
Content-Type: text/plain;
 name="Makefile"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="Makefile"

EXTRA_CFLAGS +=3D -I /usr/src/linux-2.6.14-ipipe/include/xenomai

obj-m +=3D rtmmap_drv.o


--------------030206040902080005060602--

--------------enigC60E4D3B9A76AB9F3493CD09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD6NsQncNeS9Q0k+IRAtq/AJ9b/Ug54gRdrKsv8NN5wrV3QdViHQCgg5lG
PlzuQYjiaomf5itGXjFHG0s=
=eJEe
-----END PGP SIGNATURE-----

--------------enigC60E4D3B9A76AB9F3493CD09--

