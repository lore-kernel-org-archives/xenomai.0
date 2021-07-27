From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <b70b84f9-fd99-78ed-53d5-ae38faf86891@siemens.com>
Content-Type: text/plain; charset="utf-8"
Date: Tue, 27 Jul 2021 14:13:28 +0200
MIME-Version: 1.0
Message-ID: <10a0-60fff880-111-29fb8780@204571665>
Subject: =?utf-8?q?Re=3A?==?utf-8?q?_=5BPATCH?==?utf-8?q?_v2=5D?= Enable
 retrieving 
 of RTNET network packet timestamp OOB using =?utf-8?q?recvmsg=28=29?=
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

Le Lundi, Juillet 26, 2021 14:01 CEST, Jan Kiszka <jan.kiszka@siemens.c=
om> a =C3=A9crit: 
 
> On 17.05.21 11:44, Fran=C3=A7ois Legal via Xenomai wrote:
> > This patch enables retrieving, in realtime application, of RTNET en=
abled adapters packet timestamps.
> > It uses the linux semantic SO=5FTIMESTAMPNS, and the linux code to =
put the timestamp in the control=5Fmsg structure.
> > 
> > I tested this patch with af=5Fpacket sockets only. UDP  & TCP might=
 be a little bit trickier as many fragment/segments get reassembled in =
a single recvmsg. I believe the linux code I used to put the timestamps=
 in the control structure should be OK though.
> 
> One of my question on v1 is still open: How does Linux handle stampin=
g
> the context of fragmented UDP and TCP packets? And given that you ena=
ble
> it for those protocols as well, we should likely test that too.

I thought I already gave an answer to this. Sorry.
Linux does not handle time stamping of UDP and TCP as far as I understa=
nd.
I certainly plan to use the UDP timestamping feature at some point in t=
he future, but maybe I can exclude UDP and TCP for the moment, and stic=
k to af=5Fpacket which has be tested by myself. I'll resubmit another p=
atch with (at least) udp support whenever I need it and have time to te=
st it.

What do you think ?

Fran=C3=A7ois

> 
> > 
> > Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
> > ---
> >  kernel/drivers/net/stack/Kconfig              |  8 +++
> >  .../drivers/net/stack/include/rtnet=5Fsocket.h  |  7 +++
> >  kernel/drivers/net/stack/ipv4/tcp/tcp.c       |  8 +++
> >  kernel/drivers/net/stack/ipv4/udp/udp.c       |  7 +++
> >  kernel/drivers/net/stack/packet/af=5Fpacket.c   |  7 +++
> >  kernel/drivers/net/stack/socket.c             | 59 +++++++++++++++=
++++
> >  6 files changed, 96 insertions(+)
> > 
> > diff --git a/kernel/drivers/net/stack/Kconfig b/kernel/drivers/net/=
stack/Kconfig
> > index 830cec5ad..f8ee0f1ad 100644
> > --- a/kernel/drivers/net/stack/Kconfig
> > +++ b/kernel/drivers/net/stack/Kconfig
> > @@ -12,6 +12,14 @@ config XENO=5FDRIVERS=5FNET=5FRX=5FFIFO=5FSIZE
> >      of two! Effectively, only CONFIG=5FRTNET=5FRX=5FFIFO=5FSIZE-1 =
slots will
> >      be usable.
> >  
> > +config XENO=5FDRIVERS=5FNET=5FPACKET=5FTIMESTAMP
> > +    bool "Enable packet timestamping (SO=5FTIMESTAMPNS)"
> > +    depends on XENO=5FDRIVERS=5FNET
> > +    ---help---
> > +    Enable userland access to low level packet timestamps using SO=
=5FTIMESTAMPNS
> > +    ioctl on socket. Timestamp are then returned in recvmsg calls =
in msg=5Fcontrol
> > +    structure inside msghdr structure.
> > +
> 
> Why do we need a config option? All it adds in the off-case is a sing=
le
> bit test.
> 
> >  config XENO=5FDRIVERS=5FNET=5FETH=5FP=5FALL
> >      depends on XENO=5FDRIVERS=5FNET
> >      bool "Support for ETH=5FP=5FALL"
> > diff --git a/kernel/drivers/net/stack/include/rtnet=5Fsocket.h b/ke=
rnel/drivers/net/stack/include/rtnet=5Fsocket.h
> > index d2caab649..dc488a58a 100644
> > --- a/kernel/drivers/net/stack/include/rtnet=5Fsocket.h
> > +++ b/kernel/drivers/net/stack/include/rtnet=5Fsocket.h
> > @@ -29,6 +29,7 @@
> >  
> >  #include <asm/atomic.h>
> >  #include <linux/list.h>
> > +#include <net/sock.h>
> >  
> >  #include <rtdev.h>
> >  #include <rtdm/net.h>
> > @@ -77,6 +78,12 @@ struct rtsocket {
> >  	} prot;
> >  };
> >  
> > +#ifdef CONFIG=5FXENO=5FDRIVERS=5FNET=5FPACKET=5FTIMESTAMP
> > +#define SOCKET=5FFLAG=5FTIMESTAMP   SOCK=5FRCVTSTAMPNS
> > +int rtnet=5Fput=5Fcmsg(struct rtdm=5Ffd *fd, struct user=5Fmsghdr =
*msg, int level,
> > +					int type, int len, void *data);
> > +#endif
> > +
> >  static inline struct rtdm=5Ffd *rt=5Fsocket=5Ffd(struct rtsocket *=
sock)
> >  {
> >  	return rtdm=5Fprivate=5Fto=5Ffd(sock);
> > diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drive=
rs/net/stack/ipv4/tcp/tcp.c
> > index d8c189c88..c8b21c521 100644
> > --- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
> > +++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
> > @@ -2027,6 +2027,14 @@ static ssize=5Ft rt=5Ftcp=5Fread(struct rtdm=
=5Ffd *fd, void *buf, size=5Ft nbyte)
> >  			kfree=5Frtskb(first=5Fskb); /* or store the data? */
> >  			return -EFAULT;
> >  		}
> > +
> > +#ifdef CONFIG=5FXENO=5FDRIVERS=5FNET=5FPACKET=5FTIMESTAMP
> > +		if (test=5Fbit(SOCKET=5FFLAG=5FTIMESTAMP, &sock->flags))
> > +			rtnet=5Fput=5Fcmsg(fd, msg, SOL=5FSOCKET, SCM=5FTIMESTAMPNS,
> > +					sizeof(nanosecs=5Fabs=5Ft),
> > +					(void *) &skb->time=5Fstamp);
> > +#endif /* CONFIG=5FXENO=5FDRIVERS=5FNET=5FPACKET=5FTIMESTAMP */
> > +
> >  		rtdm=5Flock=5Fget=5Firqsave(&ts->socket=5Flock, context);
> >  		if (ts->sync.window) {
> >  			ts->sync.window +=3D block=5Fsize;
> > diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drive=
rs/net/stack/ipv4/udp/udp.c
> > index 546b35855..ac6448027 100644
> > --- a/kernel/drivers/net/stack/ipv4/udp/udp.c
> > +++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
> > @@ -463,6 +463,13 @@ ssize=5Ft rt=5Fudp=5Frecvmsg(struct rtdm=5Ffd =
*fd, struct user=5Fmsghdr *msg,
> >  	do {
> >  		rtskb=5Ftrim(skb, data=5Flen);
> >  
> > +#ifdef CONFIG=5FXENO=5FDRIVERS=5FNET=5FPACKET=5FTIMESTAMP
> > +		if (test=5Fbit(SOCKET=5FFLAG=5FTIMESTAMP, &sock->flags))
> > +			rtnet=5Fput=5Fcmsg(fd, msg, SOL=5FSOCKET, SCM=5FTIMESTAMPNS,
> > +					sizeof(nanosecs=5Fabs=5Ft),
> > +					(void *) &skb->time=5Fstamp);
> > +#endif /* CONFIG=5FXENO=5FDRIVERS=5FNET=5FPACKET=5FTIMESTAMP */
> > +
> >  		block=5Fsize =3D skb->len;
> >  		copied +=3D block=5Fsize;
> >  		data=5Flen -=3D block=5Fsize;
> > diff --git a/kernel/drivers/net/stack/packet/af=5Fpacket.c b/kernel=
/drivers/net/stack/packet/af=5Fpacket.c
> > index cc7487303..10e8113fe 100644
> > --- a/kernel/drivers/net/stack/packet/af=5Fpacket.c
> > +++ b/kernel/drivers/net/stack/packet/af=5Fpacket.c
> > @@ -364,6 +364,13 @@ static ssize=5Ft rt=5Fpacket=5Frecvmsg(struct =
rtdm=5Ffd *fd, struct user=5Fmsghdr *msg,
> >  	if (rtdm=5Ffd=5Fto=5Fcontext(fd)->device->driver->socket=5Ftype !=
=3D SOCK=5FDGRAM)
> >  		rtskb=5Fpush(rtskb, rtskb->data - rtskb->mac.raw);
> >  
> > +#ifdef CONFIG=5FXENO=5FDRIVERS=5FNET=5FPACKET=5FTIMESTAMP
> > +		if (test=5Fbit(SOCKET=5FFLAG=5FTIMESTAMP, &sock->flags))
> > +			rtnet=5Fput=5Fcmsg(fd, msg, SOL=5FSOCKET, SCM=5FTIMESTAMPNS,
> > +					sizeof(nanosecs=5Fabs=5Ft),
> > +					(void *) &rtskb->time=5Fstamp);
> > +#endif /* CONFIG=5FXENO=5FDRIVERS=5FNET=5FPACKET=5FTIMESTAMP */
> > +
> >  	/* The data must not be longer than the available buffer size */
> >  	copy=5Flen =3D rtskb->len;
> >  	len =3D rtdm=5Fget=5Fiov=5Fflatlen(iov, msg->msg=5Fiovlen);
> > diff --git a/kernel/drivers/net/stack/socket.c b/kernel/drivers/net=
/stack/socket.c
> > index f030663be..5a9702975 100644
> > --- a/kernel/drivers/net/stack/socket.c
> > +++ b/kernel/drivers/net/stack/socket.c
> > @@ -273,6 +273,15 @@ int rt=5Fsocket=5Fif=5Fioctl(struct rtdm=5Ffd =
*fd, int request, void =5F=5Fuser *arg)
> >  		return rtnet=5Fput=5Farg(fd, &u=5Fifc->ifc=5Flen, &size, sizeof(=
size));
> >  	}
> >  
> > +#ifdef CONFIG=5FXENO=5FDRIVERS=5FNET=5FPACKET=5FTIMESTAMP
> > +	if (request =3D=3D SO=5FTIMESTAMPNS) {
> > +		struct rtsocket *sock =3D rtdm=5Ffd=5Fto=5Fprivate(fd);
> > +
> > +		set=5Fbit(SOCKET=5FFLAG=5FTIMESTAMP, &sock->flags);
> > +		return 0;
> > +	}
> > +#endif
> > +
> >  	u=5Fifr =3D arg;
> >  	ifr =3D rtnet=5Fget=5Farg(fd, &=5Fifr, u=5Fifr, sizeof(=5Fifr));
> >  	if (IS=5FERR(ifr))
> > @@ -393,3 +402,53 @@ int rtnet=5Fput=5Farg(struct rtdm=5Ffd *fd, vo=
id *dst, const void *src, size=5Ft len)
> >  	return rtdm=5Fcopy=5Fto=5Fuser(fd, dst, src, len);
> >  }
> >  EXPORT=5FSYMBOL=5FGPL(rtnet=5Fput=5Farg);
> > +
> > +#ifdef CONFIG=5FXENO=5FDRIVERS=5FNET=5FPACKET=5FTIMESTAMP
> > +int rtnet=5Fput=5Fcmsg(struct rtdm=5Ffd *fd, struct user=5Fmsghdr =
*msg, int level,
> > +					int type, int len, void *data)
> > +{
> > +	struct cmsghdr =5F=5Fuser *cm =3D msg->msg=5Fcontrol;
> > +	struct cmsghdr cmhdr;
> > +	int cmlen =3D CMSG=5FLEN(len);
> > +	int err;
> > +
> > +	if (MSG=5FCMSG=5FCOMPAT & msg->msg=5Fflags)
> > +		return 0; /* XXX: return error? check spec. */
> > +
> > +	if ((cm =3D=3D NULL) || (msg->msg=5Fcontrollen < sizeof(*cm))) {
> > +		msg->msg=5Fflags |=3D MSG=5FCTRUNC;
> > +		return 0; /* XXX: return error? check spec. */
> 
> Please resolve the "XXX" cases. The first one indicates that this doe=
s
> not work with 32-bit compat apps.
> 
> > +	}
> > +	if (msg->msg=5Fcontrollen < cmlen) {
> > +		msg->msg=5Fflags |=3D MSG=5FCTRUNC;
> > +		cmlen =3D msg->msg=5Fcontrollen;
> > +	}
> > +	cmhdr.cmsg=5Flevel =3D level;
> > +	cmhdr.cmsg=5Ftype =3D type;
> > +	cmhdr.cmsg=5Flen =3D cmlen;
> > +
> > +	err =3D -EFAULT;
> > +
> > +	if (!rtdm=5Ffd=5Fis=5Fuser(fd)) {
> > +		memcpy(cm, &cmhdr, sizeof(struct cmsghdr));
> > +		memcpy(CMSG=5FDATA(cm), data, cmlen - sizeof(struct cmsghdr));
> > +		err =3D 0;
> 
> This path does not update msg like below.
> 
> > +	} else {
> > +		if (rtdm=5Fcopy=5Fto=5Fuser(fd, cm, &cmhdr, sizeof(struct cmsghd=
r)))
> > +			goto out;
> > +		if (rtdm=5Fcopy=5Fto=5Fuser(fd, CMSG=5FDATA(cm), data,
> > +					cmlen - sizeof(struct cmsghdr)))
> > +			goto out;
> 
> Could also be folded into a "if (... || ...)".
> 
> > +		cmlen =3D CMSG=5FSPACE(len);
> > +		if (msg->msg=5Fcontrollen < cmlen)
> > +			cmlen =3D msg->msg=5Fcontrollen;
> > +		msg->msg=5Fcontrol +=3D cmlen;
> > +		msg->msg=5Fcontrollen -=3D cmlen;
> > +		err =3D 0;
> > +	}
> > +out:
> > +	return err;
> > +}
> > +EXPORT=5FSYMBOL(rtdm=5Fput=5Fcmsg);
> > +
> > +#endif /* CONFIG=5FXENO=5FDRIVERS=5FNET=5FPACKET=5FTIMESTAMP */
> > 
> 
> Jan
> 
> -- 
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux


