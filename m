Message-ID: <43F126D4.4040407@domain.hid>
Date: Tue, 14 Feb 2006 01:39:48 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] provide rtdm_mmap_to_user / rtdm_munmap
References: <43EBD9D6.5090404@domain.hid>
	<43EBE032.40302@domain.hid>	<200602101858.21108.lbocseg@domain.hid>
	<200602101928.52899.lbocseg@domain.hid>
	<43ED3165.3090300@domain.hid> <43EDE275.5040307@domain.hid>
	<43EDE6D7.8050506@domain.hid> <43EE3E81.80803@domain.hid>
	<43EFBA92.3030306@domain.hid> <43EFFB80.1080104@domain.hid>
In-Reply-To: <43EFFB80.1080104@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig766BFA9086135A99E16A5F10"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig766BFA9086135A99E16A5F10
Content-Type: multipart/mixed; boundary="------------050307080203000004050202"

This is a multi-part message in MIME format.
--------------050307080203000004050202
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Jan Kiszka escreveu:
>> Ok, but even if you decide to let rt-mmap be non-deterministic, you
>> still need some means to prevent the scenario you described above.
>> Actually, all you need is some callback when the mapped memory block w=
as
>> actually released (munmap/application exit). Such a callback can be
>> registered inside the rtdm_mmap handler as a vma_fileop.
> I have never worked with vma_fileop... I would need to learn it first.

Here is the patch to offer you access to those ops. Revert the previous
version, then apply this one. It still needs some final documentation
notes and a test on kernel 2.4. But is should already work on 2.6.

I also attached a demo for the handler usage based on my previous test
framework. Just grab the pattern and put some useful code in the close
handler...

>>  It will run in
>> non-RT, and could be used to mark the related hardware buffer as final=
ly
>> free for re-allocation.
> Now, I did realize that there is one more problem on my current design.=

> If the user application exits or is terminated, I'm not sure if the
> close handler is called if the user forgot/was not able to. If it is
> not, the buffer would be marked as used until I reloaded the driver...
> Is the close handler invocated on application termination?

Yep, this is a general issue you cannot avoid: all skin objects besides
task are only released when the user-space application cleans it up as
it's ought to. There is no tracking of used resources, no auto-cleanup.
If your application fails to close a device or socket, you will get a
stalled handle which can be found in /proc/xenomai/rtdm/open_files.
Writing the file descriptor number to this particular proc-file (e.g.
"echo 3 > /proc/xeno...") will trigger an enforced close and will
release the file descriptor again. Useful when debugging such broken
applications.

Jan

--------------050307080203000004050202
Content-Type: text/x-patch;
 name="rtdm_mmap-v3.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="rtdm_mmap-v3.patch"

Index: include/rtdm/rtdm_driver.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/rtdm/rtdm_driver.h	(Revision 564)
+++ include/rtdm/rtdm_driver.h	(Arbeitskopie)
@@ -995,6 +995,12 @@
     xnfree(ptr);
 }
=20
+int rtdm_mmap_to_user(rtdm_user_info_t *user_info, void *src_addr, size_=
t len,
+                      int prot, void **pptr,
+                      struct vm_operations_struct *vm_ops,
+                      void *vm_private_data);
+int rtdm_munmap(rtdm_user_info_t *user_info, void *ptr, size_t len);
+
 static inline int rtdm_read_user_ok(rtdm_user_info_t *user_info,
                                     const void __user *ptr, size_t size)=

 {
Index: ksrc/skins/rtdm/drvlib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/rtdm/drvlib.c	(Revision 564)
+++ ksrc/skins/rtdm/drvlib.c	(Arbeitskopie)
@@ -31,6 +31,7 @@
=20
=20
 #include <linux/delay.h>
+#include <linux/mman.h>
=20
 #include <rtdm/rtdm_driver.h>
=20
@@ -1286,7 +1287,7 @@
  * Rescheduling: never.
  */
 int rtdm_irq_disable(rtdm_irq_t *irq_handle);
-/** @} */
+/** @} Interrupt Management Services */
=20
=20
 /*!
@@ -1358,16 +1359,158 @@
  * environments.
  */
 void rtdm_nrtsig_pend(rtdm_nrtsig_t *nrt_sig);
-/** @} */
+/** @} Non-Real-Time Signalling Services */
=20
+#endif /* DOXYGEN_CPP */
=20
+
 /*!
  * @ingroup driverapi
  * @defgroup util Utility Services
  * @{
  */
=20
+struct rtdm_mmap_data {
+    void *src_addr;
+    struct vm_operations_struct *vm_ops;
+    void *vm_private_data;
+};
+
+static int rtdm_mmap_buffer(struct file *filp, struct vm_area_struct *vm=
a)
+{
+    struct rtdm_mmap_data *mmap_data =3D filp->private_data;
+
+    vma->vm_ops =3D mmap_data->vm_ops;
+    vma->vm_private_data =3D mmap_data->vm_private_data;
+
+    return xnarch_remap_page_range(vma, vma->vm_start,
+                                   virt_to_phys(mmap_data->src_addr),
+                                   vma->vm_end - vma->vm_start, PAGE_SHA=
RED);
+}
+
+static struct file_operations rtdm_mmap_fops =3D {
+    .mmap =3D rtdm_mmap_buffer,
+};
+
 /**
+ * Map a kernel memory range into the address space of the user.
+ *
+ * @param[in] user_info User information pointer as passed to the invoke=
d
+ * device operation handler
+ * @param[in] src_addr Kernel address to be mapped
+ * @param[in] len Length of the memory range
+ * @param[in] prot Protection flags for the user's memory range, typical=
ly
+ * either PROT_READ or PROT_READ|PROT_WRITE
+ * @param[in,out] pptr Address of a pointer containing the desired user
+ * address or NULL on entry and the finally assigned address on return
+ * @param[in] vm_ops vm_operations to be executed on the vma_area of the=

+ * user memory range or NULL
+ * @param[in] vm_private_data Private data to be stored in the vma_area,=

+ * primarily useful for vm_operation handlers
+ *
+ * @return 0 on success, otherwise:
+ *
+ * - -EXXX is returned if .
+ *
+ * @note RTDM supports two models for unmapping the user memory range ag=
ain.
+ * One is explicite unmapping via rtdm_munmap(), either performed when t=
he
+ * user requests it via an IOCTL etc. or when the related device is clos=
ed.
+ * The other is automatic unmapping, triggered by the user invoking stan=
dard
+ * munmap() or by the termination of the related process. To track relea=
se of
+ * the mapping and therefore relinquishment of the referenced physical m=
emory,
+ * the caller of rtdm_mmap_to_user() can pass a vm_operations_struct on
+ * invocation, defining a close handler for the vm_area. See Linux
+ * documentaion (e.g. Linux Device Drivers book) on virtual memory manag=
ement
+ * for details.
+ *
+ * Environments:
+ *
+ * This service can be called from:
+ *
+ * - Kernel module initialization/cleanup code
+ * - User-space task (non-RT)
+ *
+ * Rescheduling: possible.
+ */
+int rtdm_mmap_to_user(rtdm_user_info_t *user_info, void *src_addr, size_=
t len,
+                      int prot, void **pptr,
+                      struct vm_operations_struct *vm_ops,
+                      void *vm_private_data)
+{
+    struct rtdm_mmap_data   mmap_data =3D {src_addr, vm_ops, vm_private_=
data};
+    struct file             *filp;
+    struct file_operations  *old_fops;
+    void                    *old_priv_data;
+    void                    *user_ptr;
+
+    filp =3D filp_open("/dev/zero", O_RDWR, 0);
+    if (IS_ERR(filp))
+        return PTR_ERR(filp);
+
+    old_fops =3D filp->f_op;
+    filp->f_op =3D &rtdm_mmap_fops;
+
+    old_priv_data =3D filp->private_data;
+    filp->private_data =3D &mmap_data;
+
+    down_write(&user_info->mm->mmap_sem);
+    user_ptr =3D (void *)do_mmap(filp, (unsigned long)*pptr, len, prot,
+                               MAP_SHARED, 0);
+    up_write(&user_info->mm->mmap_sem);
+
+    filp->f_op =3D old_fops;
+    filp->private_data =3D old_priv_data;
+
+    filp_close(filp, user_info->files);
+
+    if (IS_ERR(user_ptr))
+        return PTR_ERR(user_ptr);
+
+    *pptr =3D user_ptr;
+    return 0;
+}
+
+EXPORT_SYMBOL(rtdm_mmap_to_user);
+
+
+/**
+ * Unmap a user memory range.
+ *
+ * @param[in] user_info User information pointer as passed to
+ * rtdm_mmap_to_user() when requesting to map the memory range
+ * @param[in] ptr User address or the memory range
+ * @param[in] len Length of the memory range
+ *
+ * @return 0 on success, otherwise:
+ *
+ * - -EXXX is returned if .
+ *
+ * Environments:
+ *
+ * This service can be called from:
+ *
+ * - Kernel module initialization/cleanup code
+ * - User-space task (non-RT)
+ *
+ * Rescheduling: possible.
+ */
+int rtdm_munmap(rtdm_user_info_t *user_info, void *ptr, size_t len)
+{
+    int err;
+
+    down_write(&user_info->mm->mmap_sem);
+    err =3D do_munmap(user_info->mm, (unsigned long)ptr, len);
+    up_write(&user_info->mm->mmap_sem);
+
+    return err;
+}
+
+EXPORT_SYMBOL(rtdm_munmap);
+
+
+#ifdef DOXYGEN_CPP /* Only used for doxygen doc generation */
+
+/**
  * Real-time safe message printing on kernel console
  *
  * @param[in] format Format string (conforming standard @c printf())
@@ -1583,6 +1726,6 @@
  */
 int rtdm_in_rt_context(void);
=20
-/** @} */
+#endif /* DOXYGEN_CPP */
=20
-#endif /* DOXYGEN_CPP */
+/** @} Utility Services */

--------------050307080203000004050202
Content-Type: text/plain;
 name="rtmmap_drv.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="rtmmap_drv.c"

#include <linux/mman.h>

#include <rtdm/rtdm_driver.h>


#define BUFFER_SIZE     100000


struct demodrv_context {
    void *buf;
};


static void demo_vm_close(struct vm_area_struct *vma)
{
    printk("releasing %p, data =3D %p\n", vma, vma->vm_private_data);
}


static struct vm_operations_struct mmap_ops =3D {
    .close =3D demo_vm_close,
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


int demo_ioctl_rt(struct rtdm_dev_context   *context,
                  rtdm_user_info_t          *user_info,
                  int                       request,
                  void                      *arg)
{
    struct demodrv_context  *my_context;
    int err;


    my_context =3D (struct demodrv_context *)context->dev_private;

    printk("buf =3D %p:%x\n", my_context->buf, *(int *)my_context->buf);

    err =3D rtdm_mmap_to_user(user_info, my_context->buf, BUFFER_SIZE,
                            PROT_READ|PROT_WRITE, (void **)arg, &mmap_ops=
,
                            0x12345678);
    printk("rtdm_mmap =3D %p %d\n", *(void **)arg, err);

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

--------------050307080203000004050202--

--------------enig766BFA9086135A99E16A5F10
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD8SbYniDOoMHTA+kRAtorAJ4nGkrHcNQPe+Kn6Lclo+aSlyya6gCfUQz0
nMzo+hUFE7Oi62Yu0l2Gcfc=
=vBtv
-----END PGP SIGNATURE-----

--------------enig766BFA9086135A99E16A5F10--

