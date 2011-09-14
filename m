Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_11165E53-BA6E-438C-9EE0-441376BAA388"
From: Stefan Schaal <sschaal@domain.hid>
In-Reply-To: <20110103223909.GA2862@domain.hid>
Date: Tue, 13 Sep 2011 20:38:33 -0700
Message-Id: <D9A6A459-6F45-4191-B6B8-EECC0147FBAE@usc.edu>
References: <A54FA449-A0A8-4DCF-96C0-078ED6729C4C@usc.edu>
	<20110103223909.GA2862@domain.hid>
Subject: Re: [Xenomai-core] Analogy DIO data acquisition with NI6259
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <alexis.berlemont@domain.hid>
Cc: xenomai@xenomai.org


--Apple-Mail=_11165E53-BA6E-438C-9EE0-441376BAA388
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

This is a summary and conclusion of using a NI6259 with Xenomai/Analogy =
for digital data I/O. First of all, many thanks to Alexis whose Analogy =
branch really allowed us to succeed! We would just like share the final =
results of our implementation with the hope that this might help others.

Goals:=20
We needed a 19 bit parallel I/O for bi-directional communication between =
a host computer and a robot controller. The 32bit DIO of the NI6259 =
seemed to well suited. The communication protocol needs about 300 DIO =
commands per ms, where every about 20 commands the DIO port needs to =
switch from write to read and then back.

Problems:
Initially we tried a4l_sync_dio() (synchronous communication). We =
measured that one a4l_sync_dio() takes about 5us. Additionally, the =
switch from read to write mode also seems to take some additional time. =
Thus, the communication speed was not sufficient.

A 2nd attempt was to use instructions and instruction lists using =
a4l_snd_insnlist() and a4l_snd_insn(). We measure that this can bring =
down one data acquisition to about 3.5us when all commands are queued up =
in an instruction list, but due to the read/write switch we needed, we =
cannot use very long instruction lists, and the read/write switch takes =
too long. Thus, the communication speed did not improve a lot.

A 3rd attempt was to use CMD structures. Following comedi examples, we =
create a 200ns clock and triggered the CMD streaming with this clock. =
This allows VERY fast DIO. But, again, the read/write switches that are =
needed frequently made CMD structures inefficient as we could not cue up =
a lot of DIO commands before the next read/write switch, and in order to =
do the read/write switch, the CMD has to be aborted. We also noted that =
starting a CMD has some delays.

We realized that none of these approaches was feasible.

Solution:
We create a simple IC-based circuit that allowed to branch the =
read/write DIO protocol such that we could use one DIO channel of the =
NI6259 for write only (never switched to read), and the 2nd DIO channel =
on the NI6259 for read only (no switching). By avoiding the read/write =
switching, all three ideas from above are possible and run fast enough =
(after some optimization of our communication protocol). We ended up =
using a4l_sync_dio() as it is the easiest to use, and yielded sufficient =
speed. With the CMD approach, we would be able to go a factor 5-10 =
faster even.

For you info, our interface C-code is attached. This is not general =
purpose software, but should allow other to get the idea of what we do.

Best wishes, and thanks again to Alexis!

-Stefan


--Apple-Mail=_11165E53-BA6E-438C-9EE0-441376BAA388
Content-Disposition: attachment;
	filename=ni6259_interface.c
Content-Type: application/octet-stream;
	name="ni6259_interface.c"
Content-Transfer-Encoding: 7bit

/*!=============================================================================
  ==============================================================================

  \file    ni6259_interface.c

  \author  Stefan Schaal
  \date    Nov. 2009

  ==============================================================================
  \remarks

  Manages all communication with the National Instruments NI6259 DAQ board.
  This file only compiles under Xenomai with Analogy, which is the Comedi
  replacement in Xenomai.

  The 6259 DAQ has the following sub devices:

  |  00 | Analog input subdevice
  |  01 | Analog output subdevice
  |  02 | Digital input/output subdevice
  |  03 | Unused subdevice
  |  04 | Unused subdevice
  |  05 | Calibration subdevice
  |  06 | Memory subdevice
  |  07 | Digital input/output subdevice
  |  08 | Unused subdevice
  |  09 | Serial subdevice
  |  10 | Unused subdevice
  |  11 | Counter subdevice
  |  12 | Counter subdevice
  |  13 | Counter subdevice

  We need 01 for analog output, and 02 for the parallel port implementation.

  ============================================================================*/

#include "SL_system_headers.h"
#include "analogy/analogy.h"
#include "SL_oscilloscope.h"
#include "SL.h"
#include "SL_shared_memory.h"
#include "utility.h"
#include "ni6259_interface.h"
#include "comedi.h"
#include "ajc.h"
#include "SL_common.h"

// definitions to access devices and subdevices
#define   DEVICE "analogy0"  //!< we assume that the device is "analogy0"
#define   SUBDEV_AO   1      //!< the 4 analog output channels
#define   SUBDEV_DIO  2      //!< the 32 bit wide digital input/output device
#define   SUBDEV_PFI  7      //!< the programmable function interface subdevice
#define   SUBDEV_COUNTER 11  //!< the counter subdevice


// local variables
static a4l_desc_t desc;              //<! the device descriptor
static int dio32_channel_mode[32];   //<! either DIO_READ or DIO_WRITE, to minimize switches
static int dio16_channel_mode[16];   //<! either DIO_READ or DIO_WRITE, to minimize switches

// local functions
static int
makeCounterClock(unsigned int period_ns, int debug_on_pfi_1);

// global function


/*!*****************************************************************************
*******************************************************************************
\note  initNI6259
\date  Nov. 2009
   
\remarks 

Initializes the communication with the DAQ

*******************************************************************************
Function Parameters: [in]=input,[out]=output

\param[in]  ad_only_flag: only initialize A/D convert

\return TRUE for sucess, or FALSE if there was a problem

******************************************************************************/
int
init_NI6259(int ad_only_flag) 

{
  int i,rc;
  static int ni6259_initialized = FALSE;
  unsigned int data[10];
  a4l_insn_t insn;
  int        real_osc_enabled = FALSE;

  if (ni6259_initialized)
    return TRUE;

  // Open the device
  rc = a4l_open(&desc, DEVICE);
  if (rc < 0) {
    printf("initNI6259: a4l_open %s failed (rc=%d)\n",DEVICE, rc);
    return FALSE;
  }

  // Fill the descriptor completely, as a4l_open only does a partial job.
  // First, allocate a buffer so as to get more info (subd, chan, rng)
  desc.sbdata = malloc(desc.sbsize);
  if (desc.sbdata == NULL) {
    printf("initNI6259: malloc failed \n");
    return FALSE;
  }

  // Second, get the data
  rc = a4l_fill_desc(&desc);
  if (rc < 0) {
    printf("initNI6259: a4l_fill_desc %s failed (rc=%d)\n",DEVICE, rc);
    return FALSE;
  }

  // activate the analog outputs for the oscilloscope debugging
  if (read_parameter_pool_int(config_files[PARAMETERPOOL],"real_osc_enabled", &rc))
    real_osc_enabled = rc;

  if (real_osc_enabled)
    setD2AFunction(d2a_NI6259);
  
  if (!ad_only_flag) {
    
    // plot some output about device
    //printDeviceInfo(&desc);
    
    // enable the counter clock
    // makeCounterClock(1000, FALSE);
    
    // route DIO16 (PFI) to PFI channels
    for (i=0; i<16; ++i) {
      
      insn.type      = A4L_INSN_CONFIG;
      insn.idx_subd  = SUBDEV_PFI;
      insn.chan_desc = i;
      insn.data_size = sizeof(data[0])*2;
      data[0] = A4L_INSN_CONFIG_SET_ROUTING;
      data[1] = NI_PFI_OUTPUT_PFI_DO;
      insn.data      = data;
      
      rc = a4l_snd_insn(&desc, &insn);
      if (rc < 0)
	fprintf(stderr,"re-route PFI channels: routing of channe %d failed (rc=%d)\n",i,rc);
      
    }
    
    // set DIO32 channels to READ mode by default
    dio32_NI6259_config(0xffffffff, DIO_READ);
    
    // set DIO16 channels to READ mode by default
    dio16_NI6259_config(0xffffffff, DIO_READ);

  }
  
  // all done
  ni6259_initialized = TRUE;

  return TRUE;
}

/*!*****************************************************************************
********************************************************************************
\note  printDeviceInfo
\date  Nov. 2009

\remarks 

A function that provide more detailed information about all subdivices and
channels of a device

*******************************************************************************
Function Parameters: [in]=input,[out]=output


******************************************************************************/
void
printDeviceInfo(a4l_desc_t *dsc)

{

  int i,j;
  int rc;
  a4l_sbinfo_t *info;

  // print out information about this device
  printf("   Board Name             : %s\n",dsc->board_name);
  printf("   #Subdevices            : %d\n",dsc->nb_subd);
  printf("   Input Subdevice Index  : %d\n",dsc->idx_read_subd);
  printf("   Output Subdevice Index : %d\n",dsc->idx_write_subd);
  printf("   Data Buffer Size       : %d\n",dsc->sbsize);


  // get info about each of the subdevices
  for (i=1; i<=dsc->nb_subd; ++i) {

    rc = a4l_get_subdinfo(&desc,i-1,&info);
    if (rc < 0) {
      printf("ni_test: a4l_get_subdinfo (ID=%d on %s) failed (rc=%d)\n",i-1,DEVICE, rc);
      return;
    }

    printf("           Subdevice ID = %d\n",i-1);

    // what can this sub device do?
    if ((info->flags&A4L_SUBD_TYPES) == A4L_SUBD_UNUSED) {
      printf("             Subdevice is unused\n");
      printf("\n");
      continue;
    }
    if ((info->flags&A4L_SUBD_TYPES) == A4L_SUBD_AI)
      printf("             Subdevice is analog input\n");
    if ((info->flags&A4L_SUBD_TYPES) == A4L_SUBD_AO)
      printf("             Subdevice is analog output\n");
    if ((info->flags&A4L_SUBD_TYPES) == A4L_SUBD_DI)
      printf("             Subdevice is digital input\n");
    if ((info->flags&A4L_SUBD_TYPES) == A4L_SUBD_DO)
      printf("             Subdevice is digital output\n");
    if ((info->flags&A4L_SUBD_TYPES) == A4L_SUBD_DIO)
      printf("             Subdevice is digital input/output\n");
    if ((info->flags&A4L_SUBD_TYPES) == A4L_SUBD_COUNTER)
      printf("             Subdevice is counter\n");
    if ((info->flags&A4L_SUBD_TYPES) == A4L_SUBD_TIMER)
      printf("             Subdevice is timer\n");
    if ((info->flags&A4L_SUBD_TYPES) == A4L_SUBD_MEMORY)
      printf("             Subdevice is memory, EEPROM, or DPRAM\n");
    if ((info->flags&A4L_SUBD_TYPES) == A4L_SUBD_CALIB)
      printf("             Subdevice is calibration DAC\n");
    if ((info->flags&A4L_SUBD_TYPES) == A4L_SUBD_PROC)
      printf("             Subdevice is processor or DSP\n");
    if ((info->flags&A4L_SUBD_TYPES) == A4L_SUBD_SERIAL)
      printf("             Subdevice is serial I/O\n");
    if (info->flags & A4L_SUBD_CMD)
      printf("             Subdevice can handle command (asynchronous acquisition)\n");
    if (info->flags & A4L_SUBD_MMAP)
      printf("             Subdevice can do mmap operations\n");

    printf("             Status               %ld\n",info->status);
    printf("             Number of Channels   %d\n",info->nb_chan);


    // get channel info
    for (j=1; j<=info->nb_chan; ++j) {
      a4l_chinfo_t *chan_info;

      rc = a4l_get_chinfo(&desc,i-1,j-1,&chan_info);

      printf("                 %2d.Channel: #Bits = %d  #Ranges = %d  Flags = 0x%lx\n",
	     j-1,chan_info->nb_bits,
	     chan_info->nb_rng,chan_info->chan_flags);
    }

    printf("\n");

  }

}

/*!*****************************************************************************
*******************************************************************************
\note  d2a_NI6259
\date  Dec 2009
 
\remarks 
 
set the digital-to-analog (d2a) on a particular channel to a particiular value,
expressed as a percentage value of the max range of the D/A converter.
Using percentage values frees the user from knowing the resolution of the
D/A converter.

Note that we have a 16bit d2a channel on this board.
 
*******************************************************************************
Function Parameters: [in]=input,[out]=output
 
\param[in]   channel : which channel to use (numbered from 1 onwards)
\param[in]   pval    : [0 to 100] percentage value of max range to be displayed.
 
******************************************************************************/
int
d2a_NI6259(int channel, double pval) 
{
  char buf[2];
  int  val = 65535;
  int  rc;
  static int count_calls=0;
  static int count_errors=0;

  /*
    if (++count_calls%100000 == 0)
    printf("%d %d\n",count_calls,count_errors);
  */

  // create the fractional value
  val *= pval/100.;

  // copy to char array (2 bytes)
  memcpy(buf,(void *)&val,2);

  // the real channel count starts at zero
  channel -= 1;

  // send to the channel of the device
  //semTake(sm_init_process_ready_sem,WAIT_FOREVER);
  //a4l_snd_cancel(&desc,SUBDEV_AO);
  rc = a4l_sync_write(&desc,SUBDEV_AO,CHAN(channel), 0,buf, 2);
  //semGive(sm_init_process_ready_sem);
  if (rc < 0) {
    if (rc == -16)
      ++count_errors;
    else
      printf("d2a_NI6259: error in a4l_sync_write (rc=%d)\n",rc);
    return FALSE;
  }

  return TRUE;

}


/*!*****************************************************************************
*******************************************************************************
\note  dio32_NI6259_read
\date  Feb 2010
 
\remarks 

reads from DIO device a 32 bit value with bit mask

*******************************************************************************
Function Parameters: [in]=input,[out]=output
 
\param[in]   mask    : which bits to read
\param[out]  val     : the value read
 
******************************************************************************/
inline int
dio32_NI6259_read(int mask, int *val) 
{
  int i;
  int rc;

  // configure the device to read mode
  for (i=0; i<32; ++i) {
    if ( ((1 << i) & mask) > 0) {
      if (dio32_channel_mode[i] != DIO_READ) {
	rc = a4l_config_subd(&desc,SUBDEV_DIO,A4L_INSN_CONFIG_DIO_INPUT,i);
	if (rc < 0) {
	  printf("dio32_NI6259_read: failed to configure DIO (rc=%d, channel %d)\n",rc,i);
	  return FALSE;
	}
	dio32_channel_mode[i] = DIO_READ;
      }
    }
  }

  // read the value
  rc = a4l_sync_dio(&desc, SUBDEV_DIO, &mask, val);
  if (rc < 0) {
    printf("dio32_NI6259_read: failed to communicate to DIO (rc=%d)\n",rc);
    return FALSE;
  }

  *val = (*val) & mask;

  return TRUE;
}

/*!*****************************************************************************
*******************************************************************************
\note  dio32_NI6259_write
\date  Feb 2010
 
\remarks 

writes to DIO device a 32 bit value with bit mask

*******************************************************************************
Function Parameters: [in]=input,[out]=output
 
\param[in]   mask    : which bits to write
\param[in]   val     : the value to write
 
******************************************************************************/
inline int
dio32_NI6259_write(int mask, int val) 
{
  int i;
  int rc;

  // configure the device channels to read mode if needed
  for (i=0; i<32; ++i) {
    if ( ((1 << i) & mask) > 0) {
      if (dio32_channel_mode[i] != DIO_WRITE) {
	rc = a4l_config_subd(&desc,SUBDEV_DIO,A4L_INSN_CONFIG_DIO_OUTPUT,i);
	if (rc < 0) {
	  printf("dio32_NI6259_write: failed to configure DIO (rc=%d, channel %d)\n",rc,i);
	  return FALSE;
	}
	dio32_channel_mode[i] = DIO_WRITE;
      }
    }
  }

  // write the value
  rc = a4l_sync_dio(&desc, SUBDEV_DIO, &mask, &val);
  if (rc < 0) {
    printf("dio32_NI6259_write: failed to communicate to DIO (rc=%d)\n",rc);
    return FALSE;
  }

  return TRUE;
}

/*!*****************************************************************************
*******************************************************************************
\note  dio32_NI6259_config
\date  Feb 2010
 
\remarks 

sets selected bits to read or write

*******************************************************************************
Function Parameters: [in]=input,[out]=output
 
\param[in]   mask    : which bits to write
\param[in]   mode    : DIO_READ or DIO_WRITE
 
******************************************************************************/
int
dio32_NI6259_config(int mask, int mode) 
{
  int i;
  int rc;

  // configure the device to read mode
  for (i=0; i<32; ++i) {
    if ( ((1 << i) & mask) > 0) {
      if (mode == DIO_READ) 
	rc = a4l_config_subd(&desc,SUBDEV_DIO,A4L_INSN_CONFIG_DIO_INPUT,i);
      else
	rc = a4l_config_subd(&desc,SUBDEV_DIO,A4L_INSN_CONFIG_DIO_OUTPUT,i);

      if (rc < 0) {
	if (rc == -EBUSY) {
	  return rc;
	} else {
	  printf("dio32_NI6259_config: failed to configure DIO (rc=%d, channel %d)\n",rc,i);
	  return FALSE;
	}
      }
      dio32_channel_mode[i] = mode;

    }
  }

  return TRUE;
}

/*!*****************************************************************************
*******************************************************************************
\note  makeCounterClock
\date  Jan 2011
   
\remarks 

Make counter on subdevice 11 become a clock -- copied from comedi examples. This
high frequency clock allows sending DIO commands at much higher speed


*******************************************************************************
Function Parameters: [in]=input,[out]=output

\param[in]   clock_period_ns: the period of the clock in nanoseconds (e.g., 50ns
would be a 20MHz clock)
\param[in]   debug_on_pfi_1 : output clock signal on PFI channel 1

\return TRUE for sucess, or FALSE if there was a problem

******************************************************************************/
#define CHANNEL_PFI     1
static int
makeCounterClock(unsigned int period_ns, int debug_on_pfi_1)
{

  int  i,j,rc;
  lsampl_t counter_mode;
  const unsigned clock_period_ns = 50;	/* 20MHz base clock */
  unsigned int up_ticks, down_ticks;
  unsigned int data[10];
  unsigned int up_time_ns = period_ns/2;
  a4l_insn_t insn;

  // disarm clock just in case it is still running
  insn.type      = A4L_INSN_CONFIG;
  insn.idx_subd  = SUBDEV_COUNTER;
  insn.chan_desc = 0;
  insn.data_size = sizeof(data[0])*2;
  data[0] = A4L_INSN_CONFIG_DISARM;
  data[1] = NI_GPCT_ARM_IMMEDIATE;
  insn.data      = data;

  rc = a4l_snd_insn(&desc, &insn);
  if (rc < 0)
    fprintf(stderr,"makeCounterClock: arm counter failed (rc=%d)\n",rc);

  // route counter to output channel
  if (debug_on_pfi_1) {

    // first, configure the PFI0 channel as output channel
    rc = a4l_config_subd(&desc,SUBDEV_PFI,A4L_INSN_CONFIG_DIO_OUTPUT,0);
    if (rc < 0)
      fprintf(stderr,"makeCounterClock: PFI output failed (rc=%d)\n",rc);
    
    // second configure the PFI1 channel as input channel, so we can route
    // PFI0 to PFI1 with a wire, if we wish
    rc = a4l_config_subd(&desc,SUBDEV_PFI,A4L_INSN_CONFIG_DIO_INPUT,CHANNEL_PFI);
    if (rc < 0)
      fprintf(stderr,"makeCounterClock: PFI input failed (rc=%d)\n",rc);
    
    // and now route the signal
    insn.type      = A4L_INSN_CONFIG;
    insn.idx_subd  = SUBDEV_PFI;
    insn.chan_desc = 0;
    insn.data_size = sizeof(data[0])*2;
    data[0]        = A4L_INSN_CONFIG_SET_ROUTING;
    data[1]        = NI_PFI_OUTPUT_GOUT0;
    insn.data      = data;
    
    rc = a4l_snd_insn(&desc, &insn);
    if (rc < 0)
      fprintf(stderr,"makeCounterClock: routing of counter failed (rc=%d)\n",rc);
    
  }
  
  // reset counter
  insn.type      = A4L_INSN_CONFIG;
  insn.idx_subd  = SUBDEV_COUNTER;
  insn.chan_desc = 0;
  insn.data_size = sizeof(data[0]);
  data[0]        = A4L_INSN_CONFIG_RESET;
  insn.data      = data;

  rc = a4l_snd_insn(&desc, &insn);
  if (rc < 0)
    fprintf(stderr,"makeCounterClock: reset counter failed (rc=%d)\n",rc);
  
  // set the gate source
  insn.type      = A4L_INSN_CONFIG;
  insn.idx_subd  = SUBDEV_COUNTER;
  insn.chan_desc = 0;
  insn.data_size = sizeof(data[0])*3;
  data[0]        = A4L_INSN_CONFIG_SET_GATE_SRC;
  data[1]        = 0;
  data[2]        = NI_GPCT_DISABLED_GATE_SELECT | CR_EDGE;
  insn.data      = data;

  rc = a4l_snd_insn(&desc, &insn);
  if (rc < 0)
    fprintf(stderr,"makeCounterClock: set gate source failed (rc=%d)\n",rc);
  
  data[1] = 1;
  
  rc = a4l_snd_insn(&desc, &insn);
  if (rc < 0)
    fprintf(stderr,"makeCounterClock: set gate source failed (rc=%d)\n",rc);


  // set counter mode
  counter_mode = NI_GPCT_COUNTING_MODE_NORMAL_BITS;
  // toggle output on terminal count
  counter_mode |= NI_GPCT_OUTPUT_TC_TOGGLE_BITS;
  // load on terminal count
  counter_mode |= NI_GPCT_LOADING_ON_TC_BIT;
  // alternate the reload source between the load a and load b registers
  counter_mode |= NI_GPCT_RELOAD_SOURCE_SWITCHING_BITS;
  // count down
  counter_mode |= NI_GPCT_COUNTING_DIRECTION_DOWN_BITS;
  // initialize load source as load b register
  counter_mode |= NI_GPCT_LOAD_B_SELECT_BIT;
  // don't stop on terminal count
  counter_mode |= NI_GPCT_STOP_ON_GATE_BITS;
  // don't disarm on terminal count or gate signal
  counter_mode |= NI_GPCT_NO_HARDWARE_DISARM_BITS;
  

  insn.type      = A4L_INSN_CONFIG;
  insn.idx_subd  = SUBDEV_COUNTER;
  insn.chan_desc = 0;
  insn.data_size = sizeof(data[0])*2;
  data[0]        = A4L_INSN_CONFIG_SET_COUNTER_MODE;
  data[1]        = counter_mode;
  insn.data      = data;

  rc = a4l_snd_insn(&desc, &insn);
  if (rc < 0)
    fprintf(stderr,"makeCounterClock: set counter mode failed (rc=%d)\n",rc);

  
  // set clock source: 20 MHz clock
  insn.type      = A4L_INSN_CONFIG;
  insn.idx_subd  = SUBDEV_COUNTER;
  insn.chan_desc = 0;
  insn.data_size = sizeof(data[0])*3;
  data[0]        = A4L_INSN_CONFIG_SET_CLOCK_SRC;
  data[1]        = NI_GPCT_TIMEBASE_1_CLOCK_SRC_BITS;
  data[2]        = clock_period_ns;
  insn.data      = data;

  rc = a4l_snd_insn(&desc, &insn);
  if (rc < 0)
    fprintf(stderr,"makeCounterClock: set clock source failed (rc=%d)\n",rc);
  

  up_ticks = (up_time_ns + clock_period_ns / 2) / clock_period_ns;
  down_ticks = (period_ns + clock_period_ns / 2) / clock_period_ns - up_ticks;

  // set initial counter value by writing to channel 0
  rc = a4l_sync_write(&desc,SUBDEV_COUNTER, 0, 0,&down_ticks, 4);
  if (rc < 0)
    fprintf(stderr,"makeCounterClock: writing down_ticks 0 failed (rc=%d)\n",rc);


  // set "load a" register to the number of clock ticks the counter output should remain low
  // by writing to channel 1.
  rc = a4l_sync_write(&desc,SUBDEV_COUNTER, 1, 0,&down_ticks, 4);
  if (rc < 0)
    fprintf(stderr,"makeCounterClock: writing down_ticks 1 failed (rc=%d)\n",rc);

  // set "load b" register to the number of clock ticks the counter output should remain high
  // by writing to channel 2 
  rc = a4l_sync_write(&desc,SUBDEV_COUNTER, 2, 0,&up_ticks, 4);
  if (rc < 0)
    fprintf(stderr,"makeCounterClock: writing up_ticks 2 failed (rc=%d)\n",rc);


  // arm the counter
  insn.type      = A4L_INSN_CONFIG;
  insn.idx_subd  = SUBDEV_COUNTER;
  insn.chan_desc = 0;
  insn.data_size = sizeof(data[0])*2;
  data[0]        = A4L_INSN_CONFIG_ARM;
  data[1]        = NI_GPCT_ARM_IMMEDIATE;
  insn.data      = data;

  rc = a4l_snd_insn(&desc, &insn);
  if (rc < 0)
    fprintf(stderr,"makeCounterClock: arm counter failed (rc=%d)\n",rc);
  

  return TRUE;
  
}

/*!*****************************************************************************
*******************************************************************************
\note  dio32_NI6259_write_cmd_buffer
\date  Jan. 2011

\remarks

Uses the cmd structure to write a command buffer to the DIO device
at very high communication rate. This function with the abort statement
at the end is still experimental and is not really used so far.

*******************************************************************************
Function Parameters: [in]=input,[out]=output

\param[in]     buf  : the command buffer
\param[in]     n_buf: number of elements to write

******************************************************************************/
int
dio32_NI6259_write_cmd_buffer(int *buf, int n_buf)
{
  int i,j,rc;
  static unsigned long buf_size;
  unsigned long buf_left;
  static int *map = NULL;

  static int firsttime = TRUE;

  unsigned int chans[32]={
    0,1,2,3,4,5,6,7,
    8,9,10,11,12,13,14,15,
    16,17,18,19,20,21,22,23,
    24,25,26,27,28,29,30,31};

  a4l_cmd_t cmd = {
    .idx_subd = SUBDEV_DIO,
    .flags = 0,
    .start_src = TRIG_INT,    // internal trigger
    .start_arg = 0,
    .scan_begin_src = TRIG_EXT,
    .scan_begin_arg = NI_CDIO_SCAN_BEGIN_SRC_G0_OUT, // channel used to trigger the scans
    .convert_src = TRIG_NOW,
    .convert_arg = 0, /* in ns */
    .scan_end_src = TRIG_COUNT,
    .scan_end_arg = 32,
    .stop_src = TRIG_NONE,
    .stop_arg = 0,
    .nb_chan = 32,
    .chan_descs = chans,
  };

  a4l_insn_t insn = {
    .type = A4L_INSN_INTTRIG,
    .idx_subd = SUBDEV_DIO,
    .data_size = 0,
  };


  if (firsttime) {
    firsttime = FALSE;

    // map the communication buffer to user space

    // Get the buffer size to map
    rc = a4l_get_bufsize(&desc, SUBDEV_DIO, &buf_size);
    if (rc < 0) {
      printf("a4l_get_bufsize() failed (rc=%d)\n",rc);
      return FALSE;
    }

    // Map the subdevice buffer
    rc = a4l_mmap(&desc, SUBDEV_DIO, buf_size, (void *)&map);
    if (rc < 0) {
      printf("a4l_mmap() failed (rc=%d)\n",rc);
      return FALSE;
    }

  }

  // configure device in write mode
  rc = dio32_NI6259_config(ajcDATAMASK | ajcCTRLMASK,DIO_WRITE);
  if (rc < 0) {
    printf("write_cmd_buffer: dio32_NI6259_config failed (ret=%d)\n", rc);
    return FALSE;
  }

  // send the command
  rc = a4l_snd_command(&desc, &cmd);
  if (rc < 0) {
    printf("write_cmd_buffer: a4l_snd_command failed (ret=%d)\n", rc);
    return FALSE;
  }

  // write buf to the map buffer
  for (i=1; i<=n_buf; ++i)
    map[i-1] = buf[i];

  // tell the device the size of the data
  rc = a4l_mark_bufrw(&desc, SUBDEV_DIO, n_buf*sizeof(int), &buf_left);
  if (rc < 0) {
    printf("a4l_mark_bufrw() failed (rc=%d)\n",rc);
    return FALSE;
  }

  // trigger the communication
  rc = a4l_snd_insn(&desc, &insn);
  if (rc < 0)
    printf("ni_test: triggering failed (rc=%d)\n",rc);

  // check whether the device is busy and wait
  int count_busy = 0;
  const int max_count_busy = 1000;
  while ((rc = a4l_poll(&desc, SUBDEV_DIO, A4L_INFINITE)) > 0) { // wait for completion
    if (++count_busy > max_count_busy) {
      printf("write_cmd_buffer: dio32_NI6259_config too many (%d) EBUSY timeouts\n",
	     max_count_busy);
      return FALSE;
    }
    taskDelay(10000);
  }
  if (rc < 0 && rc!= -EPIPE) {
    printf("a4l_poll() failed (rc=%d)\n",rc);
    return FALSE;
  }

  return TRUE;

}

/*!*****************************************************************************
*******************************************************************************
\note  dio16_NI6259_read
\date  Feb 2010
 
\remarks 

reads from PFI device a 16 bit value with bit mask

*******************************************************************************
Function Parameters: [in]=input,[out]=output
 
\param[in]   mask    : which bits to read
\param[out]  val     : the value read
 
******************************************************************************/
inline int
dio16_NI6259_read(int mask, int *val) 
{
  int i;
  int rc;

  // configure the device to read mode
  for (i=0; i<16; ++i) {
    if ( ((1 << i) & mask) > 0) {
      if (dio16_channel_mode[i] != DIO_READ) {
	rc = a4l_config_subd(&desc,SUBDEV_PFI,A4L_INSN_CONFIG_DIO_INPUT,i);
	if (rc < 0) {
	  printf("dio16_NI6259_read: failed to configure DIO (rc=%d, channel %d)\n",rc,i);
	  return FALSE;
	}
	dio16_channel_mode[i] = DIO_READ;
      }
    }
  }

  // read the value
  rc = a4l_sync_dio(&desc, SUBDEV_PFI, &mask, val);
  if (rc < 0) {
    printf("dio16_NI6259_read: failed to communicate to DIO (rc=%d)\n",rc);
    return FALSE;
  }

  *val = (*val) & mask;

  return TRUE;
}

/*!*****************************************************************************
*******************************************************************************
\note  dio16_NI6259_write
\date  Feb 2010
 
\remarks 

writes to DIO device a 16 bit value with bit mask

*******************************************************************************
Function Parameters: [in]=input,[out]=output
 
\param[in]   mask    : which bits to write
\param[in]   val     : the value to write
 
******************************************************************************/
inline int
dio16_NI6259_write(int mask, int val) 
{
  int i;
  int rc;

  // configure the device channels to read mode if needed
  for (i=0; i<16; ++i) {
    if ( ((1 << i) & mask) > 0) {
      if (dio16_channel_mode[i] != DIO_WRITE) {
	rc = a4l_config_subd(&desc,SUBDEV_PFI,A4L_INSN_CONFIG_DIO_OUTPUT,i);
	if (rc < 0) {
	  printf("dio16_NI6259_write: failed to configure DIO (rc=%d, channel %d)\n",rc,i);
	  return FALSE;
	}
	dio16_channel_mode[i] = DIO_WRITE;
      }
    }
  }

  // write the value
  rc = a4l_sync_dio(&desc, SUBDEV_PFI, &mask, &val);
  if (rc < 0) {
    printf("dio16_NI6259_write: failed to communicate to DIO (rc=%d)\n",rc);
    return FALSE;
  }

  return TRUE;
}

/*!*****************************************************************************
*******************************************************************************
\note  dio16_NI6259_config
\date  Feb 2010
 
\remarks 

sets selected bits to read or write

*******************************************************************************
Function Parameters: [in]=input,[out]=output
 
\param[in]   mask    : which bits to write
\param[in]   mode    : DIO_READ or DIO_WRITE
 
******************************************************************************/
int
dio16_NI6259_config(int mask, int mode) 
{
  int i;
  int rc;

  // configure the device to read mode
  for (i=0; i<16; ++i) {
    if ( ((1 << i) & mask) > 0) {
      if (mode == DIO_READ) 
	rc = a4l_config_subd(&desc,SUBDEV_PFI,A4L_INSN_CONFIG_DIO_INPUT,i);
      else
	rc = a4l_config_subd(&desc,SUBDEV_PFI,A4L_INSN_CONFIG_DIO_OUTPUT,i);

      if (rc < 0) {
	if (rc == -EBUSY) {
	  return rc;
	} else {
	  printf("dio16_NI6259_config: failed to configure DIO (rc=%d, channel %d)\n",rc,i);
	  return FALSE;
	}
      }
      dio16_channel_mode[i] = mode;

    }
  }

  return TRUE;
}


--Apple-Mail=_11165E53-BA6E-438C-9EE0-441376BAA388
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii




--Apple-Mail=_11165E53-BA6E-438C-9EE0-441376BAA388--

