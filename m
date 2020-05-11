MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Mon, 11 May 2020 13:59:50 +0800
Message-ID: <CAAvDm6YJC2r0Kj6+sLAueja0cBnua161gXbtprgh94GknCJQ9Q@mail.gmail.com>
Subject: Could anybody help to reslove the question about _RTIOC_LISTEN?
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi,
       As per the source code(
https://gitlab.denx.de/Xenomai/xenomai/-/blob/v3.0.9/kernel/drivers/net/sta=
ck/ipv4/tcp/tcp.c),
I could see that some code have relation to  _RTIOC_LISTEN.For details, see
below.















*/*** *  rt_tcp_ioctl */static int rt_tcp_ioctl(struct rtdm_fd *fd,
unsigned int request, void __user *arg){    ... case _RTIOC_LISTEN: val =3D
rtnet_get_arg(fd, &_val, arg, sizeof(long)); if (IS_ERR(val)) return
PTR_ERR(val); return rt_tcp_listen(ts, *val); case ...}*

    There is also some code about  *_RTIOC_LISTEN in the drivers of IDDP
and XDDP.*You could see it in the url(
https://gitlab.denx.de/Xenomai/xenomai/-/blob/v3.0.9/kernel/drivers/ipc/xdd=
p.c).For
details, see below.







*static int __xddp_ioctl(struct rtdm_fd *fd, unsigned int request, void
*arg){      ...    case _RTIOC_LISTEN: COMPAT_CASE(_RTIOC_ACCEPT):    ret =
=3D
-EOPNOTSUPP;    break; ...}*
    *Does these _RTIOC_LISTEN showed above in the two source code files
have some relations=EF=BC=9F* I don't think so.
*    There really exist some api relation to XDDP and IDDP.*For instance,
socket, bind, connect,etc.
    *And when you transport your messages through tcp or udp, you also use
the apis with the same name.*
*    So, i am a little confused.*

    Thank you for your attention.
    Look forward to hearing from you.
