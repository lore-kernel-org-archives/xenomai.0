Message-ID: <4C038E30.5070606@domain.hid>
Date: Mon, 31 May 2010 12:23:44 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <AANLkTimHOPpI3mst8-fM4Atf6V_-kurbqD-RKZdWDbUY@mail.gmail.com>
In-Reply-To: <AANLkTimHOPpI3mst8-fM4Atf6V_-kurbqD-RKZdWDbUY@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------090201070500060703040900"
Subject: Re: [Xenomai-help] How to generate a waveform / digital output
	(Alexis)
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

This is a multi-part message in MIME format.
--------------090201070500060703040900
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 30/05/10 18:14, Ettore Pedretti wrote:
> Do you have any example similar to ao_waveform.c I could try to modify
> for my application? That would be a start. I have been unsuccessfully
> searching the threads for something vaguely similar.

Hi Ettore,

I'm attaching two programs I wrote to generate waveforms with analogy.

The first, analogy-waveform, generates the points describing the
waveform in a buffer and keeps feeding the DAC with data from this
buffer in a circular way.

The second, analogy-phasemod, produces instead a phase modulated sine
wave. It would be much more complex to use the same technique, therefore
I continuously compute new data points.

I hope those examples will be useful to you.

Cheers,
-- 
Daniele


--------------090201070500060703040900
Content-Type: text/plain;
 name="analogy-phasemod.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="analogy-phasemod.c"

/* Use an analog output subdevice with an asynchronous command to
 * generate a phase modulated sine wave. */

#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <getopt.h>
#include <ctype.h>
#include <math.h>
#include <string.h>

#include <analogy/analogy.h>

#define DEBUG(frmt, args...) fprintf(stderr, "%s:%d:%s:DEBUG: "frmt"\n" , __FILE__, __LINE__, __FUNCTION__, ##args)
#define ERROR(frmt, args...) fprintf(stderr, "%s:%d:%s:ERROR: "frmt"\n" , __FILE__, __LINE__, __FUNCTION__, ##args)
#define PERROR(frmt, args...) fprintf(stderr, "%s:%d:%s:ERROR: "frmt": %s\n" , __FILE__, __LINE__, __FUNCTION__, ##args, strerror(errno))

#ifndef PI
#define PI 3.14159265358979323846
#endif

#define WAVEFORM_SINE		1
#define WAVEFORM_SAWTOOTH	2
#define WAVEFORM_TRIANGULAR	3
#define WAVEFORM_STEPS		4

static int analogy_internal_trigger(a4l_desc_t *dsc, unsigned int subdevice, unsigned int num)
{
     a4l_insn_t insn;
     unsigned int data[1];

     memset(&insn, 0, sizeof(insn));
     insn.type = A4L_INSN_INTTRIG;
     insn.idx_subd = subdevice;
     insn.data_size = 1;
     insn.data = data;

     data[0] = num;

     return a4l_snd_insn(dsc, &insn);
}

#if 0
static int analogy_find_range(a4l_desc_t *dsc, unsigned int idx_subd, unsigned int idx_chan, 
			      unsigned long unit, double min, double max, a4l_rnginfo_t **rng)
{
     a4l_chinfo_t *chinfo;
     a4l_rnginfo_t *rnginfo;
     int i, ret;
     long lmin, lmax;
     unsigned int idx_rng = -ENOENT;

     /* initializes variables */
     lmin = (long)(min * A4L_RNG_FACTOR);
     lmax = (long)(max * A4L_RNG_FACTOR);
     if (rng != NULL)
	  *rng = NULL;

     /* retrieves the ranges count */
     ret = a4l_get_chinfo(dsc, idx_subd, idx_chan, &chinfo);
     if (ret < 0)
	  return ret;

     for (i = 0; i < chinfo->nb_rng; i++) {

	  ret = a4l_get_rnginfo(dsc, idx_subd, idx_chan, i, &rnginfo);
	  if (ret < 0)
	       return ret;

	  if (A4L_RNG_UNIT(rnginfo->flags) == unit &&
	      rnginfo->min <= lmin && rnginfo->max >= lmax) {

	       idx_rng = i;
	       if (rng != NULL)
		    *rng = rnginfo;

	  }
     }

     return idx_rng;
}
#endif

typedef struct _waveform {
     int kind;		/* waveform kind */
     double frequency;	/* waveform frequency */
     double amplitude;	/* peak-to-peak amplitude */
     double offset;	/* offset */
} waveform_t;

typedef struct _options {
     char *filename;
     int subdevice;
     int channel;
     int nchan;
     int aref;
     int range;
     int unit;
     int freq;
     waveform_t *waveform;
} options_t;

#define FILENAME "analogy0"

void init_options(options_t *options)
{
     memset(options, 0, sizeof(options_t));
     options->filename = FILENAME;
     options->subdevice = -1;
     options->channel = 0;
     options->nchan = 1;
     options->aref = AREF_GROUND;
     options->range = -1;
     /* options->unit = A4L_RNG_VOLT_UNIT; bug in analogy */
     options->unit = A4L_RNG_NO_UNIT;
     options->freq = 100000.0;
}

void init_waveform(waveform_t *waveform)
{
     memset(waveform, 0, sizeof(waveform_t));
     waveform->kind = WAVEFORM_SINE;
     waveform->amplitude = 1.0;
     waveform->offset = 0.0;
     waveform->frequency = 1000.0;
}

int parse_options(options_t *options, waveform_t *waveform, int argc, char **argv)
{
     static struct option opts[] = {
	  { "device", 1, 0, 'd' },
	  { "subdevice", 1, 0, 's' },
	  { "channel", 1, 0, 'c' },
	  { "aref", 1, 0, 'a' },
	  { "range", 1, 0, 'r' },
	  { "frequency", 1, 0, 'f' },
	  { "waveform", 1, 0, 'w' },
	  { "offset", 1, 0, 'o' },
	  { "amplitude", 1, 0, 'a' },
	  { 0, 0, 0, 0 },
     };

     while (1) {
	  int index = 0;
	  char c = getopt_long(argc, argv, "", opts, &index);
	  
	  if (c == -1)
	       break;

	  switch (c) {
	  case 'd':
	       options->filename = optarg;
	       break;
	  case 's':
	       options->subdevice = strtoul(optarg, NULL, 0);
	       break;
	  case 'c':
	       options->channel = strtoul(optarg, NULL, 0);
	       break;
	  case 'a':
	       if (strcmp(optarg, "diff") == 0) {
		    options->aref = AREF_DIFF;
		    break;
	       }
	       if (strcmp(optarg, "ground") == 0) {
		    options->aref = AREF_GROUND;
		    break;
	       }
	       if (strcmp(optarg, "other") == 0) {
		    options->aref = AREF_OTHER;
		    break;
	       }
	       if (strcmp(optarg, "common") == 0) {
		    options->aref = AREF_COMMON;
		    break;
	       }
	       fprintf(stderr, "unknow analog reference\n");
	       exit(-1);
	       break;
	  case 'r':
	       options->range = strtoul(optarg, NULL, 0);
	       break;
	  case 'w':
	       if (strcmp(optarg, "sin") == 0) {
		    waveform->kind = WAVEFORM_SINE;
		    break;
	       }
	       if (strcmp(optarg, "saw") == 0) {
		    waveform->kind = WAVEFORM_SAWTOOTH;
		    break;
	       }
	       if (strcmp(optarg, "tri") == 0) {
		    waveform->kind = WAVEFORM_TRIANGULAR;
		    break;
	       }
	       if (strcmp(optarg, "ste") == 0) {
		    waveform->kind = WAVEFORM_STEPS;
		    break;
	       }
	       fprintf(stderr, "unknow waveform\n");
	       exit(-1);
	       break;
	       
	  case 'o':
	       waveform->offset = strtod(optarg, NULL);
	       break;

	  case 'f':
	       waveform->frequency = strtod(optarg, NULL);
	       break;

	  default:
	       fprintf(stderr, "unknown option\n");
	       exit(-1);
	  }
     }

     if (optind < argc) {
	  /* amplitude */
	  waveform->amplitude = strtod(argv[optind++], NULL);
     }

     DEBUG("frequency=%f", waveform->frequency);
     DEBUG("amplitude=%f", waveform->amplitude);
     DEBUG("offset=%f", waveform->offset);

     return argc;
}

typedef struct _generator {
     int kind;
     double frequency;	/* waveform frequency */
     double amplitude;	/* peak-to-peak amplitude in DAC units */
     double offset;	/* offset in DAC units */
     double dt;
     double t;		/* time */
} generator_t;

void generate(generator_t *gen, unsigned short *buffer, unsigned long size)
{
     double phase = 0;
     unsigned long samples = size / sizeof(unsigned short);
     //DEBUG("generate start=%p len=%ld samples=%ld", buffer, size, samples);
     for (unsigned long i = 0; i < samples; i++) {
	  //if (i < 100) {
	  //     buffer[i] = gen->offset;
	  //} else {
	       phase = sin(2*PI * gen->t);
	       buffer[i] = gen->amplitude * cos(2*PI * gen->frequency * gen->t + phase) + gen->offset;
	       gen->t += gen->dt;
	       //}
	  //fprintf(stdout, "%d\n", buffer[i]);
     }
}

int main(int argc, char **argv)
{
     unsigned int chanlist[16];

     int ret;
     options_t options;
     init_options(&options);

     waveform_t waveform;
     init_waveform(&waveform);

     parse_options(&options, &waveform, argc, argv);

     /* open device */
     int rv;
     a4l_desc_t dsc;
     rv = a4l_open(&dsc, options.filename);
     if (rv < 0) {
	  fprintf(stderr, "error opening %s\n", options.filename);
	  return -1;
     }

     DEBUG("device=%s fd=%d", options.filename, dsc.fd);
     DEBUG("subdevices=%d", dsc.nb_subd);
     DEBUG("read subdevice=%d", dsc.idx_read_subd);
     DEBUG("write subdevice=%d", dsc.idx_write_subd);

     /* subdevice */
     if (options.subdevice < 0) {
	  options.subdevice = dsc.idx_write_subd;
     }
     DEBUG("subdevice=%d", options.subdevice);

     /* allocate additional informations buffer */
     dsc.sbdata = malloc(dsc.sbsize);
     if (dsc.sbdata == NULL) {
	  ERROR("malloc");
	  return -ENOMEM;
     }

     /* get additional informations */
     rv = a4l_fill_desc(&dsc);
     if (rv < 0) {
	  ERROR("analogy fill desc");
	  goto out;
     }

     /* get channel infos */
     a4l_chinfo_t *info;
     rv = a4l_get_chinfo(&dsc, options.subdevice, options.channel, &info);
     if (rv < 0) {
	  ERROR("analogy get chinfo");
	  goto out;
     }

     /* get range */
     double min = waveform.offset - waveform.amplitude;
     double max = waveform.offset + waveform.amplitude;
     if (options.range < 0) {
	  options.range = a4l_find_range(&dsc, options.subdevice, options.channel, options.unit, min, max, NULL);
	  DEBUG("range=%d", options.range);
     }
     a4l_rnginfo_t *range;
     rv = a4l_get_rnginfo(&dsc, options.subdevice, options.channel, options.range, &range);
     if (rv < 0) {
	  ERROR("analogy get rngnfo");
	  goto out;
     }

     generator_t generator;
     memset(&generator, 0, sizeof(generator));
     generator.kind = waveform.kind;
     generator.frequency = waveform.frequency;
     generator.dt = 1.0 / options.freq;

     /* physical to sample */
     unsigned short value = 0;
     double raw = 0.0;
     a4l_dtoraw(info, range, &value, &raw, 1);
     double zero = value;
     
     a4l_dtoraw(info, range, &value, &(waveform.amplitude), 1);
     generator.amplitude = value - zero;

     a4l_dtoraw(info, range, &value, &(waveform.offset), 1);
     generator.offset = value;
     
     DEBUG("amplitude=%f", generator.amplitude);
     DEBUG("offset=%f", generator.offset);

     /* setup command */
     a4l_cmd_t cmd;
     memset(&cmd, 0, sizeof(cmd));
     cmd.idx_subd = options.subdevice;
     cmd.flags = A4L_CMD_WRITE;
     cmd.start_src = TRIG_INT;
     cmd.start_arg = 0;
     cmd.scan_begin_src = TRIG_TIMER;
     cmd.scan_begin_arg = 1e9 / options.freq;
     cmd.convert_src = TRIG_NOW;
     cmd.convert_arg = 0;
     cmd.scan_end_src = TRIG_COUNT;
     cmd.scan_end_arg = options.nchan;
     cmd.stop_src = TRIG_NONE;
     cmd.stop_arg = 0;
     cmd.nb_chan = 1,
     cmd.chan_descs = chanlist;

     /* setup channel description */
     chanlist[0] = PACK(options.channel, options.range, options.aref);
	       
     /* cancel any command which might be in progress */
     a4l_snd_cancel(&dsc, cmd.idx_subd);

     /* get buffer size to map */
     unsigned long bufsize;
     rv = a4l_get_bufsize(&dsc, options.subdevice, &bufsize);
     if (rv < 0) {
	  ERROR("analogy get bufsize");
	  goto out;
     }
     DEBUG("buffer size=%lu", bufsize);

     /* map analog input subdevice buffer */
     void *map = NULL;
     rv = a4l_mmap(&dsc, options.subdevice, bufsize, &map);
     if (rv < 0) {
	  ERROR("analogy mmap");
	  goto out;
     }

     /* send the command to the output device */
     rv = a4l_snd_command(&dsc, &cmd);
     if (rv < 0) {
	  ERROR("analogy snd command");
	  goto out;
     }

     /* preload output buffer */
     generate(&generator, map, bufsize);

     /* update buffer state */
     unsigned long none;
     rv = a4l_mark_bufrw(&dsc, options.subdevice, bufsize, &none);
     if (rv < 0) {
	  ERROR("analogy bufrw");
	  goto out;
     }
     
     /* send internal trigger */
     ret = analogy_internal_trigger(&dsc, options.subdevice, 0);
     if (ret < 0) {
	  ERROR("comedi_internal_trigger\n");
	  exit(1);
     }

     /* keep updating the output buffer */
     unsigned long front = 0;
     unsigned long cnt = 0;
     while (1) {
	  /* wait for device to empty buffer */
	  rv = a4l_poll(&dsc, options.subdevice, A4L_INFINITE);
	  if (rv < 0) {
	       ERROR("analogy poll");
	       goto out;
	  }
	  front = (unsigned long)rv;

	  /* handle ring buffer wrap around */
	  unsigned long tmp = front;
	  unsigned long towrite;
	  while (tmp) {
	       if (((cnt % bufsize) + tmp) > bufsize) {
		    towrite = bufsize - (cnt % bufsize);
	       } else {
		    towrite = tmp;
	       }

	       /* generate new data */
	       generate(&generator, map + (cnt % bufsize), towrite);
	       tmp -= towrite;

	       /* update counter */
	       cnt += towrite;
	  }
	  	  
	  /* update buffer state */
	  rv = a4l_mark_bufrw(&dsc, options.subdevice, front, &front);
	  if (rv < 0) {
	       ERROR("analogy bufrw");
	       goto out;
	  }
     }

out:
     /* free buffer */
     if (dsc.sbdata != NULL)
	  free(dsc.sbdata);

     /* cancel any command which might be in progress */
     a4l_snd_cancel(&dsc, cmd.idx_subd);
     
     /* close file descriptor */
     a4l_close(&dsc);
     
     return rv;
}

--------------090201070500060703040900
Content-Type: text/plain;
 name="analogy-waveform.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="analogy-waveform.c"

/* Use an analog output subdevice with an asynchronous command to
 * generate a waveform.
 *
 * A 32-bit accumulator is incremented by a phase factor which is the
 * amount that the generator advances each time step.  The accumulator
 * is then shifted right by 16 bits to get a 16 bit offset into a
 * lookup table.  The value in the lookup table at that offset is then
 * put into a buffer for output to the DAC.
 */

#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <getopt.h>
#include <ctype.h>
#include <math.h>
#include <string.h>

#include <analogy/analogy.h>

#define DEBUG(frmt, args...) fprintf(stderr, "%s:%d:%s:DEBUG: "frmt"\n" , __FILE__, __LINE__, __FUNCTION__, ##args)
#define ERROR(frmt, args...) fprintf(stderr, "%s:%d:%s:ERROR: "frmt"\n" , __FILE__, __LINE__, __FUNCTION__, ##args)
#define PERROR(frmt, args...) fprintf(stderr, "%s:%d:%s:ERROR: "frmt": %s\n" , __FILE__, __LINE__, __FUNCTION__, ##args, strerror(errno))

#ifndef PI
#define PI 3.14159265358979323846
#endif

#define WAVEFORM_SINE		1
#define WAVEFORM_SAWTOOTH	2
#define WAVEFORM_TRIANGULAR	3
#define WAVEFORM_STEPS		4

static int analogy_internal_trigger(a4l_desc_t *dsc, unsigned int subdevice, unsigned int num)
{
     a4l_insn_t insn;
     unsigned int data[1];

     memset(&insn, 0, sizeof(insn));
     insn.type = A4L_INSN_INTTRIG;
     insn.idx_subd = subdevice;
     insn.data_size = 1;
     insn.data = data;

     data[0] = num;

     return a4l_snd_insn(dsc, &insn);
}

static int analogy_find_range(a4l_desc_t *dsc, unsigned int idx_subd, unsigned int idx_chan, 
			      unsigned long unit, double min, double max, a4l_rnginfo_t **rng)
{
     a4l_chinfo_t *chinfo;
     a4l_rnginfo_t *rnginfo;
     int i, ret;
     long lmin, lmax;
     unsigned int idx_rng = -1;

     /* initializes variables */
     lmin = (long)(min * A4L_RNG_FACTOR);
     lmax = (long)(max * A4L_RNG_FACTOR);
     if (rng != NULL)
	  *rng = NULL;

     /* retrieves the ranges count */
     ret = a4l_get_chinfo(dsc, idx_subd, idx_chan, &chinfo);
     if (ret < 0)
	  return ret;

     for (i = 0; i < chinfo->nb_rng; i++) {

	  ret = a4l_get_rnginfo(dsc, idx_subd, idx_chan, i, &rnginfo);
	  if (ret < 0)
	       return ret;

	  if (A4L_RNG_UNIT(rnginfo->flags) == unit &&
	      rnginfo->min <= lmin && rnginfo->max >= lmax) {

	       idx_rng = i;
	       if (rng != NULL)
		    *rng = rnginfo;

	  }
     }

     return idx_rng;
}

typedef struct _waveform {
     int kind;		/* waveform kind */
     double frequency;	/* waveform frequency */
     double amplitude;	/* peak-to-peak amplitude */
     double offset;	/* offset */
} waveform_t;

typedef struct _options {
     char *filename;
     int subdevice;
     int channel;
     int nchan;
     int aref;
     int range;
     int unit;
     int freq;
     waveform_t *waveform;
} options_t;

#define FILENAME "analogy0"

void init_options(options_t *options)
{
     memset(options, 0, sizeof(options_t));
     options->filename = FILENAME;
     options->subdevice = -1;
     options->channel = 0;
     options->nchan = 1;
     options->aref = AREF_GROUND;
     options->range = -1;
     /* options->unit = A4L_RNG_VOLT_UNIT; bug in analogy */
     options->unit = A4L_RNG_NO_UNIT;
     options->freq = 100000.0;
}

void init_waveform(waveform_t *waveform)
{
     memset(waveform, 0, sizeof(waveform_t));
     waveform->kind = WAVEFORM_SINE;
     waveform->amplitude = 1.0;
     waveform->offset = 0.0;
     waveform->frequency = 10.0;
}

int parse_options(options_t *options, waveform_t *waveform, int argc, char **argv)
{
     static struct option opts[] = {
	  { "device", 1, 0, 'd' },
	  { "subdevice", 1, 0, 's' },
	  { "channel", 1, 0, 'c' },
	  { "aref", 1, 0, 'a' },
	  { "range", 1, 0, 'r' },
	  { "frequency", 1, 0, 'f' },
	  { "waveform", 1, 0, 'w' },
	  { "offset", 1, 0, 'o' },
	  { "amplitude", 1, 0, 'a' },
	  { 0, 0, 0, 0 },
     };

     while (1) {
	  int index = 0;
	  char c = getopt_long(argc, argv, "", opts, &index);
	  
	  if (c == -1)
	       break;

	  switch (c) {
	  case 'd':
	       options->filename = optarg;
	       break;
	  case 's':
	       options->subdevice = strtoul(optarg, NULL, 0);
	       break;
	  case 'c':
	       options->channel = strtoul(optarg, NULL, 0);
	       break;
	  case 'a':
	       if (strcmp(optarg, "diff") == 0) {
		    options->aref = AREF_DIFF;
		    break;
	       }
	       if (strcmp(optarg, "ground") == 0) {
		    options->aref = AREF_GROUND;
		    break;
	       }
	       if (strcmp(optarg, "other") == 0) {
		    options->aref = AREF_OTHER;
		    break;
	       }
	       if (strcmp(optarg, "common") == 0) {
		    options->aref = AREF_COMMON;
		    break;
	       }
	       fprintf(stderr, "unknow analog reference\n");
	       exit(-1);
	       break;
	  case 'r':
	       options->range = strtoul(optarg, NULL, 0);
	       break;
	  case 'w':
	       if (strcmp(optarg, "sin") == 0) {
		    waveform->kind = WAVEFORM_SINE;
		    break;
	       }
	       if (strcmp(optarg, "saw") == 0) {
		    waveform->kind = WAVEFORM_SAWTOOTH;
		    break;
	       }
	       if (strcmp(optarg, "tri") == 0) {
		    waveform->kind = WAVEFORM_TRIANGULAR;
		    break;
	       }
	       if (strcmp(optarg, "ste") == 0) {
		    waveform->kind = WAVEFORM_STEPS;
		    break;
	       }
	       fprintf(stderr, "unknow waveform\n");
	       exit(-1);
	       break;
	       
	  case 'o':
	       waveform->offset = strtod(optarg, NULL);
	       break;

	  case 'f':
	       waveform->frequency = strtod(optarg, NULL);
	       break;

	  default:
	       fprintf(stderr, "unknown option\n");
	       exit(-1);
	  }
     }

     if (optind < argc) {
	  /* amplitude */
	  waveform->amplitude = strtod(argv[optind++], NULL);
     }

     fprintf(stderr, "amplitude=%f\n", waveform->amplitude);
     fprintf(stderr, "offset=%f\n", waveform->offset);

     return argc;
}

#define WAVEFORMSHIFT 16
#define WAVEFORMLEN   (1 << WAVEFORMSHIFT)
#define WAVEFORMMASK  (WAVEFORMLEN - 1)

typedef struct _dds {
     int kind;
     double frequency;	/* waveform frequency */
     double amplitude;	/* peak-to-peak amplitude in DAC units */
     double offset;	/* offset in DAC units */
     
     unsigned int adder;
     unsigned int acc;
     sampl_t waveform[WAVEFORMLEN];
} dds_t;

void dds_init_sine(dds_t *dds)
{
     for (int i = 0; i < WAVEFORMLEN ; i++) {
	  dds->waveform[i] = rint(dds->offset + 0.5 * dds->amplitude * cos(i*2*PI/(WAVEFORMLEN-1)));
     }
}

void dds_init_sawtooth(dds_t *dds)
{
     for (int i = 0; i < WAVEFORMLEN; i++) {
	  dds->waveform[i] = rint(dds->offset + dds->amplitude * ((double)i)/(WAVEFORMLEN-1));
	  //fprintf(stdout, "%d %f %d\n", i, ((double)i)/(WAVEFORMLEN-1), dds->waveform[i]);
     }
     //fflush(stdout);
}

void dds_init_triangular(dds_t *dds)
{
     fprintf(stderr, "here\n");
     int i = 0;
     for ( ; i < WAVEFORMLEN/2; i++) {
	  dds->waveform[i] = rint(dds->offset + dds->amplitude * ((double)i)/WAVEFORMLEN*2);
	  //fprintf(stdout, "%d %d\n", i, dds->waveform[i]);
     }
     for ( ; i < WAVEFORMLEN; i++) { 
	  dds->waveform[i] = rint(dds->offset + 2.0 * dds->amplitude - dds->amplitude * ((double)i)/WAVEFORMLEN*2);
	  //fprintf(stdout, "%d %d\n", i, dds->waveform[i]);
     }
     //fflush(stdout);
}

void dds_init_steps(dds_t *dds)
{
     int i = 0;
     for ( ; i < WAVEFORMLEN/2; i++) {
	  dds->waveform[i] = rint(dds->offset + dds->amplitude * (i*10/WAVEFORMLEN*2)/10);
	  //printf("%d %d\n", i, dds->waveform[i]);
     }
     for ( ; i < WAVEFORMLEN; i++) { 
	  dds->waveform[i] = rint(dds->offset + 2.0 * dds->amplitude - dds->amplitude * (i*10/WAVEFORMLEN*2)/10);
     }
     //fflush(stdout);
}

void dds_init(dds_t *dds, double frequency)
{
     fprintf(stderr, "initialise waveform table\n");
     dds->acc = 0;
     dds->adder = dds->frequency / frequency * (1 << 16) * (1 << WAVEFORMSHIFT);
     //fprintf(stderr, "adder=%12d\n", dds->adder);
     switch (dds->kind) {
     case WAVEFORM_SINE:
	  dds_init_sine(dds);
	  break;
     case WAVEFORM_SAWTOOTH:
	  dds_init_sawtooth(dds);
	  break;
     case WAVEFORM_TRIANGULAR:
	  dds_init_triangular(dds);
	  break;
     case WAVEFORM_STEPS:
	  dds_init_steps(dds);
	  break;
     }
     fprintf(stderr, "done\n");
}

void dds_output(dds_t *dds, sampl_t *buf, int n)
{
     sampl_t *p = buf;
     
     int ii;

     for (int i = 0; i < n; i++) {
	  ii = (dds->acc >> 16) & WAVEFORMMASK;
	  *p = dds->waveform[(dds->acc >> 16) & WAVEFORMMASK];
	  //fprintf(stdout, "%d %d\n", ii, *p);
	  p++;
	  dds->acc += dds->adder;
     }
     //fflush(stdout);
}

/* chunks size */
#define BUFLEN 0x8000
sampl_t data[BUFLEN];

int main(int argc, char **argv)
{
     int n, m;
     int total = 0;
     unsigned int chanlist[16];

     int ret;
     options_t options;
     init_options(&options);

     waveform_t waveform;
     init_waveform(&waveform);

     parse_options(&options, &waveform, argc, argv);

     /* open device */
     int rv;
     a4l_desc_t dsc;
     rv = a4l_open(&dsc, options.filename);
     if (rv < 0) {
	  fprintf(stderr, "error opening %s\n", options.filename);
	  return -1;
     }

     DEBUG("device=%s fd=%d", options.filename, dsc.fd);
     DEBUG("subdevices=%d", dsc.nb_subd);
     DEBUG("read subdevice=%d", dsc.idx_read_subd);
     DEBUG("write subdevice=%d", dsc.idx_write_subd);
     DEBUG("sbsize=%d", dsc.sbsize);

     /* subdevice */
     if (options.subdevice < 0) {
	  options.subdevice = dsc.idx_write_subd;
     }
     DEBUG("subdevice=%d", options.subdevice);

     /* allocate additional informations buffer */
     dsc.sbdata = malloc(dsc.sbsize);
     if (dsc.sbdata == NULL) {
	  ERROR("malloc");
	  return -ENOMEM;
     }

     /* get additional informations */
     rv = a4l_fill_desc(&dsc);
     if (rv < 0) {
	  ERROR("analogy fill desc");
	  goto out;
     }

     a4l_chinfo_t *info;
     rv = a4l_get_chinfo(&dsc, options.subdevice, options.channel, &info);
     if (rv < 0) {
	  ERROR("analogy get chinfo");
	  goto out;
     }

     for (int i = 0; i < info->nb_rng; i++) {
	  a4l_rnginfo_t *range;
	  rv = a4l_get_rnginfo(&dsc, options.subdevice, options.channel, i, &range);
	  if (rv < 0) {
	       ERROR("analogy get rngnfo");
	       goto out;
	  }
	  DEBUG("range=%d %ld %ld", i, range->max, range->min);
     }

     /* range */
     double min = waveform.offset - waveform.amplitude;
     double max = waveform.offset + waveform.amplitude;
     DEBUG("min=%f max=%f", min, max);
     if (options.range < 0) {
	  options.range = analogy_find_range(&dsc, options.subdevice, options.channel, options.unit, min, max, NULL);
	  DEBUG("range=%d", options.range);
     }
     a4l_rnginfo_t *range;
     rv = a4l_get_rnginfo(&dsc, options.subdevice, options.channel, options.range, &range);
     if (rv < 0) {
	  ERROR("analogy get rngnfo");
	  goto out;
     }

     dds_t dds;
     dds.kind = waveform.kind;
     dds.frequency = waveform.frequency;

     /* physical to sample */
     unsigned short value = 0;
     double raw = 0.0;
     a4l_dtoraw(info, range, &value, &raw, 1);
     double zero = value;
     
     a4l_dtoraw(info, range, &value, &(waveform.amplitude), 1);
     dds.amplitude = value - zero;

     a4l_dtoraw(info, range, &value, &(waveform.offset), 1);
     dds.offset = value;
     
     DEBUG("amplitude=%f", dds.amplitude);
     DEBUG("offset=%f", dds.offset);

     /* setup command */
     a4l_cmd_t cmd;
     memset(&cmd, 0, sizeof(cmd));
     cmd.idx_subd = options.subdevice;
     cmd.flags = A4L_CMD_WRITE;
     cmd.start_src = TRIG_INT;
     cmd.start_arg = 0;
     cmd.scan_begin_src = TRIG_TIMER;
     cmd.scan_begin_arg = 1e9 / options.freq;
     cmd.convert_src = TRIG_NOW;
     cmd.convert_arg = 0;
     cmd.scan_end_src = TRIG_COUNT;
     cmd.scan_end_arg = options.nchan;
     cmd.stop_src = TRIG_COUNT;
     cmd.stop_arg = 10000000;
     cmd.nb_chan = 1,
     cmd.chan_descs = chanlist;

     chanlist[0] = PACK(options.channel, options.range, options.aref);
	       
     /* cancel any command which might be in progress */
     a4l_snd_cancel(&dsc, cmd.idx_subd);

     /* send the command to the input device */
     rv = a4l_snd_command(&dsc, &cmd);
     if (rv < 0) {
	  ERROR("analogy snd command");
	  goto out;
     }

     dds_init(&dds, options.freq);     
     dds_output(&dds, data, BUFLEN);

     n = BUFLEN * sizeof(sampl_t);
     m = a4l_sys_write(dsc.fd, (void *)data, n);
     if (m < 0) {
	  ERROR("write");
	  exit(1);
     } else if (m < n) {
	  fprintf(stderr, "failed to preload output buffer\n");
	  exit(1);
     }
     
     /* send internal trigger */
     ret = analogy_internal_trigger(&dsc, options.subdevice, 0);
     if (ret < 0) {
	  ERROR("comedi_internal_trigger\n");
	  exit(1);
     }

     while (1) {
	  dds_output(&dds, data, BUFLEN);
	  n = BUFLEN * sizeof(sampl_t);
	  while (n > 0) {
	       m = a4l_sys_write(dsc.fd, (void *)data+(BUFLEN*sizeof(sampl_t)-n), n);
	       if (m < 0) {
		    ERROR("write: %s", strerror(-m));
		    exit(0);
	       }
	       n -= m;
	  }
	  total += BUFLEN;
     }


out:
     /* free buffer */
     if (dsc.sbdata != NULL) {
	  free(dsc.sbdata);
     }

     /* cancel any command which might be in progress */
     a4l_snd_cancel(&dsc, cmd.idx_subd);
     
     /* close file descriptor */
     a4l_close(&dsc);
     
     return rv;
}

--------------090201070500060703040900--

