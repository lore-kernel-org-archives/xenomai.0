MIME-Version: 1.0
Message-ID: <trinity-cf21e230-c7a4-49a1-8563-6b48a68f3ca5-1559406783362@msvc-mesg-gmx021>
From: "Sebastian Smolorz" <Sebastian.Smolorz@gmx.de>
Subject: Re: [PATCH] net/tcp: fix unsafe accesses from/to userspace
Content-Type: text/plain; charset=UTF-8
Date: Sat, 1 Jun 2019 18:33:03 +0200
In-Reply-To: <59043d19-808d-0498-3768-1719ed060e62@siemens.com>
References: <20190528140544.4578-1-sebastian.smolorz@gmx.de>
 <59043d19-808d-0498-3768-1719ed060e62@siemens.com>
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

Hi Jan,

On 29.05.19 19:17, Jan Kiszka wrote:
> On 28.05.19 16:05, Sebastian Smolorz wrote:
> > Signed-off-by: Sebastian Smolorz <sebastian.smolorz@gmx.de>
> > ---
> >   kernel/drivers/net/stack/ipv4/tcp/tcp.c | 91 ++++++++++++++++-------=
--
> >   1 file changed, 60 insertions(+), 31 deletions(-)
> >
> > diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drivers/=
net/stack/ipv4/tcp/tcp.c
> > index 828f7d115..4803165f4 100644
> > --- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
> > +++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
> > @@ -1418,15 +1418,18 @@ static void rt_tcp_close(struct rtdm_fd *fd)
> >    *  @s:     socket
> >    *  @addr:  local address
> >    */
> > -static int rt_tcp_bind(struct tcp_socket *ts, const struct sockaddr *=
addr,
> > -		       socklen_t addrlen)
> > +static int rt_tcp_bind(struct rtdm_fd *fd, struct tcp_socket *ts,
> > +		       const struct sockaddr __user *addr, socklen_t addrlen)
> >   {
> > -    struct sockaddr_in  *usin =3D (struct sockaddr_in *)addr;
> > +    struct sockaddr_in  *usin, _usin;
> >       rtdm_lockctx_t      context;
> >       int                 index;
> >       int                 bound =3D 0;
> >       int                 ret =3D 0;
> >
> > +    usin =3D rtnet_get_arg(fd, &_usin, addr, sizeof(_usin));
> > +    if (IS_ERR(usin))
> > +	return PTR_ERR(usin);
> >
> >       if ((addrlen < (int)sizeof(struct sockaddr_in)) ||
> >   	((usin->sin_port & tcp_auto_port_mask) =3D=3D tcp_auto_port_start))
> > @@ -1475,10 +1478,11 @@ static int rt_tcp_bind(struct tcp_socket *ts, =
const struct sockaddr *addr,
> >   /***
> >    *  rt_tcp_connect
> >    */
> > -static int rt_tcp_connect(struct tcp_socket *ts, const struct sockadd=
r *serv_addr,
> > +static int rt_tcp_connect(struct rtdm_fd *fd, struct tcp_socket *ts,
> > +			  const struct sockaddr __user *serv_addr,
> >   			  socklen_t addrlen)
> >   {
> > -    struct sockaddr_in  *usin =3D (struct sockaddr_in *) serv_addr;
> > +    struct sockaddr_in  *usin, _usin;
> >       struct dest_route   rt;
> >       rtdm_lockctx_t      context;
> >       int ret;
> > @@ -1486,6 +1490,10 @@ static int rt_tcp_connect(struct tcp_socket *ts=
, const struct sockaddr *serv_add
> >       if (addrlen < (int)sizeof(struct sockaddr_in))
> >   	return -EINVAL;
> >
> > +    usin =3D rtnet_get_arg(fd, &_usin, serv_addr, sizeof(_usin));
> > +    if (IS_ERR(usin))
> > +	return PTR_ERR(usin);
> > +
> >       if (usin->sin_family !=3D AF_INET)
> >   	return -EAFNOSUPPORT;
> >
> > @@ -1594,18 +1602,23 @@ static int rt_tcp_listen(struct tcp_socket *ts=
, unsigned long backlog)
> >   /***
> >    *  rt_tcp_accept
> >    */
> > -static int rt_tcp_accept(struct tcp_socket *ts, struct sockaddr *addr=
,
> > -			 socklen_t *addrlen)
> > +static int rt_tcp_accept(struct rtdm_fd *fd, struct tcp_socket *ts,
> > +			 struct sockaddr *addr, socklen_t __user *addrlen)
> >   {
> >       /* Return sockaddr, but bind it with rt_socket_init, so it would=
 be
> >          possible to read/write from it in future, return valid file d=
escriptor */
> >
> >       int ret;
> > -    struct sockaddr_in  *sin =3D (struct sockaddr_in*)addr;
> > +    socklen_t           *uaddrlen, _uaddrlen;
> > +    struct sockaddr_in  sin;
> >       nanosecs_rel_t      timeout =3D ts->sock.timeout;
> >       rtdm_lockctx_t      context;
> >       struct dest_route   rt;
> >
> > +    uaddrlen =3D rtnet_get_arg(fd, &_uaddrlen, addrlen, sizeof(_uaddr=
len));
> > +    if (IS_ERR(uaddrlen))
> > +	return PTR_ERR(uaddrlen);
> > +
> >       rtdm_lock_get_irqsave(&ts->socket_lock, context);
> >       if (ts->is_accepting || ts->is_accepted) {
> >   	/* socket is already accepted or is accepting a connection right no=
w */
> > @@ -1613,7 +1626,7 @@ static int rt_tcp_accept(struct tcp_socket *ts, =
struct sockaddr *addr,
> >   	return -EALREADY;
> >       }
> >
> > -    if (ts->tcp_state !=3D TCP_LISTEN || *addrlen < sizeof(struct soc=
kaddr_in)) {
> > +    if (ts->tcp_state !=3D TCP_LISTEN || *uaddrlen < sizeof(struct so=
ckaddr_in)) {
> >   	rtdm_lock_put_irqrestore(&ts->socket_lock, context);
> >   	return -EINVAL;
> >       }
> > @@ -1652,15 +1665,24 @@ static int rt_tcp_accept(struct tcp_socket *ts=
, struct sockaddr *addr,
> >   	goto err;
> >       }
> >
> > +    if (addr) {
> > +	sin.sin_family      =3D AF_INET;
> > +	sin.sin_port        =3D ts->dport;
> > +	sin.sin_addr.s_addr =3D ts->daddr;
> > +	ret =3D rtnet_put_arg(fd, addr, &sin, sizeof(sin));
> > +	if (ret) {
> > +	    rtdm_lock_put_irqrestore(&ts->socket_lock, context);
>
> Hmm, this makes it clearer now that we are accessing userspace memory wh=
ile
> holding an irqsafe lock - is that needed? It's definitely not "nice".

Agreed, I could move out the call to rtnet_put_arg().

>
> > +	    rtdev_dereference(rt.rtdev);
> > +	    ret =3D -EFAULT;
> > +	    goto err;
> > +	}
> > +    }
> > +
> >       if (ts->rt.rtdev =3D=3D NULL)
> >   	memcpy(&ts->rt, &rt, sizeof(rt));
> >       else
> >   	rtdev_dereference(rt.rtdev);
> >
> > -    sin->sin_family      =3D AF_INET;
> > -    sin->sin_port        =3D ts->dport;
> > -    sin->sin_addr.s_addr =3D ts->daddr;
> > -
> >       ts->is_accepted =3D 1;
> >       rtdm_lock_put_irqrestore(&ts->socket_lock, context);
> >
> > @@ -1799,14 +1821,14 @@ static int rt_tcp_ioctl(struct rtdm_fd *fd,
> >   		setaddr =3D rtnet_get_arg(fd, &_setaddr, arg, sizeof(_setaddr));
> >   		if (IS_ERR(setaddr))
> >   			return PTR_ERR(setaddr);
> > -		return rt_tcp_bind(ts, setaddr->addr, setaddr->addrlen);
> > +		return rt_tcp_bind(fd, ts, setaddr->addr, setaddr->addrlen);
> >   	case _RTIOC_CONNECT:
> >   		if (!in_rt)
> >   			return -ENOSYS;
> >   		setaddr =3D rtnet_get_arg(fd, &_setaddr, arg, sizeof(_setaddr));
> >   		if (IS_ERR(setaddr))
> >   			return PTR_ERR(setaddr);
> > -		return rt_tcp_connect(ts, setaddr->addr, setaddr->addrlen);
> > +		return rt_tcp_connect(fd, ts, setaddr->addr, setaddr->addrlen);
> >
> >   	case _RTIOC_LISTEN:
> >   		return rt_tcp_listen(ts, (unsigned long)arg);
> > @@ -1817,7 +1839,7 @@ static int rt_tcp_ioctl(struct rtdm_fd *fd,
> >   		getaddr =3D rtnet_get_arg(fd, &_getaddr, arg, sizeof(_getaddr));
> >   		if (IS_ERR(getaddr))
> >   			return PTR_ERR(getaddr);
> > -		return rt_tcp_accept(ts, getaddr->addr, getaddr->addrlen);
> > +		return rt_tcp_accept(fd, ts, getaddr->addr, getaddr->addrlen);
> >
> >   	case _RTIOC_SHUTDOWN:
> >   		return rt_tcp_shutdown(ts, (unsigned long)arg);
> > @@ -1994,13 +2016,15 @@ static ssize_t rt_tcp_read(struct rtdm_fd *fd,=
 void *buf, size_t nbyte)
> >   /***
> >    *  rt_tcp_write
> >    */
> > -static ssize_t rt_tcp_write(struct rtdm_fd *fd, const void *buf, size=
_t nbyte)
> > +static ssize_t rt_tcp_write(struct rtdm_fd *fd, const void __user *us=
er_buf,
> > +			    size_t nbyte)
> >   {
> >       struct tcp_socket *ts =3D rtdm_fd_to_private(fd);
> >       uint32_t sent_len =3D 0;
> >       rtdm_lockctx_t      context;
> >       int ret =3D 0;
> >       nanosecs_rel_t sk_sndtimeo;
> > +    void *buf;
> >
> >       if (!rtdm_fd_is_user(fd)) {
> >   	return -EFAULT;
> > @@ -2022,6 +2046,16 @@ static ssize_t rt_tcp_write(struct rtdm_fd *fd,=
 const void *buf, size_t nbyte)
> >
> >       rtdm_lock_put_irqrestore(&ts->socket_lock, context);
> >
> > +    buf =3D xnmalloc(nbyte);
>
> Unrelated to this change, but seeing these multiple copies and the mallo=
c hurts...

Yeah, this could be optimized. Stuff for another patch.

>
> > +    if (buf =3D=3D NULL)
> > +	return -ENOMEM;
> > +
> > +    ret =3D rtdm_copy_from_user(fd, buf, user_buf, nbyte);
> > +    if (ret) {
> > +	xnfree(buf);
> > +	return ret;
> > +    }
> > +
> >       while (sent_len < nbyte) {
> >
> >   	ret =3D rtdm_event_timedwait(&ts->send_evt, sk_sndtimeo, NULL);
> > @@ -2031,13 +2065,17 @@ static ssize_t rt_tcp_write(struct rtdm_fd *fd=
, const void *buf, size_t nbyte)
> >   		case -EWOULDBLOCK:
> >   		case -ETIMEDOUT:
> >   		case -EINTR:
> > +		    xnfree(buf);
> >   		    return sent_len ? : ret;
> >
> >   		case -EIDRM: /* event is destroyed */
> >   		default:
> > -		    if (ts->is_closed)
> > +		    if (ts->is_closed) {
> > +			xnfree(buf);
> >   			return -EBADF;
> > +		    }
> >
> > +		    xnfree(buf);
> >   		    return sent_len ? : ret;
> >   	    }
> >
> > @@ -2054,6 +2092,7 @@ static ssize_t rt_tcp_write(struct rtdm_fd *fd, =
const void *buf, size_t nbyte)
> >   	    rtdm_event_signal(&ts->send_evt);
> >       }
> >
> > +    xnfree(buf);
> >       return (ret < 0 ? ret : sent_len);
> >   }
> >
> > @@ -2104,7 +2143,6 @@ static ssize_t rt_tcp_sendmsg(struct rtdm_fd *fd=
,
> >   	struct user_msghdr _msg;
> >   	ssize_t ret;
> >   	size_t len;
> > -	void *buf;
> >
> >   	if (msg_flags)
> >   		return -EOPNOTSUPP;
> > @@ -2122,18 +2160,9 @@ static ssize_t rt_tcp_sendmsg(struct rtdm_fd *f=
d,
> >   		return ret;
> >
> >   	len =3D iov[0].iov_len;
> > -	if (len > 0) {
> > -		buf =3D xnmalloc(len);
> > -		if (buf =3D=3D NULL) {
> > -			ret =3D -ENOMEM;
> > -			goto out;
> > -		}
> > -		ret =3D rtdm_copy_from_user(fd, buf, iov[0].iov_base, len);
> > -		if (!ret)
> > -			ret =3D rt_tcp_write(fd, buf, len);
> > -		xnfree(buf);
> > -	}
> > -out:
> > +	if (len > 0)
> > +	    ret =3D rt_tcp_write(fd, iov[0].iov_base, len);
> > +
> >   	rtdm_drop_iovec(iov, iov_fast);
> >
> >   	return ret;
> > --
> > 2.19.1
> >
>
> Looks good, except for my question regarding the locking.

Will prepare a v2 patch with your locking remark fixed.

Sebastian


