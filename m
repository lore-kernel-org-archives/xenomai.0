MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 30 Aug 2018 13:35:07 +0200
Message-ID: <CAFLxGvwUEfbNtAnx31vUOo0BwR8ZMpstO1=t=bZpa-jpjTUh4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Problem with read-only mmap'ed vmalloc area
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi!

I came across the following problem, an application thread has its
executable section managed by the kernel.
So the kernel can write to the section, but not the userspace
application by accident.
This used to work for ages with a buffer backed by kmalloc memory.
With the demand for larger sections the
buffer is now allocated via vmalloc_user. This lead to an interesting breakage.
When the application reads from the buffer, garbage is read. But if
the buffer is mapped read-write into
the application address space, it works. The mapping is done via
rtdm_mmap_to_user().

So, it seems like there is an issue in rtdm_mmap_to_user() when an
vmalloc buffer is mapped without PROT_WRITE.

I'm on xenomai 2.6.4, arm/imx6.
The affected code seems to be identical also on 3.0.

I think the problem is related on how Xenomai tries to pre-fault pages.
As soon I remove the call to xnarch_fault_range() from
rtdm_mmap_buffer(), the mapping works correctly
and my test passes.

Please find a fully self contained test case below.

Do you have an idea what the problem is?

Thanks,
//richard

$ cat common.h
#ifndef _COMMON_H
#define _COMMON_H

#define IOCTL_ALLOC     _IOWR    ('0', 0, int)
#define IOCTL_MEMCPY    _IOWR    ('0', 1, int)

typedef struct
{
     void *pSource;
     unsigned long offset;
     unsigned long size;
     int prot;
} IoctlType;

#define BUF_LEN         (10 * 1024 * 1024)
#define USER_ADDR       0x6000000UL

#endif

$ cat vmalloc-drv_main.c
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/uaccess.h>
#include <linux/vmalloc.h>

#include <rtdm/rtdm_driver.h>

#include "common.h"
#define DRIVER_NAME "vmallocdrv"

static void *my_buf_address;
static unsigned long my_buf_size;

static int my_ioctl(struct rtdm_dev_context *context,
                    rtdm_user_info_t *user_info, unsigned int request,
                    void *arg)
{
        void __user *argp = (void __user *)arg;
        void __user *source_buf;
        IoctlType ioctlT;
        void *pVirt;
        int err;

        switch (request) {
        case IOCTL_ALLOC:
                if (rtdm_safe_copy_from_user(user_info, &ioctlT, argp,
                                             sizeof(ioctlT)))
                        return -EFAULT;

                my_buf_address = vmalloc_user(ioctlT.size);
                if (my_buf_address == NULL)
                        return -ENOMEM;

                my_buf_size = ioctlT.size;

                pVirt = (void *)USER_ADDR;
                err = rtdm_mmap_to_user(user_info, my_buf_address, my_buf_size,
                                        ioctlT.prot, &pVirt, NULL, NULL);
                if (err != 0)
                        return err;

                if (pVirt != (void *)USER_ADDR)
                        return -EAGAIN;

                memset(my_buf_address, 0xfa, ioctlT.size);
                break;

        case IOCTL_MEMCPY:
                if (rtdm_safe_copy_from_user(user_info, &ioctlT, argp,
                                             sizeof(ioctlT)))
                        return -EFAULT;

                source_buf = (void __user *)ioctlT.pSource;

                if (rtdm_safe_copy_from_user(user_info,
                                             my_buf_address + ioctlT.offset,
                                             source_buf, ioctlT.size))
                        return -EFAULT;
                break;
        }

        return 0;
}

static int lrt_ioctl(struct rtdm_dev_context *context,
                     rtdm_user_info_t *user_info, unsigned int request,
                     void *arg)
{
        return my_ioctl(context, user_info, request, arg);
}

static int lrt_non_rt_ioctl(struct rtdm_dev_context *context,
                            rtdm_user_info_t *user_info, unsigned int request,
                            void *arg)
{
        return my_ioctl(context, user_info, request, arg);
}

static int lrt_open(struct rtdm_dev_context *context,
                    rtdm_user_info_t *user_info, int oflags)
{
        return 0;
}

static int lrt_close(struct rtdm_dev_context *context,
                     rtdm_user_info_t *user_info)
{
        return 0;
}

static struct rtdm_device device = {
        .struct_version = RTDM_DEVICE_STRUCT_VER,

        .device_flags = RTDM_NAMED_DEVICE,
        .device_name = DRIVER_NAME,

        .open_nrt = lrt_open,

        .ops =
                {
                        .close_nrt = lrt_close,

                        .ioctl_rt = lrt_ioctl,
                        .ioctl_nrt = lrt_non_rt_ioctl,

                        .read_rt = NULL,
                        .read_nrt = NULL,

                        .write_rt = NULL,
                        .write_nrt = NULL,

                        .recvmsg_rt = NULL,
                        .recvmsg_nrt = NULL,

                        .sendmsg_rt = NULL,
                        .sendmsg_nrt = NULL,
                },

        .device_class = 6,
        .device_sub_class = 2,
        .profile_version = 2,
        .driver_name = "Test vmalloc",
        .driver_version = RTDM_DRIVER_VER(0, 0, 1),
        .peripheral_name = "Test vmalloc 1",
        .provider_name = "",
        .proc_name = device.device_name,
};

static int __init vmallocdrv_init(void)
{
        return rtdm_dev_register(&device);
}
module_init(vmallocdrv_init);

static void __exit vmallocdrv_exit(void)
{
        rtdm_dev_unregister(&device, 0);
}
module_exit(vmallocdrv_exit);

MODULE_AUTHOR("");
MODULE_DESCRIPTION("");
MODULE_LICENSE("GPL");
MODULE_VERSION("");

$ cat vmalloc-user.c
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <assert.h>
#include <string.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <errno.h>

#include <rtdm/rtdm.h>

#include "common.h"

static void die(const char *msg)
{
        fprintf(stderr, "%s\n", msg);
        exit(0);
}

int main(int argc, char **argv)
{
        int drv_fd;
        void *verify_buf;
        IoctlType ioctlT;
        void *pVirt = (void *)USER_ADDR;

        drv_fd = rt_dev_open("vmallocdrv", O_RDWR);
        if (drv_fd < 0)
                die("drv_open");

        verify_buf = malloc(BUF_LEN);
        if (verify_buf == NULL)
                die("malloc");

        ioctlT.pSource = 0;
        ioctlT.offset = 0;
        ioctlT.size = BUF_LEN;

        /*
         * Test passes when changed to PROT_EXEC | PROT_READ | PROT_WRITE
         */
        ioctlT.prot = PROT_EXEC | PROT_READ;

        if (rt_dev_ioctl(drv_fd, IOCTL_ALLOC, &ioctlT) != 0)
                die("IOCTL MALLOC failed");

        /*
         * Kernel sets initially everything to 0xfa.
         */
        memset(verify_buf, 0xfa, BUF_LEN);

        if (memcmp(pVirt, verify_buf, BUF_LEN) != 0)
                die("Test1: Buffer is different! :-(");

        /*
         * Ask the kernel to copy 0x6b bytes into the buffer.
         */
        memset(verify_buf, 0x6b, BUF_LEN);

        ioctlT.pSource = verify_buf;
        ioctlT.offset = 0;
        ioctlT.size = BUF_LEN;
        ioctlT.prot = 0;
        if (rt_dev_ioctl(drv_fd, IOCTL_MEMCPY, &ioctlT) != 0)
                die("IOCTL MEMCPY failed");

        if (memcmp(pVirt, verify_buf, BUF_LEN) != 0)
                die("Test2: Buffer is different! :-(");

        /*
         * Change the compare buffer, buffer must not match anymore.
         */
        memset(verify_buf, 0xff, BUF_LEN);
        if (memcmp(pVirt, verify_buf, BUF_LEN) == 0)
                die("Test3: Buffer is NOT different! :-(");

        printf("All good!\n");

        return 0;
}

$ cat Makefile.user
CC=$(CROSS_COMPILE)gcc

all: vmalloc-user

EXTRA_CFLAGS += -I$(KSRC)/include/xenomai
-I$(KSRC)/include/xenomai/compat -I$(KSRC)/include/xenomai/rtdm
EXTRA_CFLAGS += -L$(XENOMAI_PATH)/usr/xenomai/lib -Xlinker -rpath
-Xlinker /usr/xenomai/lib -lxenomai -lnative -lrtdm

vmalloc-user: vmalloc-user.c
        $(CC) $(EXTRA_CFLAGS) -O2 -o vmalloc-user vmalloc-user.c

clean:
        rm vmalloc-user

$ cat Makefile
EXTRA_CFLAGS := -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/posix

obj-m   := vmalloc-drv_main.o

all:
        $(MAKE) -C $(KSRC) M=$(PWD) modules
CROSS_COMPILE=$(CROSS_COMPILE) ARCH=arm

