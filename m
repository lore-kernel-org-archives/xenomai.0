Message-ID: <b647ffbd0703011227p183c5843pc50d51815b2f0dde@domain.hid>
Date: Thu, 1 Mar 2007 21:27:40 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] warnings and tangled threads.
In-Reply-To: <bc4264770703011151r41b38f80m4e1dd3288ba08053@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770702271525q6d5d164lfa34b421a64eeb70@domain.hid>
	<45E5357B.4090107@domain.hid> <45E53FF0.7050200@domain.hid>
	<45E58964.5040304@domain.hid>
	<bc4264770703011151r41b38f80m4e1dd3288ba08053@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 01/03/07, roland Tollenaar <rolandtollenaar@domain.hid> wrote:
> Hi,
>
> My hardware has arrived. Well some of it, the rest should be coming
> tomorrow. So will be testing the CAN functionality for real if I
> finally get some time to work on this project other than at night. :(
>
> In the mean time I still wanted to squeeze in applying the patch
> below. However it fails, says something like
>
> Hunk1 failed at line 295
> Hunk2 succeeded.......
>
> 1 out of 2 failed.

This likely indicates that your "target" file (the one to be patched)
and the one Jan used to generate this patch are of different versions
(different revisions). There must have been created a file with .rej
extension - in your case include/rtdm/rtdm.h.rej which contains a part
of the patch that has failed to apply.

Anyway, you can fix it manually. It doesn't require any knowledge of
quantum mechanics, really.

e.g.

> > > --- include/rtdm/rtdm.h (Revision 2265)
> > > +++ include/rtdm/rtdm.h (Arbeitskopie)

the file to be patched is include/rtdm/rtdm.h

> > > @@ -295,13 +295,22 @@ static inline ssize_t rt_dev_recvfrom(in
> > >                                        struct sockaddr *from,
> > >                                        socklen_t *fromlen)
> > >  {

The changes to be applied to rt_dev_recvfrom() (so search for this
function, presumably line 295 but can be different as e.g. patch
failed)

> > > -    struct iovec    iov = {buf, len};
> > > -    struct msghdr   msg =
> > > -        {from, (from != NULL) ? *fromlen : 0, &iov, 1, NULL, 0};
> > > -    int             ret;
> > > +    struct iovec iov = {
> > > +        .iov_base = buf,
> > > +        .iov_len = len
> > > +    };
> > > +    struct msghdr msg = {
> > > ...

In this function look for the line marked with '-' and replace them
with the ones marked with '+'. That's it.


-- 
Best regards,
Dmitry Adamushko

