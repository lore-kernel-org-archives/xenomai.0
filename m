From: MINIER Bertrand <Bertrand.MINIER@sercel.com>
Date: Tue, 22 Aug 2017 15:22:59 +0000
Message-ID: <de3553b96851471ebed51ecfb4a322eb@NANS01204.it.intra.sercel.com>
Content-Language: fr-FR
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] RTDM driver : driver to driver rtdm_ioctl() call issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi all,

I'am writing a set of two RTDM drivers :  let say driver A and driver B.
Driver B implementation depends on driver A usage.
To serve an ioctl of Driver B, I have to call a driver A ioctl using the "d=
river to driver API":
                err =3D rtdm_ioctl(rt_device->fpga_event_fd, RTFPGAEV_RTIOC=
_STOP_TIMER, &rt_device->fpga_event_timer_idx);

>From the driver A perspective, this ioctl is coded as follow:

static int rtFpgaEv_ioctl(struct rtdm_fd *fd, unsigned int request, void *a=
rg)
{
    struct rt_fpga_event_context *ctx;
    int err =3D 0;

    ctx =3D rtdm_fd_to_private(fd);
    switch (request)
    {

/* .... */

        case RTFPGAEV_RTIOC_STOP_TIMER:
           val =3D *((unsigned int *) arg);
            if(rtdm_fd_is_user(fd))
            {
                err =3D rtdm_safe_copy_from_user(fd, &val, arg, sizeof(unsi=
gned int));
if (err)
return err;
            }
            err =3D rtFpgaEv_dev_stopTimer(ctx->rt_dev, val);
            break;

/* .... */

}
    return err;
}

The rtdm_ioctl() call fails with EPERM errno. This errno come from rtdm_saf=
e_copy_from_user() in the above code.
As long as Driver A is opened from an RTDM driver(coded as a kernel module)=
, I was expecting rtdm_fd_is_user(fd) to return false and so not execute th=
e rtdm_safe_copy_from_user().

Could you tell me where I'm wrong ?

I'am using the following configuration:

-          Xenomai-3.0.3

-          Linux-4.1.18

-          ipipe-core-4.1.18-arm-8.patch

-
Thanks a lot.
Bertrand

This e-mail and any accompanying attachments are confidential. If you are n=
ot the intended recipient, you must not review, disclose, copy, distribute =
or use this e-mail; please delete it from your system and notify the sender=
 immediately.
