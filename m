Date: Mon, 23 May 2022 22:16:31 +0000 (UTC)
From: ayaida marwane <ayaida_marwane@yahoo.fr>
Message-ID: <1633441315.3007897.1653344191988@mail.yahoo.com>
In-Reply-To: <DED11F55-AF03-42D8-A698-75D7A41887AD@yahoo.fr>
References: <94C4E050-9732-4A9D-B358-7F93BB36E96D.ref@yahoo.fr>
 <94C4E050-9732-4A9D-B358-7F93BB36E96D@yahoo.fr>
 <010c1454-3ce4-6bca-b64d-a9797213d734@siemens.com>
 <DED11F55-AF03-42D8-A698-75D7A41887AD@yahoo.fr>
Subject: Re: RTDM Kernel Driver exchanging with Linux Application via
 /dev/rtp0/ using RTIPC Protocol and XDDP socket
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

 Dear Jan,
I am coming back to the same question since I did not succeed in this task,=
 now my example looks like :=C2=A0
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=C2=A0

#include <rtdm/driver.h>

#include <rtdm/ipc.h>




#define XDDP_PORT 0

int ret;




rtdm_task_t task_desc;




static const char *msg =3D "Hello world!";




void task(void *arg){




=C2=A0 =C2=A0 int count =3D 0;

=C2=A0 =C2=A0 struct sockaddr_ipc saddr;

=C2=A0 =C2=A0 int s, len;

=C2=A0 =C2=A0 size_t poolsz;

=C2=A0=C2=A0 =C2=A0

=C2=A0 =C2=A0 /*

=C2=A0=C2=A0 =C2=A0 * Get a datagram socket to bind to the RT endpoint. Eac=
h

=C2=A0=C2=A0 =C2=A0 * endpoint is represented by a port number within the X=
DDP

=C2=A0=C2=A0 =C2=A0 * protocol namespace.

=C2=A0=C2=A0 =C2=A0 */

=C2=A0 =C2=A0 s =3D rtdm_socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP);

=C2=A0 =C2=A0 if (s < 0) {

=C2=A0 =C2=A0 =C2=A0 =C2=A0 rtdm_printk(KERN_INFO "socket error =3D %d\n",s=
);

=C2=A0 =C2=A0 }

=C2=A0 =C2=A0 else{

=C2=A0 =C2=A0 =C2=A0 =C2=A0 rtdm_printk(KERN_INFO "socket succeed =3D %d\n"=
,s);

=C2=A0 =C2=A0 }




=C2=A0 =C2=A0 /*

=C2=A0=C2=A0 =C2=A0 * Set a local 16k pool for the RT endpoint. Memory need=
ed to

=C2=A0=C2=A0 =C2=A0 * convey datagrams will be pulled from this pool, inste=
ad of

=C2=A0=C2=A0 =C2=A0 * Xenomai's system pool.

=C2=A0=C2=A0 =C2=A0 */

=C2=A0 =C2=A0 poolsz =3D 16384; /* bytes */

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D rtdm_setsockopt(s, SOL_XDDP, XDD=
P_POOLSZ,

=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &poolsz, sizeof(poolsz));

=C2=A0 =C2=A0 if (ret)

=C2=A0 =C2=A0 =C2=A0 =C2=A0 rtdm_printk(KERN_INFO "setsockopt error=3D %d\n=
",ret);

=C2=A0 =C2=A0 else{

=C2=A0 =C2=A0 =C2=A0 =C2=A0 rtdm_printk(KERN_INFO "setsockopt succeed =3D %=
d\n",ret);

=C2=A0 =C2=A0 }




=C2=A0 =C2=A0 /*

=C2=A0=C2=A0 =C2=A0 * Bind the socket to the port, to setup a proxy to chan=
nel

=C2=A0=C2=A0 =C2=A0 * traffic to/from the Linux domain.

=C2=A0=C2=A0 =C2=A0 *

=C2=A0=C2=A0 =C2=A0 * saddr.sipc_port specifies the port number to use.

=C2=A0=C2=A0 =C2=A0 */

=C2=A0 =C2=A0 memset(&saddr, 0, sizeof(saddr));

=C2=A0 =C2=A0 saddr.sipc_family =3D AF_RTIPC;

=C2=A0 =C2=A0 saddr.sipc_port =3D XDDP_PORT;

=C2=A0 =C2=A0 ret =3D rtdm_bind(s, (struct sockaddr *)&saddr, sizeof(saddr)=
);

=C2=A0 =C2=A0 if (ret)

=C2=A0 =C2=A0 =C2=A0 =C2=A0 rtdm_printk(KERN_INFO "bind error =3D %d\n", re=
t);

=C2=A0 =C2=A0 else{

=C2=A0 =C2=A0 =C2=A0 =C2=A0 rtdm_printk(KERN_INFO "bind succeed =3D %d\n",r=
et);

=C2=A0 =C2=A0 }

}




static int __init my_module_init (void)

{

=C2=A0 =C2=A0 rtdm_printk(KERN_INFO "%s.%s()\n", THIS_MODULE->name, __FUNCT=
ION__);

=C2=A0=C2=A0 =C2=A0

=C2=A0 =C2=A0 ret =3D rtdm_task_init(&task_desc, "rtdm-example", task, NULL=
, 30, 0);=C2=A0




=C2=A0 =C2=A0 if (ret) {

=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtdm_printk(KERN_INFO "%s.%=
s() : error rtdm_task_init\n", THIS_MODULE->name, __FUNCTION__);

=C2=A0 =C2=A0 }




=C2=A0 =C2=A0 else=C2=A0 rtdm_printk(KERN_INFO "%s.%s() : success rtdm_task=
_init\n", THIS_MODULE->name, __FUNCTION__);




 return 0;

}










static void __exit my_module_exit (void)

{

=C2=A0 =C2=A0 rtdm_task_destroy(&task_desc);




=C2=A0 =C2=A0 rtdm_printk(KERN_INFO "%s.%s()\n", THIS_MODULE->name, __FUNCT=
ION__);

}










module_init(my_module_init);

module_exit(my_module_exit);

MODULE_LICENSE("GPL");


=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=C2=A0
Now, the RTDM driver compiles. However, the problem is that when I execute =
it, it gives:
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=C2=A0

[=C2=A0 470.184417] rtdm_xddp.my_module_init()

[=C2=A0 470.184932] rtdm_xddp.my_module_init() : success rtdm_task_init

[=C2=A0 470.185003] socket succeed =3D 1

[=C2=A0 470.185013] setsockopt succeed =3D 0

[=C2=A0 470.185022] bind error =3D -38
[=C2=A0 470.271916] rtdm_xddp.my_module_exit()
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=C2=A0
The=C2=A0bind=C2=A0fails. When I=C2=A0see the signification of this error i=
s:
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=C2=A0
/*
=C2=A0* This error code is special: arch syscall entry code will return
=C2=A0* -ENOSYS if users try to call a syscall that doesn't exist.=C2=A0=C2=
=A0To keep
=C2=A0* failures of syscalls that really do exist distinguishable from
=C2=A0* failures due to attempts to use a nonexistent syscall, syscall
=C2=A0* implementations should refrain from returning -ENOSYS.
=C2=A0*/
#define=C2=A0ENOSYS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A038=C2=A0 =C2=A0 =
=C2=A0=C2=A0/* Invalid system call number */
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=C2=A0
Why it does not work?
Thanks for your help.
BR,Marwane.

    Le samedi 9 mai 2020 =C3=A0 02:59:50 UTC+2, ayaida marwane <ayaida_marw=
ane@yahoo.fr> a =C3=A9crit : =20
=20
=20


Le 5 mai 2020 =C3=A0 21:22, Jan Kiszka <jan.kiszka@siemens.com> a =C3=A9cri=
t :
On 29.04.20 23:21, ayaida marwane via Xenomai wrote:

Dear all,
I am trying to develop a simple example of a RTDM driver running from Xenom=
ai Kernel, that exchanges a string ("Hello world!") with a Linux Applicatio=
n using /dev/rtp0.
I already succeeded doing this with Xenomai 2 using RT_PIPE. However, as I =
understand, this using RT_PIPE from the Kernel depreciated in Xenomai 3 and=
 it is recommended to use RTIPC Protocol and a XDDP socket.
In the documentation, there are some examples (xddp-echo.c, xddp-label.c an=
d xddp-stream.c), that worked well in my Xenomai 3.0.7 installed on a Raspb=
erry Pi3.
However, these examples are using a simple socket Protocol (socket(), bind(=
), sendto() and recvfrom()) using the POSIX Skin. So, using this in a RTDM =
module, will surely not work.
Therefore, as I understand, I have to use the Real-time IPC defined in the =
RTDM Skin =C2=A0(socket__AF_RTIPC(), bind__AF_RTIPC(), sendmsg__AF_RTIPC() =
and recvmsg__AF_RTIPC()).


These calls do not exist (where did you find them?) as your build error als=
o says. Check the inter-driver API for such a stacking scenario. It provide=
s rtdm_socket, rtdm_sendmsg etc.

Depending on what kind of Linux application shall use the API in the end, i=
t can be simpler to compile that for Xenomai and use the RTDM userspace API=
 directly to talk to the RTDM driver.

Jan

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


Dear Jan,
Thank you for your replay. I tried to use the inter-driver API to communica=
te between the RTDM driver and the Linux side using /dev/rtp0. The exemple =
is given below (inspired from xddp-echo.c):
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=C2=A0
#include <rtdm/driver.h>#include <rtdm/ipc.h>
#define XDDP_PORT 0 =C2=A0 =C2=A0 /* [0..CONFIG-XENO_OPT_PIPE_NRDEV - 1] an=
d /dev/rtpX=C2=A0 */
static const char *msg =3D "Hello world!";
static int __init my_module_init (void){=C2=A0 =C2=A0 struct sockaddr_ipc s=
addr;=C2=A0 =C2=A0 int ret, s, len;=C2=A0 =C2=A0 size_t poolsz;=C2=A0 =C2=
=A0 char buf[128];
=C2=A0 =C2=A0 rtdm_printk(KERN_INFO "%s.%s()\n", THIS_MODULE->name, __FUNCT=
ION__);
=C2=A0 =C2=A0 s =3D rtdm_socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP);=C2=A0=
 =C2=A0 if (s < 0) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 rtdm_printk(KERN_INFO "sock=
et error\n");=C2=A0 =C2=A0 }
=C2=A0 =C2=A0 poolsz =3D 16384; /* bytes */=C2=A0 =C2=A0 ret =3D rtdm_setso=
ckopt(s, SOL_XDDP, XDDP_POOLSZ,=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &poolsz, sizeof(poolsz));=C2=A0 =C2=A0 if (ret)=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 rtdm_printk(KERN_INFO "setsockopt error\n");
=C2=A0 =C2=A0 memset(&saddr, 0, sizeof(saddr));=C2=A0 =C2=A0 saddr.sipc_fam=
ily =3D AF_RTIPC;=C2=A0 =C2=A0 saddr.sipc_port =3D XDDP_PORT;=C2=A0 =C2=A0 =
ret =3D rtdm_bind(s, (struct sockaddr *)&saddr, sizeof(saddr));=C2=A0 =C2=
=A0 if (ret)=C2=A0 =C2=A0 =C2=A0 =C2=A0 rtdm_printk(KERN_INFO "bind error\n=
");
=C2=A0 =C2=A0 len =3D strlen(msg);
=C2=A0 =C2=A0 rtdm_printk(KERN_INFO "%s: sent %d bytes, \"%.*s\"\n",=C2=A0 =
__FUNCTION__, len, len, msg);
=C2=A0 =C2=A0 ret =3D rtdm_sendto(s, msg, len, 0, NULL, 0);
=C2=A0 =C2=A0 if (ret !=3D len)=C2=A0 =C2=A0 =C2=A0 =C2=A0 rtdm_printk(KERN=
_INFO "sendto error =3D %d \n", ret);
=C2=A0 =C2=A0 ret =3D rtdm_recvfrom(s, buf, sizeof(buf), 0, NULL, 0);=C2=A0=
 =C2=A0 if (ret <=3D 0)=C2=A0 =C2=A0 =C2=A0 =C2=A0 rtdm_printk(KERN_INFO "r=
ecvfrom error\n");
=C2=A0 =C2=A0 rtdm_printk(KERN_INFO "%s: =3D=3D> Received from Linux %d byt=
es : %.*s\n", __FUNCTION__, ret, ret, buf);
 return 0;}
static void __exit my_module_exit (void){ rtdm_printk(KERN_INFO "%s.%s()\n"=
, THIS_MODULE->name, __FUNCTION__);}module_init(my_module_init);module_exit=
(my_module_exit);MODULE_LICENSE("GPL");
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=C2=A0
Now, the RTDM driver compiles. However, the problem is that when I execute =
it, it gives:
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=C2=A0
[ 5939.538234] rtdm_xddp.my_module_init()[ 5939.538437] my_module_init: sen=
t 12 bytes, "Hello world!"[ 5939.538451] sendto error =3D -38=C2=A0[ 5939.5=
38458] recvfrom error[ 5939.538468] my_module_init: =3D=3D> Received from L=
inux -38 bytes :=C2=A0[ 5944.279224] rtdm_xddp.my_module_exit()
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=C2=A0
The sendto fails. When I=C2=A0see the signification of this error is:
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=C2=A0
/*
=C2=A0* This error code is special: arch syscall entry code will return
=C2=A0* -ENOSYS if users try to call a syscall that doesn't exist.=C2=A0=C2=
=A0To keep
=C2=A0* failures of syscalls that really do exist distinguishable from
=C2=A0* failures due to attempts to use a nonexistent syscall, syscall
=C2=A0* implementations should refrain from returning -ENOSYS.
=C2=A0*/
#define=C2=A0ENOSYS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A038=C2=A0 =C2=A0 =
=C2=A0=C2=A0/* Invalid system call number */
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=C2=A0
Why it does not work? I found that the parameters of sendto() and=C2=A0rtdm=
_sendto() are the same.
Thanks for your help.
BR,Marwane.


 =20
