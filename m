Date: Wed, 20 Feb 2008 23:58:25 -0500
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200802202358.25792.ngustavson@domain.hid>
From: NZG <metalninjadragon@domain.hid>
Subject: [Xenomai-help] writing from user space through fifo problems
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

I've got 2 programs, one Xenomai user space real time thread and one normal=
=20
user space program.

My normal user space is trying to pass a structure to my real time program =
and=20
failing.

my RT thread reads in a 1ms loop with:
err =3D rt_pipe_read(control_pipe,k,sizeof(control_t),TM_NONBLOCK);

my regular linux program writes a real time fifo with:

int fd =3D open(dev, O_WRONLY|O_SYNC);
err =3D write(fd,&c,sizeof(c));
if(err<=3D0)error(0,-err, "write failed =A0with %d",err);
close(fd);

The user space program succeeds (write returns no error and doesn't block),=
=20
but the RT thread never see's the data, continually returning -EINTR.

Note that if I change the real time thread to TM_INFINITE it works, but blo=
cks=20
for course, which isn't what I want, since I only want to pull out data at=
=20
the beginning of a constant loop.

Is this the correct behavior?=20
Does read have to be set up and waiting for the data to recieve it?

thx,
NZG

