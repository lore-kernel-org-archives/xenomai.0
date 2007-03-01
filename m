Message-ID: <bc4264770703011151r41b38f80m4e1dd3288ba08053@domain.hid>
Date: Thu, 1 Mar 2007 19:51:10 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] warnings and tangled threads.
In-Reply-To: <45E58964.5040304@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770702271525q6d5d164lfa34b421a64eeb70@domain.hid>
	<45E5357B.4090107@domain.hid> <45E53FF0.7050200@domain.hid>
	<45E58964.5040304@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hi,

My hardware has arrived. Well some of it, the rest should be coming
tomorrow. So will be testing the CAN functionality for real if I
finally get some time to work on this project other than at night. :(

In the mean time I still wanted to squeeze in applying the patch
below. However it fails, says something like

Hunk1 failed at line 295
Hunk2 succeeded.......

1 out of 2 failed.

This is what I did:
Put your patch in a file rtdmpatch in the root of the install (not the
source) directory. Then ran
patch -p0 < rtdmpatch.

What am I doing wrong? Running it in the root of the source directory
won't make a difference will it?


Regards,

Roland.



> > This works for me here (and is a bit more telling as well):
> >
> > --- include/rtdm/rtdm.h (Revision 2265)
> > +++ include/rtdm/rtdm.h (Arbeitskopie)
> > @@ -295,13 +295,22 @@ static inline ssize_t rt_dev_recvfrom(in
> >                                        struct sockaddr *from,
> >                                        socklen_t *fromlen)
> >  {
> > -    struct iovec    iov = {buf, len};
> > -    struct msghdr   msg =
> > -        {from, (from != NULL) ? *fromlen : 0, &iov, 1, NULL, 0};
> > -    int             ret;
> > +    struct iovec iov = {
> > +        .iov_base = buf,
> > +        .iov_len = len
> > +    };
> > +    struct msghdr msg =
>                           ^^^
> Insert "{", or the kernel build breaks. :(
>
> > +        .msg_name = from,
> > +        .msg_namelen = from ? *fromlen : 0,
> > +        .msg_iov = &iov,
> > +        .msg_iovlen = 1,
> > +        .msg_control = NULL,
> > +        .msg_controllen = 0
> > +    };
> > +    int ret;
> >
> >      ret = rt_dev_recvmsg(fd, &msg, flags);
> > -    if ((ret >= 0) && (from != NULL))
> > +    if (ret >= 0 && from)
> >          *fromlen = msg.msg_namelen;
> >      return ret;
> >  }
> > @@ -345,9 +354,18 @@ static inline ssize_t rt_dev_sendto(int
> >                                      int flags, const struct sockaddr *to,
> >                                      socklen_t tolen)
> >  {
> > -    struct iovec    iov = {(void *)buf, len};
> > -    struct msghdr   msg =
> > -        {(struct sockaddr *)to, tolen, &iov, 1, NULL, 0};
> > +    struct iovec iov = {
> > +        .iov_base = (void *)buf,
> > +        .iov_len = len
> > +    };
> > +    struct msghdr msg = {
> > +        .msg_name = (struct sockaddr *)to,
> > +        .msg_namelen = tolen,
> > +        .msg_iov = &iov,
> > +        .msg_iovlen = 1,
> > +        .msg_control = NULL,
> > +        .msg_controllen = 0
> > +    };
> >
> >      return rt_dev_sendmsg(fd, &msg, flags);
> >  }
> >
> >
> > Can you confirm it?
> >
> > Jan
> >
> >
> >
> > ------------------------------------------------------------------------
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
>
>
>
>

