Date: Fri, 8 Apr 2011 01:38:52 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20110407233852.GA4932@domain.hid>
References: <AANLkTi=1F27q2N32-mxVUD5HWAByUMN+z7baZWmO3oVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTi=1F27q2N32-mxVUD5HWAByUMN+z7baZWmO3oVA@mail.gmail.com>
Subject: Re: [Xenomai-help] [Xenomai-Help]Analogy counter support for
 NI-PCI6024E DAQ board
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Cristian Axenie <cristian.axenie@domain.hid>
Cc: xenomai@xenomai.org

Hi,

I apologize for being mute so long. Seriously, I could not find enough
free minutes to switch my computer on; and in the rare cases I succeed, I
fell asleep before entering my password. And I did not notice your
mail during the sporadic uses of a precarious internet connection.

Let's hope things are getting better.

Cristian Axenie wrote:
> Hello all!
> I am trying to test the general purpose counter, GPCT, on the NI PCI 6024E
> DAQ board using the latest snapshot of Xenomai-Analogy branch. Reading
> through previous post I didn't find any post regarding the configuration and
> read operation for simple event counter. Following the PCI E series Register
> Level Programmer Manual and the DAQ-STC manual I've managed to implement a
> counter setup function and a counter read function. Both are based on
> instructions but I have a problem with the values beeing read from the save
> register in the counter structure. To make it clear I am attaching the
> implemented functions.
> 
> The counter setup / initialization function :
> 
> int counter_setup(void)
> {
>   // return code
>   int rc;
>   // counter setup bits
>   lsampl_t counter_setup;
>   // number of read pulses on single event operation
>   unsigned int pulses;
>   // config data
>   unsigned int data[10];
>   // instruction instance
>   a4l_insn_t insn;
> 
>   // ensure clock disarm
>   insn.type      = A4L_INSN_CONFIG;
>   insn.idx_subd  = ID_SUBDEV_COUNTER;
>   insn.chan_desc = 0;
>   insn.data_size = sizeof(data[0])*2;
>   data[0]      = A4L_INSN_CONFIG_DISARM;
>   data[1]      = NI_GPCT_ARM_IMMEDIATE;
>   insn.data      = data;
> 
>   if((rc = a4l_snd_insn(&desc, &insn))<0){
>     fprintf(stderr,"counter setup: arm counter failed (rc=%d)\n",rc);
>   }
> 
>   // reset counter
>   insn.type      = A4L_INSN_CONFIG;
>   insn.idx_subd  = ID_SUBDEV_COUNTER;
>   insn.chan_desc = 0;
>   insn.data_size = sizeof(data[0]);
>   data[0]      = A4L_INSN_CONFIG_RESET;
>   insn.data      = data;
> 
>   if((rc = a4l_snd_insn(&desc, &insn))<0){
>     fprintf(stderr,"counter setup :  reset counter failed (rc=%d)\n",rc);
>   }
> 
>   // set counter mode bits
>   counter_setup  = NI_GPCT_COUNTING_MODE_NORMAL_BITS;
>   counter_setup |= NI_GPCT_COUNTING_DIRECTION_UP_BITS;
>   counter_setup |= NI_GPCT_NO_HARDWARE_DISARM_BITS;
>   counter_setup |= NI_GPCT_EDGE_GATE_NO_STARTS_NO_STOPS_BITS;
>   counter_setup |= NI_GPCT_DISABLED_GATE_SELECT;
> 
>   insn.type      = A4L_INSN_CONFIG;
>   insn.idx_subd  = ID_SUBDEV_COUNTER;
>   insn.chan_desc = 0;
>   insn.data_size = sizeof(data[0])*2;
>   data[0]      = A4L_INSN_CONFIG_SET_COUNTER_MODE;
>   data[1]      = counter_setup;
>   insn.data      = data;
> 
>   if((rc = a4l_snd_insn(&desc, &insn))<0){
>     fprintf(stderr,"counter setup: set counter mode failed (rc=%d)\n",rc);
>   }
> 
>   // arm the counter
>   insn.type      = A4L_INSN_CONFIG;
>   insn.idx_subd  = ID_SUBDEV_COUNTER;
>   insn.chan_desc = 0;
>   insn.data_size = sizeof(data[0])*2;
>   data[0]      = A4L_INSN_CONFIG_ARM;
>   data[1]      = NI_GPCT_ARM_IMMEDIATE;
>   insn.data      = data;
> 
>   if((rc = a4l_snd_insn(&desc, &insn))<0){
>     fprintf(stderr,"counter setup : arm counter failed (rc=%d)\n",rc);
>   }
> 
>    // read insn setup
>   insn.type      = A4L_INSN_READ;
>   insn.idx_subd  = ID_SUBDEV_COUNTER;
>   insn.chan_desc = 0;
>   insn.data_size = sizeof(data);
>   insn.data      = &data;
> 
>   if((rc = a4l_snd_insn(&desc, &insn))<0){
>     fprintf(stderr,"counter setup: read setup failed (rc=%d)\n",rc);
>   }
> }
> 
> And the counter read function :
> 
> long counter_read(){
>   // return code
>   int rc;
>   // single event pulses counter
>   long pulses;
>   // the read operation
>   if((rc = a4l_sync_read(&desc,ID_SUBDEV_COUNTER, 0, 0,&pulses, 4))<0){
>       fprintf(stderr,"counter reader : single event counting failed
> (rc=%d)\n",rc);
>   }
>   // return the number of pulses
>   return ((long)pulses - COUNTER_OFFSET);
> }
> 
> So my test program simply loops and reads the values from the counter. The
> problem is that I think I have some problems in the configuration bits
> because the values that are read from the counter aren't valid.
> A short preview :

Could you print the values in hexadecimal? With a bit of luck, that
might help to disclose a big / little endian issue. PCI devices are
little endian and if I remember well, you are using a PowerPC
micro-controller. 

> 
> val : -5419898
> val : -5418501
> val : -5417102
> val : -5415702
> val : -5414302
> val : -5412902
> val : -5411497
> val : -5410101
> .....
> val : 397603
> val : 398948
> val : 400293
> val : 401651
> val : 402998
> val : 404343
> val : 405687
> val : 407033
> ....
> val : -12501
> val : -11075
> val : -9650
> val : -8224
> val : -6795
> val : -4115
> val : -2297
> val : -869
> val : 552
> val : 1936
> val : 3311
> val : 4692
> val : 6061
> val : 7441
> val : 8819
> 
> Furthermore some of the configuration values are mapping the legacy Comedi
> configuration bits.
> The test I'm running to simulate the simple event input is based on a 1Hz
> pulse train applied on CTRSRC0/PFI8 and another thing is that the counting
> never stops.
> Certainly it is a configuration problem or a flaw in the function design or
> am I missing something ? Any suggestions will be appreciated.
> 
> Best,
> Cristian

> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Alexis.

