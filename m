From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <87eek1vg2e.fsf@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Date: Mon, 07 Dec 2020 16:40:44 +0100
MIME-Version: 1.0
Message-ID: <1174-5fce4d00-7d-37e14c00@74953892>
Subject: =?utf-8?q?Re=3A?==?utf-8?q?_=5BPatch?==?utf-8?q?_3=2F5=5D?= Problems
 with 
 upstream SPECTRE mitigation found in =?utf-8?q?sendmsg=2Frecvmsg?=  
 syscalls
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Le Lundi, D=C3=A9cembre 07, 2020 15:36 CET, Philippe Gerum <rpm@xenomai=
.org> a =C3=A9crit: 
 
> 
> Fran=C3=A7ois Legal via Xenomai <xenomai@xenomai.org> writes:
> 
> > From: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
> >
> > Add rtipc=5Fget=5Farg (copy=5Ffrom=5Fser) call on struct user=5Fmsg=
hdr.
> >
> > Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
> > ---
> >  kernel/drivers/ipc/bufp.c         | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >  
> > diff --git a/kernel/drivers/ipc/bufp.c b/kernel/drivers/ipc/bufp.c
> > index 45c917e..c09524c 100644
> > --- a/kernel/drivers/ipc/bufp.c
> > +++ b/kernel/drivers/ipc/bufp.c
> > @@ -352,12 +352,17 @@ static ssize=5Ft =5F=5Fbufp=5Frecvmsg(struct =
rtdm=5Ffd *fd,
> >  }
> >  
> >  static ssize=5Ft bufp=5Frecvmsg(struct rtdm=5Ffd *fd,
> > -			    struct user=5Fmsghdr *msg, int flags)
> > +			    struct user=5Fmsghdr *u=5Fmsg, int flags)
> >  {
> >  	struct iovec iov=5Ffast[RTDM=5FIOV=5FFASTMAX], *iov;
> >  	struct sockaddr=5Fipc saddr;
> > +	struct user=5Fmsghdr =5Fmsg, *msg =3D & =5Fmsg;
> >  	ssize=5Ft ret;
> >  
> > +	ret =3D rtipc=5Fget=5Farg(fd, &=5Fmsg, u=5Fmsg, sizeof(=5Fmsg));
> > +	if (ret)
> > +		return -ret;
> 
> rtipc=5Fget=5Farg() returns zero on sucess, or negated error codes al=
ready
> (-EFAULT typically).
> 

Correct. I missed this one. Thanks.

> > +
> >  	if (flags & ~MSG=5FDONTWAIT)
> >  		return -EINVAL;
> >  
> > @@ -598,14 +603,19 @@ fail:
> >  }
> >  
> >  static ssize=5Ft bufp=5Fsendmsg(struct rtdm=5Ffd *fd,
> > -			    const struct user=5Fmsghdr *msg, int flags)
> > +			    const struct user=5Fmsghdr *u=5Fmsg, int flags)
> >  {
> >  	struct rtipc=5Fprivate *priv =3D rtdm=5Ffd=5Fto=5Fprivate(fd);
> >  	struct iovec iov=5Ffast[RTDM=5FIOV=5FFASTMAX], *iov;
> >  	struct bufp=5Fsocket *sk =3D priv->state;
> >  	struct sockaddr=5Fipc daddr;
> > +	struct user=5Fmsghdr =5Fmsg, *msg =3D & =5Fmsg;
> >  	ssize=5Ft ret;
> >  
> > +	ret =3D rtipc=5Fget=5Farg(fd, &=5Fmsg, u=5Fmsg, sizeof(=5Fmsg));
> > +	if (ret)
> > +		return -ret;
> > +
> 
> ditto.
> 
> >  	if (flags & ~MSG=5FDONTWAIT)
> >  		return -EINVAL;
> 
> 
> -- 
> Philippe.


