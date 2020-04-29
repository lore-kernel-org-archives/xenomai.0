From: ayaida marwane <ayaida_marwane@yahoo.fr>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: RTDM Kernel Driver exchanging with Linux Application via /dev/rtp0/
 using RTIPC Protocol and XDDP socket
Message-Id: <94C4E050-9732-4A9D-B358-7F93BB36E96D@yahoo.fr>
Date: Wed, 29 Apr 2020 23:21:53 +0200
References: <94C4E050-9732-4A9D-B358-7F93BB36E96D.ref@yahoo.fr>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear all,

I am trying to develop a simple example of a RTDM driver running from =
Xenomai Kernel, that exchanges a string ("Hello world!") with a Linux =
Application using /dev/rtp0.

I already succeeded doing this with Xenomai 2 using RT_PIPE. However, as =
I understand, this using RT_PIPE from the Kernel depreciated in Xenomai =
3 and it is recommended to use RTIPC Protocol and a XDDP socket.

In the documentation, there are some examples (xddp-echo.c, xddp-label.c =
and xddp-stream.c), that worked well in my Xenomai 3.0.7 installed on a =
Raspberry Pi3.

However, these examples are using a simple socket Protocol (socket(), =
bind(), sendto() and recvfrom()) using the POSIX Skin. So, using this in =
a RTDM module, will surely not work.

Therefore, as I understand, I have to use the Real-time IPC defined in =
the RTDM Skin  (socket__AF_RTIPC(), bind__AF_RTIPC(), =
sendmsg__AF_RTIPC() and recvmsg__AF_RTIPC()).

I started with a simple example (inspired from xddp-echo.c):

=
--------------------------------------------------------------------------=
-------------------------------------------------------------

#include <rtdm/driver.h>
#include <rtdm/ipc.h>

#define XDDP_PORT 0
static const char *msg =3D "Hello world!";

static int __init my_module_init (void)
{
        int s;

        rtdm_printk(KERN_INFO "%s.%s()\n", THIS_MODULE->name, =
__FUNCTION__);

        s =3D socket__AF_RTIPC(AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP);
        if (s < 0) {
                rtdm_printk(KERN_INFO "socket error\n");
        }
}

static void __exit my_module_exit (void)
{
        rtdm_printk(KERN_INFO "%s.%s()\n", THIS_MODULE->name, =
__FUNCTION__);
}

module_init(my_module_init);
module_exit(my_module_exit);
MODULE_LICENSE("GPL =C2=BB);

=
--------------------------------------------------------------------------=
-------------------------------------------------------------

The Makefile used to compile is this one:

=
--------------------------------------------------------------------------=
-------------------------------------------------------------

obj-m +=3D rtdm-xddp.o

        KERNEL_DIR ?=3D /usr/src/linux
        MODULE_DIR :=3D $(shell pwd)

modules:
        $(MAKE) -C $(KERNEL_DIR) SUBDIRS=3D$(MODULE_DIR) modules

clean::
        rm -f  *.o  .*.o  .*.o.* *.ko  .*.ko  *.mod.* .*.mod.* .*.cmd *~
        rm -f Module.symvers Module.markers modules.order
        rm -rf .tmp_versions

=
--------------------------------------------------------------------------=
-------------------------------------------------------------

The error that I have is:

=
--------------------------------------------------------------------------=
-------------------------------------------------------------

root@raspberrypi:/home/pi/TD3/xddp-noyau# make
make -C /usr/src/linux SUBDIRS=3D/home/pi/TD3/xddp-noyau modules
make[1] : on entre dans le r=C3=A9pertoire =C2=AB /usr/src/linux =C2=BB
  CC [M]  /home/pi/TD3/xddp-noyau/rtdm-xddp.o
/home/pi/TD3/xddp-noyau/rtdm-xddp.c: In function =E2=80=98my_module_init=E2=
=80=99:
/home/pi/TD3/xddp-noyau/rtdm-xddp.c:35:13: error: implicit declaration =
of function =E2=80=98socket__AF_RTIPC=E2=80=99; did you mean =
=E2=80=98socket_seq_show=E2=80=99? =
[-Werror=3Dimplicit-function-declaration]
         s =3D socket__AF_RTIPC(AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP);
             ^~~~~~~~~~~~~~~~
             socket_seq_show
At top level:
/home/pi/TD3/xddp-noyau/rtdm-xddp.c:16:20: warning: =E2=80=98msg=E2=80=99 =
defined but not used [-Wunused-variable]
 static const char *msg =3D "Hello world!";
                    ^~~
cc1: some warnings being treated as errors
make[2]: *** [scripts/Makefile.build:335: =
/home/pi/TD3/xddp-noyau/rtdm-xddp.o] Error 1
make[1]: *** [Makefile:1528: _module_/home/pi/TD3/xddp-noyau] Error 2
make[1] : on quitte le r=C3=A9pertoire =C2=AB /usr/src/linux =C2=BB
make: *** [Makefile:8: modules] Error 2

=
--------------------------------------------------------------------------=
-------------------------------------------------------------

I verified that socket__AF_RTIPC is  well defined in rtdm/uapi/ipc.h, =
which is included on rtdm/ipc.h. So with #include <rtdm/ipc.h>, I must =
have resolved this issue and socket__AF_RTIPC must be already declared.

I did not even add for now the other RTIPC socket's methods =
(bind__AF_RTIPC(), sendmsg__AF_RTIPC() and recvmsg__AF_RTIPC()).

Am I understanding well or I missed something? Could you please clarify =
if I am wrong. Perhaps, this is not possible?

Otherwise, did you have such an example using RTIPC Protocol to =
communicate with a Linux application, It could inspire me to fix my =
error. I did not found any example on the net...

Thank you for your support.

Best regards,
Marwane Ayaida.







