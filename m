Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Stefan Schaal <sschaal@domain.hid>
In-Reply-To: <4B7DC07C.5@domain.hid>
Date: Thu, 18 Feb 2010 21:43:04 -0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <6D7DAD32-5300-47EB-9A04-ECA065395014@domain.hid>
References: <0C632A1C-3B64-462B-9892-380CB14F6AD8@domain.hid> <4B7DC07C.5@domain.hid>
Subject: Re: [Xenomai-core] Analogy DIO speed
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: Peter Pastor Sampedro <pastorsa@domain.hid>, xenomai@xenomai.org

Hi Alexis,

On Feb 18, 2010, at 14:34, Alexis Berlemont wrote:

> I have some problems with
>> implementing commands on my NI6259 so far.
> Could you remind me what was the problem ?

See the print-outs below for the problem we have.

Thanks so much for looking into this!

-Stefan




Using the cmd_write() function that you provide in analogy, we get the =
following problem:

root@domain.hid# ./cmd_write -v
cmd_write: device analogy0 opened (fd=3D0)
cmd_write: basic descriptor retrieved
	 subdevices count =3D 14
	 read subdevice index =3D 0
	 write subdevice index =3D 1
cmd_write: complex descriptor retrieved
cmd_write: channel 0
	 ranges count =3D 3
	 range's size =3D 16 (bits)
cmd_write: channel 1
	 ranges count =3D 3
	 range's size =3D 16 (bits)
cmd_write: scan size =3D 4
cmd_write: size to write  =3D 400
cmd_write: command successfully sent
cmd_write: triggering failed (ret=3D-32)

root@domain.hid# dmesg -c
[133345.213865] Analogy: analogy_ni_pcimio: ni_mio_common: interrupt: =
b_status=3D0002 m1_status=3D80a80000
[133345.332719] Analogy: analogy_ni_pcimio: ni_ao_wait_for_dma_load: =
timed out waiting for dma load<3>Analogy: a4l_do_special_insn: execution =
of the instruction failed (err=3D-32)


Another problem we have is with the --mmap option:

root@domain.hid# ./cmd_write -v --mmap
cmd_write: device analogy0 opened (fd=3D0)
cmd_write: basic descriptor retrieved
	 subdevices count =3D 14
	 read subdevice index =3D 0
	 write subdevice index =3D 1
cmd_write: complex descriptor retrieved
cmd_write: channel 0
	 ranges count =3D 3
	 range's size =3D 16 (bits)
cmd_write: channel 1
	 ranges count =3D 3
	 range's size =3D 16 (bits)
cmd_write: scan size =3D 4
cmd_write: size to write  =3D 400
cmd_write: buffer size =3D 65536 bytes
cmd_write: a4l_mmap() failed (ret=3D-22)


root@domain.hid# dmesg -c
[133408.942998] Analogy: a4l_ioctl_mmap: mmap not allowed on this =
subdevice


