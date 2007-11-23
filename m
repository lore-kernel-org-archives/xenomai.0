Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Nov 2007 13:37:09 +0100
Message-ID: <0456E5B751F6DB4A83688EED49C9CAF705731F4E@CHNIS191.bystronic.metal.firm>
References: <0456E5B751F6DB4A83688EED49C9CAF705731F4D@CHNIS191.bystronic.metal.firm>
	<2ff1a98a0711230153l6300983cg1e8a98b53676ae0d@domain.hid>
	<2ff1a98a0711230155w4dee347ct9257337474a004e2@domain.hid>
From: "Lauener Nathan" <Nathan.Lauener@domain.hid>
Subject: Re: [Xenomai-help] RTDM and user space task synchronisation problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Thanks Gilles, it works fine now.

Nathan

-----Urspr=FCngliche Nachricht-----
Von: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Gesendet: Freitag, 23. November 2007 10:56
An: Lauener Nathan
Cc: xenomai@xenomai.org
Betreff: Re: [Xenomai-help] RTDM and user space task synchronisation =
problem

On Nov 23, 2007 10:53 AM, Gilles Chanteperdrix =
<gilles.chanteperdrix@xenomai.org> wrote:
> On Nov 23, 2007 9:57 AM, Lauener Nathan <Nathan.Lauener@domain.hid> =
wrote:
> >
> >
> >
> > Hi,
> >
> > we have ported a largely POSIX based QNX application to Linux. It is =

> > a machine control application with hard real time requirements. We=20
> > use the POSIX-skin of Xenomai and so far the user space tasks seem =
to run well.
> > Calling pthread_set_mode_np(0,PTHREAD_PRIMARY) returns with no =
error.
> >
> > But we are having some problems with the RTDM based driver. Our=20
> > interrupt handler should wake up a user task after finishing its=20
> > work. The IOCTL-function invoked by the user calls rtdm_event_wait() =

> > and the interrupt handler invokes rtdm_event_pulse(). At first we=20
> > had page faults and the kernel printed the following message before=20
> > rebooting
> >
> > BUG: unable to handle kernel paging request<0>------------[ cut here
> > ]------------
> >
> > The variable of type rtdm_event_t is initialised in the init=20
> > function of the module. The documentation for rtdm_event_wait()=20
> > states that it can only be called from a realtime environment.=20
> > Checking for this condition with
> > rtdm_in_rt_context() in the IOCTL-function revealed that the=20
> > function is called in non realtime context. Without calling=20
> > rtdm_event_wait() when in the non realtime environment we don't have =

> > any page faults any more (and no synchronisation). To my=20
> > understanding the IOCTL function should be executed in the context=20
> > of the caller. Any suggestions to what I am missing? Linux kernel =
version is 2.6.23.1 and the Xenomai version used is 2.3.94.
>
> You register by_ioctl as a handler for both real-time and non=20
> real-time ioctl handler, so RTDM assumes that by_ioctl may be called=20
> from non real-time context. If you want an ioctl to be handled=20
> exclusively in real-time context, while a handler is registered for=20
> non real-time ioctls, you should return -ENOSYS for this ioctl in the=20
> non real-time handler.
>
> I am not sure this explanation is clear, so here comes an example

Sorry, hit the send button before finishing the mail

int by_rt_ioctl(struct rtdm_dev_context *context, rtdm_user_info_t * =
user_info,
     unsigned int request, void *arg)
{
 ...
 case BY_IOC_GET_EVENT:
       rtdm_event_wait(&event);
...
 }

int by_nrt_ioctl(struct rtdm_dev_context *context, rtdm_user_info_t * =
user_info,
     unsigned int request, void *arg)
{
 ...
 case BY_IOC_GET_EVENT:
        return -ENOSYS;
...
 }

static struct rtdm_device device =3D {
  ...
    ops: {
        close_rt:       by_release,
        close_nrt:      by_release,

        ioctl_rt:       by_rt_ioctl,
        ioctl_nrt:      by_nrt_ioctl,
    },
  ...
};

--=20
                                               Gilles Chanteperdrix

