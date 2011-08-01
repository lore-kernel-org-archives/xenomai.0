MIME-Version: 1.0
In-Reply-To: <457bcb0b18e7b34f48e62890929464b5@domain.hid>
References: <42ced071bc2bf4dbf2dc6f74746817be.squirrel@domain.hid>
	<be312d912dcaef8867b47d2e8aaa546b.squirrel@domain.hid>
	<20110721215420.GA2929@domain.hid>
	<457bcb0b18e7b34f48e62890929464b5@domain.hid>
Date: Mon, 1 Aug 2011 23:56:49 +0200
Message-ID: <CAMesUR6w2NLFKGRg_pX7SyJW8-bbinXf+r8pV+3TvDte7Bu+vQ@mail.gmail.com>
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: wong <wong@domain.hid>
Cc: xenomai@xenomai.org

Hi,

Sorry for the late reply, I am currently on holidays.

On Tue, Jul 26, 2011 at 11:17 AM, wong <wong@domain.hid> wrote:
> Hi Alexis
>
> Thanks for the information, I followed your advice and tried out the
> structure and the a4l_snd_command() but i received the error -EINVAL
>
> I figured i must had made a mistake in the a4l_cmd_t cmd structure, so
> here's the specification of my card
>
> channels: 16 channels single ended 8 channel differential
> range: +10V -10V (range_number =3D 0)
> subdevice: 0 (analog input)
>
> I think the NI PCI-6034E supports differential mode as shown here in the
> "Specifications" tab
>
> http://sine.ni.com/nips/cds/view/p/lang/en/nid/11916
>
> I need to read 6 differential signals and the 6034E has 8 so this should =
be
> sufficient.
>
> =A0/* The channel descriptor table */
> =A0static unsigned int chans[MAX_NB_CHAN]; //The 6034E has 16 single ende=
d and
> 8 differential so MAX_NB_CHAN =3D 8?
>
>
> =A0/* The command to send =A0*/
> =A0a4l_cmd_t cmd =3D {
> =A0 =A0 =A0 =A0.idx_subd =3D ID_SUBD, /*ID_SUBD =3D 0 for analog input*/
> =A0 =A0 =A0 =A0.flags =3D 0,
> =A0 =A0 =A0 =A0.start_src =3D TRIG_NOW,
> =A0 =A0 =A0 =A0.start_arg =3D 0,
> =A0 =A0 =A0 =A0.scan_begin_src =3D TRIG_TIMER,
> =A0 =A0 =A0 =A0.scan_begin_arg =3D 8000000, =A0 =A0 =A0/* in ns */
> =A0 =A0 =A0 =A0.convert_src =3D TRIG_TIMER,
> =A0 =A0 =A0 =A0.convert_arg =3D 500000, =A0/* in ns */
> =A0 =A0 =A0 =A0.scan_end_src =3D TRIG_COUNT,
> =A0 =A0 =A0 =A0.scan_end_arg =3D 0,
> =A0 =A0 =A0 =A0.stop_src =3D TRIG_COUNT,
> =A0 =A0 =A0 =A0.stop_arg =3D NB_SCAN,
> =A0 =A0 =A0 =A0.nb_chan =3D 0,
> =A0 =A0 =A0 =A0.chan_descs =3D chans,
> =A0};
>
>
> I have some question regarding these members
>
> 1) .stop_arg =3D NB_SCAN,
> Is this the number of scans to stop the acquisition? so theoretically a s=
can
> count of 1 should be fine?
>

Theoretically yes.

> 2) .nb_chan =3D 0,
> According to the comedilib this is the number of channels to be sampled, =
so
> in my case it should be 6? I noticed that if i put anything other than 0,
> 'dmesg' gives an error of
>
> [ 4109.517562] Analogy: a4l_ioctl_cmd: driver's cmd_test failed

There is nothing else, just  before this line. If my memories are
correct the reason why the test of your command failed should be
indicated. If that is not the case, there is a bug. Tell me and I will
look at it.

>
>
> 3) .chan_descs =3D chans,
> I don't quite understand this, does this corresponds to the list of chann=
els
> to be sampled? if I have 6 differential inputs how should i set the chans
> array with the following for loop
>
>
> =A0for (i =3D 0; i < MAX_NB_CHAN; i++)
> =A0 =A0 chans[0] =3D PACK(0, 0, AREF(AREF_DIFF))
> =A0 =A0 =A0 =A0 =A0 | =A0 =A0 =A0 =A0 | =A0| =A0|_reference flags
> =A0 =A0 =A0 =A0 =A0 | =A0 =A0 =A0 =A0 | =A0|_range number
> =A0 =A0 =A0 =A0 =A0 | =A0 =A0 =A0 =A0 |_channel number, shouldn't this be=
 i?
> =A0 =A0 =A0 =A0 =A0 |___________ shouldn't this be i?
>
>

  for (i =3D 0; i < 6; i++)
     chans[0] =3D PACK(i, the_range_you_want, AREF(AREF_DIFF))

No?

>
> I can't seemed to find the ni_load_channelgain_list() function and how do
> you check whether the library supports diff mode or not?
>

ni_load_channelgain_list() function is located in the driver source:
ksrc/drivers/analogy/national_instruments/mio_common.c.

If I remember well, even if the hardware specifications tell that your
board supports differential mode, this function does not.

> Thanks again for your help
>
> Regards
> Chao
>
>

Alexis.

>
>
>
>
> On Thu, 21 Jul 2011 23:54:20 +0200, Alexis Berlemont wrote:
>>
>> Hi,
>>
>> Wong Sheng Chao wrote:
>>>
>>> Hi all
>>>
>>> I'm still trying to figure out how to configure my NI card to read
>>> voltage
>>> signal in Differential Mode rather than single ended.
>>
>> Sorry. I skipped your mail without subject.
>>
>>> I had been reading
>>> the API and it seems that I need to create a structure and define it's
>>> member accordingly
>>>
>>> struct a4l_channel {
>>> =A0 =A0 =A0 =A0unsigned long flags; /*!< Channel flags to define the re=
ference.
>>> */
>>> =A0 =A0 =A0 =A0unsigned long nb_bits; /*!< Channel resolution. */
>>> };
>>> typedef struct a4l_channel a4l_chan_t;
>>>
>>> with the member flags being one of the following,
>>>
>>> A4L_CHAN_AREF_GROUND 0x1
>>> A4L_CHAN_AREF_COMMON 0x2
>>> A4L_CHAN_AREF_DIFF 0x4
>>> A4L_CHAN_AREF_OTHER 0x8
>>>
>>> and in my case A4L_CHAN_AREF_DIFF
>>>
>>> My question is which function should I use to send this structure to
>>> configure the reference mode and where? I'm thinking it should be betwe=
en
>>> these two functions, but i'm still not sure how I can achieve this.
>>>
>>
>> You should send a command structure thanks to a4l_snd_command().
>>
>> See http://www.xenomai.org/documentation/xenomai-2.5/html/api/index.html=
:
>>
>> /* The channel descriptor table */
>> static unsigned int chans[MAX_NB_CHAN];
>>
>> /* The command to send =A0*/
>> a4l_cmd_t cmd =3D {
>> =A0 =A0 =A0 =A0.idx_subd =3D ID_SUBD,
>> =A0 =A0 =A0 =A0.flags =3D 0,
>> =A0 =A0 =A0 =A0.start_src =3D TRIG_NOW,
>> =A0 =A0 =A0 =A0.start_arg =3D 0,
>> =A0 =A0 =A0 =A0.scan_begin_src =3D TRIG_TIMER,
>> =A0 =A0 =A0 =A0.scan_begin_arg =3D 8000000, =A0 =A0 =A0/* in ns */
>> =A0 =A0 =A0 =A0.convert_src =3D TRIG_TIMER,
>> =A0 =A0 =A0 =A0.convert_arg =3D 500000, =A0/* in ns */
>> =A0 =A0 =A0 =A0.scan_end_src =3D TRIG_COUNT,
>> =A0 =A0 =A0 =A0.scan_end_arg =3D 0,
>> =A0 =A0 =A0 =A0.stop_src =3D TRIG_COUNT,
>> =A0 =A0 =A0 =A0.stop_arg =3D NB_SCAN,
>> =A0 =A0 =A0 =A0.nb_chan =3D 0,
>> =A0 =A0 =A0 =A0.chan_descs =3D chans,
>> };
>>
>> for (i =3D 0; i < ...; i++)
>> =A0 =A0chans[0] =3D PACK(0, 0, AREF(AREF_DIFF))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0| =A0|_reference flags
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0|_range number
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|_channel number
>>
>> By the way, I had a quick look into the pcimio driver and I am not
>> sure that the driver supports differential mode for your
>> card. According to the function ni_load_channelgain_list(), M series
>> boards are OK (which is not the case, I think) and 611x models.
>>
>> If the card PCI_6034E support "diff" mode, the driver should be
>> updated.
>>
>>> a4l_open();
>>>
>>> //configure differential mode here.
>>>
>>> a4l_fill();
>>>
>>>
>>> My current setup is as follow
>>> Distribution: Ubuntu 10.04
>>> Linux kernel: 2.6.37.3
>>> adeos patch: 2.9-00
>>> xenomai: 2.5.6
>>> DAQ card: National Instruments PCI_6034E
>>>
>>> Thanks
>>> Chao
>>>
>>>
>>>
>>>
>>> _______________________________________________
>>> Xenomai-help mailing list
>>> Xenomai-help@domain.hid
>>> https://mail.gna.org/listinfo/xenomai-help
>
>

