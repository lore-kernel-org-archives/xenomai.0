Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: multipart/mixed; boundary=Apple-Mail-162-683079189
From: Stefan Schaal <sschaal@domain.hid>
In-Reply-To: <20100624224259.GA2800@domain.hid>
Date: Fri, 25 Jun 2010 11:28:26 -0700
Message-Id: <7FB1B9EA-EB7E-45A2-9C1F-D97916381AF3@domain.hid>
References: <9FDCB500-CFA2-42CC-A7CB-EDFD66AF366C@usc.edu>
	<20100605211102.GB8097@domain.hid>
	<20100624224259.GA2800@domain.hid>
Subject: Re: [Xenomai-core] analogy - experimental branch
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <alexis.berlemont@domain.hid>
Cc: Peter Pastor Sampedro <pastorsa@domain.hid>, xenomai@xenomai.org


--Apple-Mail-162-683079189
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Alexis,

  thanks so much for the new analogy software. Here are some first =
observations:

1) cmd_bits.c works fine on our NI6250 board

2) however, a slightly modified version hangs -- I appended my =
cmd_bits.c to this email. All what I added is a for loop around the =
a4l_async_write() and a4l_snd_insn() commands, i.e., I wanted to trigger =
a write repeatedly. Look for the "sschaal" comment in my modified =
cmd_bits.c .  After 32 iterations, cmd_bits hangs, no error messages in =
dmesg. Interesting, when I change your "trigger_threshold" variable from =
128 to 256, my loop runs for 16 iterations (other changes of the trigger =
threshold adjust the number of iterations I get in a similar way). Thus, =
it feels like there is a buffer which does not get reset after =
a4l_snd_insn() is called -- does this make sense?

Best wishes,

-Stefan


On Jun 24, 2010, at 15:43, Alexis Berlemont wrote:

> Hi,
>=20
> Alexis Berlemont wrote:
>> Hi Stefan,
>>=20
>> Stefan Schaal wrote:
>>> Hi Alexis,
>>>=20
>>>  I was just wondering whether the new "experimental" branch in your =
git repository is something that can be tried already.
>>>=20
>>=20
>> No. Not yet. This branch is aimed at temporarily holding the
>> corrections I am trying to do for the cmd_bits issue. It needs quite =
a
>> lot of work and I have not finished yet.=20
>>=20
>> If you have a look at the commits in this branch, we will see many
>> "(broken)".
>>=20
>=20
> I just rebased the experimental branch into the branch analogy. So,
> starting from now, we should be able to properly use cmd_bits with a
> clone of my git repository.
>=20
> After having reworked the asynchronous buffer subsystem (and having
> fixed some oops in the NI driver and in the new code), cmd_bits can
> correctly communicate with the DIO subdevice.=20
>=20
> A command like "./cmd_bits 0xffff 0xffff" works on my
> board. Unfortunately, I have not done the necessary to check the
> digital output lines yet.
>=20
>=20
>>> Best wishes,
>>>=20
>>> -Stefan
>>=20
>> --=20
>> Alexis.
>=20
> --=20
> Alexis.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D cmd_bits.c =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=


--Apple-Mail-162-683079189
Content-Disposition: attachment;
	filename=cmd_bits.c
Content-Type: application/octet-stream;
	name="cmd_bits.c"
Content-Transfer-Encoding: 7bit


/**
 * @file
 * Analogy for Linux, digital command test program
 *
 * @note Copyright (C) 1997-2000 David A. Schleef <ds@domain.hid>
 * @note Copyright (C) 2008 Alexis Berlemont <alexis.berlemont@domain.hid>
 *
 * Xenomai is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * Xenomai is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Xenomai; if not, write to the Free Software Foundation,
 * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <errno.h>
#include <getopt.h>

#include <analogy/analogy.h>

#define FILENAME "analogy0"

static char *filename = FILENAME;
static int verbose;

/* TODO: to be removed */
static unsigned int chans[4] = {0, 1, 2, 3};

/* The command to send by default */
a4l_cmd_t cmd = {
	.idx_subd = -1,
	.flags = 0,
	.start_src = TRIG_INT,
	.start_arg = 0,
	.scan_begin_src = TRIG_EXT,
	.scan_begin_arg = 0, /* in ns */
	.convert_src = TRIG_NOW,
	.convert_arg = 0, /* in ns */
	.scan_end_src = TRIG_COUNT,
	.scan_end_arg = 4,
	.stop_src = TRIG_NONE,
	.stop_arg = 0,
	.nb_chan = 4,
	.chan_descs = chans,
};

a4l_insn_t insn = {
	.type = A4L_INSN_INTTRIG,
	.idx_subd = -1,
	.data_size = 0,
};

struct option cmd_bits_opts[] = {
	{"verbose", no_argument, NULL, 'v'},
	{"device", required_argument, NULL, 'd'},
	{"subdevice", required_argument, NULL, 's'},
	{"help", no_argument, NULL, 'h'},
	{0},
};

void do_print_usage(void)
{
	fprintf(stdout, "usage:\tcmd_bits [OPTS] <bits_values> <mask>\n");
	fprintf(stdout, "\tOPTS:\t -v, --verbose: verbose output\n");
	fprintf(stdout,
		"\t\t -d, --device: "
		"device filename (analogy0, analogy1, ...)\n");
	fprintf(stdout, "\t\t -s, --subdevice: subdevice index\n");
	fprintf(stdout, "\t\t -h, --help: print this help\n");
}

int main(int argc, char *argv[])
{
	int i = 0, err = 0;
	a4l_desc_t dsc = { .sbdata = NULL };
	a4l_sbinfo_t *sbinfo;
	int scan_size, idx_subd = -1;
	int value, mask = 0;

	/* Trigger status, written data..., before triggering */
	int triggered = 0, total = 0, trigger_threshold = 128;

	/* Compute arguments */
	while ((err = getopt_long(argc,
				  argv,
				  "vd:s:h", cmd_bits_opts, NULL)) >= 0) {
		switch (err) {
		case 'v':
			verbose = 1;
			break;
		case 'd':
			filename = optarg;
			break;
		case 's':
			idx_subd = strtoul(optarg, NULL, 0);
			break;
		case 'h':
		default:
			do_print_usage();
			return 0;
		}
	}

	value = (argc - optind > 0) ? strtoul(argv[optind], NULL, 0) : 0;
	mask = (argc - optind > 1) ? strtoul(argv[optind + 1], NULL, 0) : 0;

	/* Open the device */
	err = a4l_open(&dsc, filename);
	if (err < 0) {
		fprintf(stderr,
			"cmd_bits: a4l_open %s failed (err=%d)\n",
			FILENAME, err);
		return err;
	}	

	if (verbose != 0) {
		printf("cmd_bits: device %s opened (fd=%d)\n",
		       filename, dsc.fd);
		printf("cmd_bits: basic descriptor retrieved\n");
		printf("\t subdevices count = %d\n", dsc.nb_subd);
		printf("\t read subdevice index = %d\n", dsc.idx_read_subd);
		printf("\t write subdevice index = %d\n", dsc.idx_write_subd);
	}	

	/* Allocate a buffer so as to get more info (subd, chan, rng) */
	dsc.sbdata = malloc(dsc.sbsize);
	if (dsc.sbdata == NULL) {
		fprintf(stderr, "cmd_bits: malloc failed \n");
		return -ENOMEM;
	}

	/* Get this data */
	err = a4l_fill_desc(&dsc);
	if (err < 0) {
		fprintf(stderr,
			"cmd_bits: a4l_get_desc failed (err=%d)\n", err);
		goto out_cmd_bits;
	}

	if (verbose != 0)
		printf("cmd_bits: complex descriptor retrieved\n");
	
	/* If no subdevice index was set, choose for the first digital
	   subdevice found */
	while (idx_subd == -1 && i < dsc.nb_subd) {
		
		err = a4l_get_subdinfo(&dsc, i, &sbinfo);
		if (err < 0) {
			fprintf(stderr, 
				"cmd_bits: "
				"a4l_get_subdinfo(%d) failed (err = %d)\n",
				i, err);
			goto out_cmd_bits;
		}
		
		if ((sbinfo->flags & A4L_SUBD_TYPES) == A4L_SUBD_DIO ||
		    (sbinfo->flags & A4L_SUBD_TYPES) == A4L_SUBD_DO) {
			idx_subd = i;
		}

		i++;
	}

	if (idx_subd == -1) {
		fprintf(stderr, "cmd_bits: no digital subdevice available\n");
		err = -EINVAL;
		goto  out_cmd_bits;
	}

	if (verbose != 0)
		printf("cmd_bits: selected subdevice index = %d\n", 
		       idx_subd);

	/* We must check that the subdevice is really a digital one
	   (in case, the subdevice index was set with the option -s) */
	err = a4l_get_subdinfo(&dsc, idx_subd, &sbinfo);
	if (err < 0) {
		fprintf(stderr, 
			"cmd_bits: get_sbinfo(%d) failed (err = %d)\n",
			idx_subd, err);
		err = -EINVAL;
		goto out_cmd_bits;
	}

	cmd.idx_subd = insn.idx_subd = idx_subd;

	if ((sbinfo->flags & A4L_SUBD_TYPES) != A4L_SUBD_DIO &&
	    (sbinfo->flags & A4L_SUBD_TYPES) != A4L_SUBD_DO) {
		fprintf(stderr, 
			"cmd_bits: selected subdevice is not digital\n");
		err = -EINVAL;
		goto out_cmd_bits;		
	}

	/* Set the data size to read / write */
	scan_size = a4l_sizeof_subd(sbinfo);

	/* Handle little endian case with scan size < 32 */
	if (scan_size == sizeof(uint8_t)) {
		value *= 0x01010101;
	}
	else if (scan_size == sizeof(uint16_t)) {
		value *= 0x00010001;
	}

	/* Configure the polarities */
	for (i = 0; i < scan_size; i++) {
		int mode = (mask & (1 << i)) ? 
			A4L_INSN_CONFIG_DIO_OUTPUT : A4L_INSN_CONFIG_DIO_INPUT;

		err = a4l_config_subd(&dsc, cmd.idx_subd, mode, i);
		if (err < 0) {
			fprintf(stderr, 
				"cmd_bits: configuration of "
				"line %d failed (err=%d)\n", 
				i, err);
			goto out_cmd_bits;
		}
	}

	/* Send the command to the output device */
	err = a4l_snd_command(&dsc, &cmd);
	if (err < 0) {
		fprintf(stderr,
			"cmd_bits: a4l_snd_command failed (err=%d)\n", err);
		goto out_cmd_bits;
	}

	if (verbose != 0)
		printf("cmd_bits: command successfully sent\n");

	/* Perform the write operations */
	for (i=1; i<=100; ++i) { // sschaal: hacked for loop
	  printf("%d\n",i);
	  total = 0;
	do {
		err = a4l_async_write(&dsc, &value, scan_size, A4L_INFINITE);
		if (err < 0) {
			fprintf(stderr, 
				"cmd_bits: a4l_write failed (err=%d)\n", err);
			goto out_cmd_bits;
		}
		
		total += err;

		if (!triggered && total > trigger_threshold) {
			err = a4l_snd_insn(&dsc, &insn);
			if (err < 0) {
				fprintf(stderr, 
					"cmd_bits: triggering failed (err=%d)\n",
					err);
				goto out_cmd_bits;
			}
		}

	} while (err > 0);       	
	} // sschaal end hack for loop

out_cmd_bits:

	/* Free the buffer used as device descriptor */
	if (dsc.sbdata != NULL)
		free(dsc.sbdata);

	/* Release the file descriptor */
	a4l_close(&dsc);

	return err;
}

--Apple-Mail-162-683079189--

