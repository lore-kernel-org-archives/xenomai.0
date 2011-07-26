MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 26 Jul 2011 11:17:34 +0200
From: wong <wong@domain.hid>
In-Reply-To: <20110721215420.GA2929@domain.hid>
References: <42ced071bc2bf4dbf2dc6f74746817be.squirrel@domain.hid>
	<be312d912dcaef8867b47d2e8aaa546b.squirrel@domain.hid>
	<20110721215420.GA2929@domain.hid>
Message-ID: <457bcb0b18e7b34f48e62890929464b5@domain.hid>
Subject: Re: [Xenomai-help] Analogy Differential Mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alexis Berlemont <alexis.berlemont@domain.hid>
Cc: xenomai@xenomai.org

Hi Alexis

Thanks for the information, I followed your advice and tried out the 
structure and the a4l_snd_command() but i received the error -EINVAL

I figured i must had made a mistake in the a4l_cmd_t cmd structure, so 
here's the specification of my card

channels: 16 channels single ended 8 channel differential
range: +10V -10V (range_number = 0)
subdevice: 0 (analog input)

I think the NI PCI-6034E supports differential mode as shown here in 
the "Specifications" tab

http://sine.ni.com/nips/cds/view/p/lang/en/nid/11916

I need to read 6 differential signals and the 6034E has 8 so this 
should be sufficient.

  /* The channel descriptor table */
  static unsigned int chans[MAX_NB_CHAN]; //The 6034E has 16 single 
ended and 8 differential so MAX_NB_CHAN = 8?


  /* The command to send  */
  a4l_cmd_t cmd = {
  	.idx_subd = ID_SUBD, /*ID_SUBD = 0 for analog input*/
  	.flags = 0,
  	.start_src = TRIG_NOW,
  	.start_arg = 0,
  	.scan_begin_src = TRIG_TIMER,
  	.scan_begin_arg = 8000000,	/* in ns */
  	.convert_src = TRIG_TIMER,
  	.convert_arg = 500000,	/* in ns */
  	.scan_end_src = TRIG_COUNT,
  	.scan_end_arg = 0,
  	.stop_src = TRIG_COUNT,
  	.stop_arg = NB_SCAN,
  	.nb_chan = 0,
  	.chan_descs = chans,
  };


I have some question regarding these members

1) .stop_arg = NB_SCAN,
Is this the number of scans to stop the acquisition? so theoretically a 
scan count of 1 should be fine?

2) .nb_chan = 0,
According to the comedilib this is the number of channels to be 
sampled, so in my case it should be 6? I noticed that if i put anything 
other than 0, 'dmesg' gives an error of

[ 4109.517562] Analogy: a4l_ioctl_cmd: driver's cmd_test failed


3) .chan_descs = chans,
I don't quite understand this, does this corresponds to the list of 
channels to be sampled? if I have 6 differential inputs how should i set 
the chans array with the following for loop


  for (i = 0; i < MAX_NB_CHAN; i++)
      chans[0] = PACK(0, 0, AREF(AREF_DIFF))
            |         |  |  |_reference flags
            |         |  |_range number
            |         |_channel number, shouldn't this be i?
            |___________ shouldn't this be i?



I can't seemed to find the ni_load_channelgain_list() function and how 
do you check whether the library supports diff mode or not?

Thanks again for your help

Regards
Chao






On Thu, 21 Jul 2011 23:54:20 +0200, Alexis Berlemont wrote:
> Hi,
>
> Wong Sheng Chao wrote:
>> Hi all
>>
>> I'm still trying to figure out how to configure my NI card to read 
>> voltage
>> signal in Differential Mode rather than single ended.
> Sorry. I skipped your mail without subject.
>
>>I had been reading
>> the API and it seems that I need to create a structure and define 
>> it's
>> member accordingly
>>
>> struct a4l_channel {
>> 	unsigned long flags; /*!< Channel flags to define the reference. */
>> 	unsigned long nb_bits; /*!< Channel resolution. */
>> };
>> typedef struct a4l_channel a4l_chan_t;
>>
>> with the member flags being one of the following,
>>
>> A4L_CHAN_AREF_GROUND 0x1
>> A4L_CHAN_AREF_COMMON 0x2
>> A4L_CHAN_AREF_DIFF 0x4
>> A4L_CHAN_AREF_OTHER 0x8
>>
>> and in my case A4L_CHAN_AREF_DIFF
>>
>> My question is which function should I use to send this structure to
>> configure the reference mode and where? I'm thinking it should be 
>> between
>> these two functions, but i'm still not sure how I can achieve this.
>>
>
> You should send a command structure thanks to a4l_snd_command().
>
> See 
> http://www.xenomai.org/documentation/xenomai-2.5/html/api/index.html:
>
> /* The channel descriptor table */
> static unsigned int chans[MAX_NB_CHAN];
>
> /* The command to send  */
> a4l_cmd_t cmd = {
> 	.idx_subd = ID_SUBD,
> 	.flags = 0,
> 	.start_src = TRIG_NOW,
> 	.start_arg = 0,
> 	.scan_begin_src = TRIG_TIMER,
> 	.scan_begin_arg = 8000000,	/* in ns */
> 	.convert_src = TRIG_TIMER,
> 	.convert_arg = 500000,	/* in ns */
> 	.scan_end_src = TRIG_COUNT,
> 	.scan_end_arg = 0,
> 	.stop_src = TRIG_COUNT,
> 	.stop_arg = NB_SCAN,
> 	.nb_chan = 0,
> 	.chan_descs = chans,
> };
>
> for (i = 0; i < ...; i++)
>     chans[0] = PACK(0, 0, AREF(AREF_DIFF))
>                     |  |  |_reference flags
>                     |  |_range number
>                     |_channel number
>
> By the way, I had a quick look into the pcimio driver and I am not
> sure that the driver supports differential mode for your
> card. According to the function ni_load_channelgain_list(), M series
> boards are OK (which is not the case, I think) and 611x models.
>
> If the card PCI_6034E support "diff" mode, the driver should be
> updated.
>
>> a4l_open();
>>
>> //configure differential mode here.
>>
>> a4l_fill();
>>
>>
>> My current setup is as follow
>> Distribution: Ubuntu 10.04
>> Linux kernel: 2.6.37.3
>> adeos patch: 2.9-00
>> xenomai: 2.5.6
>> DAQ card: National Instruments PCI_6034E
>>
>> Thanks
>> Chao
>>
>>
>>
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help


