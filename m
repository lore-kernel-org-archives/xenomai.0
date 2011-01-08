Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1082)
From: Stefan Schaal <sschaal@domain.hid>
Date: Fri, 7 Jan 2011 16:10:56 -0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <5BF14D57-91E2-4365-9965-FDBC8806F754@domain.hid>
Subject: [Xenomai-core] CMD based acquisition with Analogy
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <alexis.berlemont@domain.hid>
Cc: Peter Pastor Sampedro <pastorsa@domain.hid>, xenomai@xenomai.org

Hi Alexis,

  here is an observation with CMD-based acquisition that puzzles me. =
Just to recall, we use an NI6259 board, using your latest analogy branch =
of xenomai on a 2.6.29.5 kernel in Ubuntu 9.10. Our computer is a 32bit =
Dell Precision with 8 core Xeon processors.

 A normal CMD based acquisition with internal trigger has the core =
elements as listed below. What puzzles me that it appears from my tests =
that the triggering of the acquisition with "a4l_snd_insn(&desc, &insn)" =
seems to take about 200-300 us to complete. This is a very long time for =
us, as we need to start and stop a CMD based acquisition multiple times =
in our code.

Thus, my question is simply whether this long latency is normal from =
your experience? I used other a4l_snd_insn commands for INSN based data =
acquisition before (and I believe your "sync" data acquisition uses =
INSN, too), but always had 3-5us duration for these commands.

Best wishes,

-Stefan

=
//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

// fill out data structures
  a4l_cmd_t cmd =3D {
    .idx_subd =3D ID_SUBDEV_DIGITAL,
    .flags =3D 0,
    .start_src =3D TRIG_INT,    // internal trigger
    .start_arg =3D 0,
    .scan_begin_src =3D TRIG_EXT,  =20
    .scan_begin_arg =3D NI_CDIO_SCAN_BEGIN_SRC_G0_OUT, // channel used =
to trigger the scans
    .convert_src =3D TRIG_NOW,
    .convert_arg =3D 0, /* in ns */
    .scan_end_src =3D TRIG_COUNT,
    .scan_end_arg =3D 32,
    .stop_src =3D TRIG_NONE,
    .stop_arg =3D 0,
    .nb_chan =3D 32,
    .chan_descs =3D chans,
  };

  a4l_insn_t insn =3D {
    .type =3D A4L_INSN_INTTRIG,
    .idx_subd =3D ID_SUBDEV_DIGITAL,
    .data_size =3D 0,
  };

// send command
 rc =3D a4l_snd_command(&desc, &cmd);
if (rc < 0)=20
    printf("ni_test: a4l_snd_command failed (ret=3D%d)\n", rc);
 }

// add some date to FIFO buffer=20
....

// trigger acquisition
rc =3D a4l_snd_insn(&desc, &insn);
if (rc < 0)
    printf("ni_test: triggering failed (rc=3D%d)\n",rc);

=
//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

