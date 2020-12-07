References: <1174-5fce0b80-71-37e14c00@74919572>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [Patch 3/5] Problems with upstream SPECTRE mitigation found in
 sendmsg/recvmsg  syscalls
In-reply-to: <1174-5fce0b80-71-37e14c00@74919572>
Date: Mon, 07 Dec 2020 15:36:25 +0100
Message-ID: <87eek1vg2e.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?Q?Fran=C3=A7ois?= Legal <francois.legal@thom.fr.eu.org>
Cc: xenomai@xenomai.org


Fran=C3=A7ois Legal via Xenomai <xenomai@xenomai.org> writes:

> From: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
>
> Add rtipc_get_arg (copy_from_ser) call on struct user_msghdr.
>
> Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
> ---
>  kernel/drivers/ipc/bufp.c         | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20=20
> diff --git a/kernel/drivers/ipc/bufp.c b/kernel/drivers/ipc/bufp.c
> index 45c917e..c09524c 100644
> --- a/kernel/drivers/ipc/bufp.c
> +++ b/kernel/drivers/ipc/bufp.c
> @@ -352,12 +352,17 @@ static ssize_t __bufp_recvmsg(struct rtdm_fd *fd,
>  }
>=20=20
>  static ssize_t bufp_recvmsg(struct rtdm_fd *fd,
> -			    struct user_msghdr *msg, int flags)
> +			    struct user_msghdr *u_msg, int flags)
>  {
>  	struct iovec iov_fast[RTDM_IOV_FASTMAX], *iov;
>  	struct sockaddr_ipc saddr;
> +	struct user_msghdr _msg, *msg =3D & _msg;
>  	ssize_t ret;
>=20=20
> +	ret =3D rtipc_get_arg(fd, &_msg, u_msg, sizeof(_msg));
> +	if (ret)
> +		return -ret;

rtipc_get_arg() returns zero on sucess, or negated error codes already
(-EFAULT typically).

> +
>  	if (flags & ~MSG_DONTWAIT)
>  		return -EINVAL;
>=20=20
> @@ -598,14 +603,19 @@ fail:
>  }
>=20=20
>  static ssize_t bufp_sendmsg(struct rtdm_fd *fd,
> -			    const struct user_msghdr *msg, int flags)
> +			    const struct user_msghdr *u_msg, int flags)
>  {
>  	struct rtipc_private *priv =3D rtdm_fd_to_private(fd);
>  	struct iovec iov_fast[RTDM_IOV_FASTMAX], *iov;
>  	struct bufp_socket *sk =3D priv->state;
>  	struct sockaddr_ipc daddr;
> +	struct user_msghdr _msg, *msg =3D & _msg;
>  	ssize_t ret;
>=20=20
> +	ret =3D rtipc_get_arg(fd, &_msg, u_msg, sizeof(_msg));
> +	if (ret)
> +		return -ret;
> +

ditto.

>  	if (flags & ~MSG_DONTWAIT)
>  		return -EINVAL;


--=20
Philippe.

