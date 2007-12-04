From: "Henk Geraads" <linux@domain.hid>
Date: Tue, 4 Dec 2007 08:03:18 +0100
Message-ID: <NGBBLNEOGLJIIJKLFLPFMEBKDFAA.linux@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] native pipe can not write
Reply-To: linux@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

we are currently using a PXA270 board with kernel 2.6.15 with xenomai =
2.2.2. We are having the same problem. We create a pipe like;
rt_pipe_create(&dti_pipe_wr, "DTI_FROM_UART", FIFO_WR, 1000);

i=3Drt_pipe_write(&dti_pipe_wr, data->dti_rcvbuf, 20, P_NORMAL)

we got error =3D -ENOMEM?

Is this the same error?

> -- Gilles Chanteperdrix wrote :=20
> wrote:
> > Hi,
> > I try to use the message pipe in native API, but I can not write t=
o the
> > pipe. Can anyone help me to find what is wrong?
> > And in Linux side it says:"write failed: Cannot allocate memory"
> > Thank you!
> > Following is the program and return message.
> > #./test_pipe
> > create return: 0, write return: -12, read return: -110
> >=20
> > #include <stdio.h>
> > #include <errno.h>
> > #include <native/task.h>
> > #include <sys/mman.h>
> >=20
> > RT_PIPE pipe_desc;
> > RT_TASK task;
> >=20
> > void op_pipe(void *arg)
> > {
> >         int  err, pipe_fd, wre, rre;
> >         char buf[16] =3D {'a', 'b', 'c'};
> >         char rd;
> >=20
> >         err =3D rt_pipe_create(&pipe_desc, "my_testpipe2", 3, 128);
> >         char tmp[] =3D {"test pipe"};
> >=20
> >         wre =3D rt_pipe_write(&pipe_desc, buf, 2, P_NORMAL);
> >         rre =3D rt_pipe_read(&pipe_desc, &rd, 2, 100);

> I do not know if this is related with your issue, but the receive bu=
ff
> is too small: you want write 2 bytes in a 1 byte buffer.
>
> --=20
>         Gilles Chanteperdrix.

If we create the pipe on the heap, that means at creation time with si=
ze '0' the pipe seems at first to works, but the memory of other proce=
sses (not related) is corrupted and those processes crashes!

Henk Geraads



