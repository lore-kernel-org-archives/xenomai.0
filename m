From: ayaida marwane <ayaida_marwane@yahoo.fr>
Message-Id: <DED11F55-AF03-42D8-A698-75D7A41887AD@yahoo.fr>
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: RTDM Kernel Driver exchanging with Linux Application via
 /dev/rtp0/ using RTIPC Protocol and XDDP socket
Date: Sat, 9 May 2020 02:59:49 +0200
In-Reply-To: <010c1454-3ce4-6bca-b64d-a9797213d734@siemens.com>
References: <94C4E050-9732-4A9D-B358-7F93BB36E96D.ref@yahoo.fr>
 <94C4E050-9732-4A9D-B358-7F93BB36E96D@yahoo.fr>
 <010c1454-3ce4-6bca-b64d-a9797213d734@siemens.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org



> Le 5 mai 2020 =C3=A0 21:22, Jan Kiszka <jan.kiszka@siemens.com> a =
=C3=A9crit :
>=20
> On 29.04.20 23:21, ayaida marwane via Xenomai wrote:
>> Dear all,
>> I am trying to develop a simple example of a RTDM driver running from =
Xenomai Kernel, that exchanges a string ("Hello world!") with a Linux =
Application using /dev/rtp0.
>> I already succeeded doing this with Xenomai 2 using RT_PIPE. However, =
as I understand, this using RT_PIPE from the Kernel depreciated in =
Xenomai 3 and it is recommended to use RTIPC Protocol and a XDDP socket.
>> In the documentation, there are some examples (xddp-echo.c, =
xddp-label.c and xddp-stream.c), that worked well in my Xenomai 3.0.7 =
installed on a Raspberry Pi3.
>> However, these examples are using a simple socket Protocol (socket(), =
bind(), sendto() and recvfrom()) using the POSIX Skin. So, using this in =
a RTDM module, will surely not work.
>> Therefore, as I understand, I have to use the Real-time IPC defined =
in the RTDM Skin  (socket__AF_RTIPC(), bind__AF_RTIPC(), =
sendmsg__AF_RTIPC() and recvmsg__AF_RTIPC()).
>=20
> These calls do not exist (where did you find them?) as your build =
error also says. Check the inter-driver API for such a stacking =
scenario. It provides rtdm_socket, rtdm_sendmsg etc.
>=20
> Depending on what kind of Linux application shall use the API in the =
end, it can be simpler to compile that for Xenomai and use the RTDM =
userspace API directly to talk to the RTDM driver.
>=20
> Jan
>=20
> --=20
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

Dear Jan,

Thank you for your replay. I tried to use the inter-driver API to =
communicate between the RTDM driver and the Linux side using /dev/rtp0. =
The exemple is given below (inspired from xddp-echo.c):

=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=20

#include <rtdm/driver.h>
#include <rtdm/ipc.h>

#define XDDP_PORT 0     /* [0..CONFIG-XENO_OPT_PIPE_NRDEV - 1] and =
/dev/rtpX  */

static const char *msg =3D "Hello world!";

static int __init my_module_init (void)
{
    struct sockaddr_ipc saddr;
    int ret, s, len;
    size_t poolsz;
    char buf[128];

    rtdm_printk(KERN_INFO "%s.%s()\n", THIS_MODULE->name, __FUNCTION__);

    s =3D rtdm_socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP);
    if (s < 0) {
        rtdm_printk(KERN_INFO "socket error\n");
    }

    poolsz =3D 16384; /* bytes */
    ret =3D rtdm_setsockopt(s, SOL_XDDP, XDDP_POOLSZ,
             &poolsz, sizeof(poolsz));
    if (ret)
        rtdm_printk(KERN_INFO "setsockopt error\n");

    memset(&saddr, 0, sizeof(saddr));
    saddr.sipc_family =3D AF_RTIPC;
    saddr.sipc_port =3D XDDP_PORT;
    ret =3D rtdm_bind(s, (struct sockaddr *)&saddr, sizeof(saddr));
    if (ret)
        rtdm_printk(KERN_INFO "bind error\n");

    len =3D strlen(msg);

    rtdm_printk(KERN_INFO "%s: sent %d bytes, \"%.*s\"\n",  =
__FUNCTION__, len, len, msg);

    ret =3D rtdm_sendto(s, msg, len, 0, NULL, 0);

    if (ret !=3D len)
        rtdm_printk(KERN_INFO "sendto error =3D %d \n", ret);

    ret =3D rtdm_recvfrom(s, buf, sizeof(buf), 0, NULL, 0);
    if (ret <=3D 0)
        rtdm_printk(KERN_INFO "recvfrom error\n");

    rtdm_printk(KERN_INFO "%s: =3D=3D> Received from Linux %d bytes : =
%.*s\n", __FUNCTION__, ret, ret, buf);

	return 0;
}

static void __exit my_module_exit (void)
{
	rtdm_printk(KERN_INFO "%s.%s()\n", THIS_MODULE->name, =
__FUNCTION__);
}
module_init(my_module_init);
module_exit(my_module_exit);
MODULE_LICENSE("GPL");

=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=20

Now, the RTDM driver compiles. However, the problem is that when I =
execute it, it gives:

=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=20

[ 5939.538234] rtdm_xddp.my_module_init()
[ 5939.538437] my_module_init: sent 12 bytes, "Hello world!"
[ 5939.538451] sendto error =3D -38=20
[ 5939.538458] recvfrom error
[ 5939.538468] my_module_init: =3D=3D> Received from Linux -38 bytes :=20=

[ 5944.279224] rtdm_xddp.my_module_exit()

=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=20

The sendto fails. When I see the signification of this error is:

=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=20

/*
 * This error code is special: arch syscall entry code will return
 * -ENOSYS if users try to call a syscall that doesn't exist.  To keep
 * failures of syscalls that really do exist distinguishable from
 * failures due to attempts to use a nonexistent syscall, syscall
 * implementations should refrain from returning -ENOSYS.
 */
#define ENOSYS          38      /* Invalid system call number */

=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=20

Why it does not work? I found that the parameters of sendto() and =
rtdm_sendto() are the same.

Thanks for your help.

BR,
Marwane.



