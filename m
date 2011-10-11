MIME-Version: 1.0
In-Reply-To: <CAMwkeZyPorMx9n1Y8YAEJE4hUh49=u9Mr_tj7qzYAnquMa60rw@domain.hid>
References: <CAMwkeZy-9Qw0LALq8rrJQKET_Bu7UHgu8YYoFw1z6jdS687fBg@domain.hid>
	<CAGc_wL172OGHZ-8SG8e77Fp5qwHqKvTY610aQsr3WA_bp+3HRg@domain.hid>
	<CAMwkeZyvyhHPZTWz1LiaOhWA9TdrQaXMo833Ej5JRwJR3Da2xw@domain.hid>
	<CAMwkeZxinGD8_yEYmo+ySHx9dzU6hEM4BFH4jejnTMd87f0M9Q@mail.gmail.com>
	<CAMesUR4+G-Bx9tDUPajp4EcKP70zLvQuLyjLeyNpfyrmCpwBBw@domain.hid>
	<CAMwkeZyQwtJbcMjOiSnmzoRDud+4=6Nt2NOcEdFG_+1QVSHoSQ@mail.gmail.com>
	<CAMwkeZzajkK7gRYH5cnAW1-5HvgxQyUogDZKpms1FUyLtwxpdg@domain.hid>
	<CAMesUR67RpFHRiNcd-yfR9WF2FRe1U3yBdXWP2dU30aQovCHKQ@mail.gmail.com>
	<CAMwkeZxybKS+-B2C_yaYX3_XSYnAKcj8xfX_YOgQ6Kt=mNTzJQ@mail.gmail.com>
	<CAMwkeZzrfuB1Uf7f1eqG8zEvgeYMXrRspzUANeOaJR2qQUmhOQ@mail.gmail.com>
	<CAMesUR5AvmUDW8wq4e9EtOgnpRtMD_qe8rQe7acgFT6KzdeYAg@domain.hid>
	<CAMwkeZxAvBeY=0c49N+QtUYCKCTiGo4yc9TAEQPLJAJmBXPn+A@mail.gmail.com>
	<CAMesUR59KFH=hjpo=fr8DCHeg50driuitcikc5HfHTZWG5ct8A@mail.gmail.com>
	<CAMwkeZyPorMx9n1Y8YAEJE4hUh49=u9Mr_tj7qzYAnquMa60rw@domain.hid>
Date: Wed, 12 Oct 2011 00:12:30 +0200
Message-ID: <CAMesUR5PsVLb16ZR1bdcbDWdUfvPxViPng+rD7mjQqy1q+OGfA@mail.gmail.com>
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Command code working with comedi not working
	with analogy
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Fernando_Herrero_Carr=F3n?= <elferdo@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Hi,

Sorry for answering late.

2011/10/10 Fernando Herrero Carr=F3n <elferdo@domain.hid>:
>
>
> El 7 de octubre de 2011 19:06, Alexis Berlemont <alexis.berlemont@domain.hid=
om>
> escribi=F3:
>>
>> Hi,
>>
>> 2011/10/7 Fernando Herrero Carr=F3n <elferdo@domain.hid>:
>> > El 6 de octubre de 2011 18:31, Alexis Berlemont
>> > <alexis.berlemont@domain.hid>
>> > escribi=F3:
>> >>
>> >> Hi,
>> >>
>> >> 2011/10/6 Fernando Herrero Carr=F3n <elferdo@domain.hid>:
>> >> >
>> >> >
>> >> > El 5 de octubre de 2011 20:06, Fernando Herrero Carr=F3n
>> >> > <elferdo@domain.hid>
>> >> > escribi=F3:
>> >> >>
>> >> >> El 5 de octubre de 2011 18:16, Alexis Berlemont
>> >> >> <alexis.berlemont@domain.hid> escribi=F3:
>> >> >>>
>> >> >>> I think the problem might be located at two different places:
>> >> >>> 1) Either the DMA controller is badly configured and it copies th=
e
>> >> >>> properly acquired values to wrong places.
>> >> >>> 2) Or the DAQ-STC module is badly configured; so, the =A0DMA
>> >> >>> controller
>> >> >>> copies the wrong values to right places.
>> >> >>>
>> >> >>> Concerning the alternative 1, I think it is not the most probable
>> >> >>> one.
>> >> >>> Why? Because, the DMA controller (the MITE) is configured the sam=
e
>> >> >>> way
>> >> >>> whatever the NI acquisition board holds it (or nearly).
>> >> >>> To check this idea: let's make a little test with cmd_read.
>> >> >>>
>> >> >>> If cmd_read is launched with the option -m (map), we get direct
>> >> >>> access, in user space, to the memory area the DMA controller is
>> >> >>> supposed to shot to.
>> >> >>>
>> >> >>> So, just after a4l_mmap (before the DMA controller shots anything=
):
>> >> >>> 367: =A0 =A0 =A0 =A0 =A0 =A0/* Map the analog input subdevice buf=
fer */
>> >> >>> 368: =A0 =A0 =A0 =A0 =A0 =A0ret =3D a4l_mmap(&dsc, cmd.idx_subd, =
buf_size, &map);
>> >> >>> you can have a look at the values hold by the buffer:
>> >> >>> - If the values are already 0x8000, we might conclude that the DM=
A
>> >> >>> controller does not send anything there.
>> >> >>> - If the values are not 0x8000, then we are sure that the DMA
>> >> >>> controller does behave as expected. Consequently we can skip
>> >> >>> alternative 1) and focus on the second one.
>> >> >>>
>> >> >>> If the DAQ is not properly configured; things are getting a littl=
e
>> >> >>> bit
>> >> >>> simpler (if we have the documentation /. developer manual of your
>> >> >>> acquisition card). We just have to find which stuff was not
>> >> >>> properly
>> >> >>> configured. =A0A simple solution could be the monitoring of the
>> >> >>> status
>> >> >>> registers. In such a case, I can send you a patch which will dump
>> >> >>> the
>> >> >>> content of these registers.
>> >> >>>
>> >> >>> But before going that way, could you make the test with cmd_read =
+
>> >> >>> mmap?
>> >> >>>
>> >> >>> Regards,
>> >> >>>
>> >> >>> Alexis.
>> >> >>
>> >> >> Ok, I'll check those tomorrow. From what I recall, I checked
>> >> >> cmd_read
>> >> >> just
>> >> >> passing the '-m' option and resulted in the same behaviour, but I'=
ll
>> >> >> recheck
>> >> >> tomorrow.
>> >> >>
>> >> >> What I find somewhat surprising is that I got it working with
>> >> >> comedi,
>> >> >> so I
>> >> >> guess that the register programming should also be working with
>> >> >> analogy. The
>> >> >> only difference I have managed to find so far between the analogy
>> >> >> and
>> >> >> the
>> >> >> comedi drivers, besides generic buffer management, is that comedi
>> >> >> appears to
>> >> >> handle DMA through the "generic device" interface (as in
>> >> >> http://www.mjmwired.net/kernel/Documentation/DMA-API.txt) and
>> >> >> analogy
>> >> >> handles DMA through the PCI interface (as in
>> >> >>
>> >> >>
>> >> >> http://m8-android-kernel.googlecode.com/svn/trunk/Documentation/DM=
A-mapping.txt).
>> >> >> But this is merely speculation.
>> >> >>
>> >> >> I'll look tomorrow at your two options in more detail.
>> >> >>
>> >> >> Thanks for your help!
>> >> >> Fernando
>> >> >
>> >> > Dear Alexis,
>> >> >
>> >> > I just repeated the tests with mmap.
>> >> >
>> >> > Running the provided example of "cmd_read" with either "-m" or "-m
>> >> > -r"
>> >> > only
>> >> > dumps the 0x8000 value. _Sometimes_, very rarely, I can get to see
>> >> > different
>> >> > values not far from that one, but if I get to plot it it just looks
>> >> > like
>> >> > noise. I don't know what is causing those values and I cannot
>> >> > reproduce
>> >> > the
>> >> > conditions for them.
>> >> >
>> >> > Now I used gdb to step through the process (with my own code) and
>> >> > here
>> >> > is
>> >> > the sequence:
>> >> >
>> >> > -=A0 I run up to the line where the "mmapping" happens. I check tha=
t
>> >> > map
>> >> > =3D=3D
>> >> > NULL and after I run the "mmap()" it gets a different value and ret
>> >> > =3D=3D
>> >> > 0,
>> >> > ok.
>> >> >
>> >> > - I do a
>> >> > print *(unsigned short *)map@domain.hid
>> >> >
>> >> > =A0 to dump the contents of the buffer and it is all filled with ze=
roes
>> >> > at
>> >> > this point.
>> >> >
>> >> > - I setup my command structure like this:
>> >> >
>> >> > =A0=A0=A0 cmd.idx_subd =3D 0;
>> >> > =A0=A0=A0 cmd.start_src =3D TRIG_NOW;
>> >> > =A0=A0=A0 cmd.start_arg =3D 0;
>> >> > =A0=A0=A0 cmd.flags =3D TRIG_WAKE_EOS;
>> >> > =A0=A0=A0 cmd.scan_begin_src =3D TRIG_TIMER;
>> >> > =A0=A0=A0 cmd.scan_begin_arg =3D 1e9 / INPUT_FREQ;
>> >> > =A0=A0=A0 cmd.convert_src =3D TRIG_NOW;
>> >> > =A0=A0=A0 cmd.convert_arg =3D 0;
>> >> > =A0=A0=A0 cmd.chan_descs =3D chanlist;
>> >> > =A0=A0=A0 cmd.nb_chan =3D NICHAN;
>> >> > =A0=A0=A0 cmd.scan_end_src =3D TRIG_COUNT;
>> >> > =A0=A0=A0 cmd.scan_end_arg=A0=A0=A0 =3D NICHAN;
>> >> >
>> >> > =A0=A0=A0 cmd.stop_src =3D TRIG_COUNT;
>> >> > =A0=A0=A0 cmd.stop_arg =3D SAMPLE_HISTORY;
>> >> >
>> >> > with
>> >> >
>> >> > INPUT_FREQ =3D 1000 (1kHz)
>> >> > NICHAN =3D 1=A0=A0 (I have also tried 4 and 8 with no difference in
>> >> > results)
>> >> >
>> >> > and call the a4l_snd_command() function, which returns without
>> >> > errors.
>> >> >
>> >> > I dump the contents of the buffer and it is still filled with zeroe=
s.
>> >> >
>> >> > - I declare
>> >> >
>> >> > unsigned long front =3D 0;
>> >> >
>> >> > and call
>> >> >
>> >> > ret =3D a4l_mark_bufrw(&dev_input, 0, front, &front);
>> >> >
>> >> > at this point the buffer gets filled with 0x8000:
>> >> >
>> >> >
>> >> > (gdb) print *(unsigned short *)map@domain.hid $1 =3D {0 <repeats 100 times=
>}
>> >> > (gdb) n=A0=A0=A0=A0 <------------------ calls a4l_mark_bufrw()
>> >> >
>> >> > 186=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if (front =3D=3D 0) {
>> >> >
>> >> > (gdb) print /x*(unsigned short *)map@domain.hid
>> >> > $2 =3D {0x8000 <repeats 100 times>}
>> >> >
>> >> > Now I find it funny that the value read is always the same. Could i=
t
>> >> > be
>> >> > that
>> >> > everything is working fine and it is the board itself that is
>> >> > transferring
>> >> > that value? Could it be an indicator for an error condition?
>> >>
>> >> I don't think it is an error indicator; errors are reported in
>> >> dedicated status registers.
>> >>
>> >
>> > Yep, you're right on that one...
>> >
>> >>
>> >> If I understand correctly, most of the times you acquire 0x8000 and a
>> >> few times other values. That could mean that 0x8000 values are really
>> >> produced by the ADC converter. By the way, 0x8000 is not a meaningles=
s
>> >> value (0x0000 - 0xFFFF median). I don't know which range was selected
>> >> (-5V / 5V by default?) but it could mean that the card is acquiring a
>> >> continuous 0V signal.
>> >
>> >
>> >>
>> >> Which channel are you using?
>> >> Could you test each channel separately and all of them at once?
>> >> Could try another range? 0V / 5V could be a great candidate: with thi=
s
>> >> one the acquired values could be 0x0000 instead of 0x8000.
>> >>
>> >
>> > That makes sense, but with insn_read I get the right waveshape, with t=
he
>> > same setup. I am reading a 3Hz, 3V input signal. Unfortunately, this
>> > board
>> > reports only one possible range. The output of cmd_read -v reports:
>> >
>> > cmd_read: device analogy0 opened (fd=3D0)
>> > cmd_read: basic descriptor retrieved
>> > =A0=A0=A0 =A0subdevices count =3D 14
>> > =A0=A0=A0 =A0read subdevice index =3D 0
>> > =A0=A0=A0 =A0write subdevice index =3D 0
>> > cmd_read: complex descriptor retrieved
>> > cmd_read: channel 0
>> > =A0=A0=A0 =A0ranges count =3D 1
>> > =A0=A0=A0 =A0bit width =3D 16 (bits)
>> >
>> > Now here goes a crazy thing. I modified
>> > ksrc/drivers/analogy/national_instruments/mio_common.c:ni_ai_cmd() so
>> > that
>> > every time a command is issued the buffer is filled with 0x0f. That is=
,
>> > I
>> > added the following line:
>> >
>> > =A0=A0=A0 memset(subd->buf->buf, 0x0f, subd->buf->size);
>> >
>> > Now I repeat the same sequence as in my previous mail with gdb:
>> >
>> > - Map the buffer, check address and content (buffer has some leftovers
>> > from
>> > previous runs)
>> >
>> > ret =3D a4l_mmap(&dev_input, 0, buf_size, &map);
>> >
>> > (gdb) print map
>> > $1 =3D (void *) 0x7ffff7fc8000
>> > (gdb) print /x*(unsigned short *)map@domain.hid
>> > $2 =3D {0x600, 0x5e04, 0x0 <repeats 98 times>}
>> >
>> > - Issue the command and recheck contents. Now the buffer is filled wit=
h
>> > 0x0f0f
>> >
>> > (gdb) n
>> > 173=A0=A0=A0 =A0=A0=A0 setup_input_card(&dev_input);
>> >
>> > (gdb) n
>> > Channel 0 has 16 bits and 1 different ranges
>> > 175=A0=A0=A0 =A0=A0=A0 unsigned long front =3D 0;
>> >
>> > (gdb) print /x*(unsigned short *)map@domain.hid
>> > $3 =3D {0xf0f <repeats 100 times>}
>> >
>> > - Call a4l_mark_bufrw() and recheck contents. 70 samples have changed
>> > values, 30 remain the same. In those samples that changed value, only
>> > one
>> > bit changed!!
>> >
>> > (gdb) n
>> > 177=A0=A0=A0 =A0=A0=A0 for(int scan =3D 0; scan < SAMPLE_HISTORY; scan=
++)
>> >
>> > (gdb) n
>> > 180=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ret =3D a4l_mark_bufrw(&dev_input, 0,=
 front, &front);
>> >
>> > (gdb) n
>> > 186=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if (front =3D=3D 0) {
>> >
>> > (gdb) print /x*(unsigned short *)map@domain.hid
>> > $4 =3D {0x8f0f <repeats 70 times>, 0xf0f <repeats 30 times>}
>> >
>> > So there is either an 'or' operation or an addition operation with
>> > 0x8000
>> > that is changing those values. As you said, 0x8000 is a very
>> > representative
>> > value. It represents zero on a 16 DAQ like mine, and it is also a valu=
e
>> > used
>> > as a mask in various places:
>> >
>> > ./ksrc/drivers/analogy/national_instruments/ni_stc.h:#define
>> > _bit15=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x8000
>> > ./ksrc/drivers/analogy/national_instruments/ni_stc.h:#define
>> > Calibration_Channel_6143_RelayOn=A0=A0 0x8000 (which happens to be my
>> > DAQ...)
>> >
>> > Running cmd_read only yields the 0x8f0f value now, by the way.
>> >
>> > I now it's hard to imagine what is happening without having the board
>> > yourself, so I really appreciate your help.
>>
>> I may have an idea thanks to your additional test. I cant' figure out
>> how a DMA controller could perform a or / add operation on memory with
>> one single write shot; so, this operation must be done by the CPU.
>>
>> The only way for the CPU to interfere is through a munge operaiton,
>> let's have a look at ni_ai_munge16:
>>
>> static void ni_ai_munge16(a4l_subd_t *subd, void *buf, unsigned long siz=
e)
>> {
>> =A0 =A0 =A0 =A0a4l_dev_t *dev =3D subd->dev;
>> =A0 =A0 =A0 =A0a4l_cmd_t *cmd =3D a4l_get_cmd(subd);
>> =A0 =A0 =A0 =A0int chan_idx =3D a4l_get_chan(subd);
>> =A0 =A0 =A0 =A0unsigned int i;
>> =A0 =A0 =A0 =A0sampl_t *array =3D buf;
>>
>> =A0 =A0 =A0 =A0for (i =3D 0; i < size / sizeof(sampl_t); i++) {
>> #if (defined(CONFIG_XENO_DRIVERS_ANALOGY_NI_MITE) || \
>> =A0 =A0 defined(CONFIG_XENO_DRIVERS_ANALOGY_NI_MITE_MODULE))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0array[i] =3D le16_to_cpu(array[i]);
>> #endif /* CONFIG_XENO_DRIVERS_ANALOGY_NI_MITE */
>>
>> ###### HERE
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0array[i] +=3D devpriv->ai_offset[chan_idx=
];
>> ######## HERE
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chan_idx++;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chan_idx %=3D cmd->nb_chan;
>> =A0 =A0 =A0 =A0}
>> }
>>
>> According to the code in ni_load_channelgain_list, I think ai_offset
>> is set to 0x8000 in your case.
>>
>> Could you empty the function ni_ai_munge16 and check that the buffer
>> is not modified anymore?
>>
>> If it is the case, let's go back to your first theory: the DMA controlle=
r.
>>
>
> Dear Alexis,
>
> Yes, I commented out that line you mentioned and indeed the buffer is now
> filled with 0x0f0f instead of 0x8f0f. So yes, I still suspect it has to d=
o
> with the DMA transfers.
>
> Recalling, it seems that everything is working with the DMA except this v=
ery
> point. I mean, I set my board to transfer data at the end of every scan
> (with .flags =3D TRIG_WAKE_EOS) and I program a given frequency, say 1kHz=
. The
> dmesg reports an interrupt from the board with the right timing and my
> "a4l_async_read()" call gets unblocked apparently with the right timing a=
s
> well. At the end of buffer.c:a4l_buf_evt() I dump the value of "count",
> which reports the number of bytes transferred in the current event, and i=
t
> reports the expected value (except in some cases, which I will comment on=
 a
> separate mail).
>
> So I would like to check the following points:
>
> - Check that the subdevice's buffer is properly configured when the devic=
e
> is set up and/or when the command is launched.
>
> - Check that the DMA programming is actually using that buffer.
>
> - Check that the read operation is accessing the right buffer as well.
>
> I can't think of many other things going wrong. While writing this email =
I
> have thought of some further tests, so here is the result :)
>
> I have changed the size of the default buffer using analogy_config. First=
, I
> have specified:
>
> sudo /usr/xenomai/sbin/analogy_config -v analogy0 -S 4
>
> Then I have run cmd_read, with the same results, but I have dumped some
> values at "ni_ai_setup_MITE_dma()" and at a4l_buf_evt():
>
> [ 3115.793026] Analogy: analogy_ni_pcimio: ni_ai_setup_MITE_dma: beginnin=
g
> [ 3115.793029] Analogy: analogy_ni_pcimio: ni_ai_setup_MITE_dma: buf->buf=
:
> ffffc90001893000; buf->end_count 800; buf->prd_count 0; buf->cns_count 0;
> buf->tmp_count 0
> [ 3115.793035] Analogy: analogy_ni_pcimio: ni_ai_cmd: exit
> [ 3116.593187] Analogy: analogy_ni_pcimio: ni_mio_common: interrupt:
> a_status=3D90f0 ai_mite_status=3D00200000
> [ 3116.593189] Analogy: analogy_ni_pcimio: ni_mio_common: SC_TC interrupt
> [ 3116.593191] Analogy: Signalling event. Available data to user: 800. Tw=
o
> first bytes in buffer: 15d 15d. Buffer pointer: ffffc90001893000
>
> Now I changed the size of the buffer to 8, which aparently resulted in a
> buffer reallocation:
>
> [ 3119.523172] Analogy: analogy_ni_pcimio: ni_ai_setup_MITE_dma: beginnin=
g
> [ 3119.523175] Analogy: analogy_ni_pcimio: ni_ai_setup_MITE_dma: buf->buf=
:
> ffffc9000189b000; buf->end_count 800; buf->prd_count 0; buf->cns_count 0;
> buf->tmp_count 0
> [ 3119.523181] Analogy: analogy_ni_pcimio: ni_ai_cmd: exit
> [ 3120.323332] Analogy: analogy_ni_pcimio: ni_mio_common: interrupt:
> a_status=3D90f0 ai_mite_status=3D00200000
> [ 3120.323335] Analogy: analogy_ni_pcimio: ni_mio_common: SC_TC interrupt
> [ 3120.323336] Analogy: Signalling event. Available data to user: 800. Tw=
o
> first bytes in buffer: 15d 15d. Buffer pointer: ffffc9000189b000
>
> I don't know if this is really useful, but this is proving that at least
> "ni_ai_setup_MITE_dma()" and "a4l_buf_evt()" are consistent in their noti=
on
> of buffer.
>

I took some time to compare both versions of code (comedi and
analogy). I did not find anything interesting in mite.c. I was about
to ask you to increase verbosity (debug + a specific patch) when I got
a glimpse on the allocation of the asynchronous buffer on the comedi
side.

The methods are not the same at that level:
- comedi: n * dma_alloc_coherent  + a vmap at the end
- analogy:  a big vmalloc + n * page_to_phys(vmalloc_to_page(vaddr)

I don't understand the reason why the analogy way is not correct, I
did not have time to check yet. If anyone has any idea, please help
me.

However, the NI mite expects 32 bit addresses... (because of
cpu_to_le32 in the mite driver).

If I remember well, you are using a 64-bit architecture. Is it
correct? There may be a bug here; analogy might give to the mite
physical addresses which are not below 2^32.

So, could you:
- with comedi, add some printk("%lx") in mite_buf_change so as to dump
the pages physical addresses
- with analogy, do the same thing in a4l_mite_buf_change.

Or you can test on another machine.

So far, I got only remote access on a 32 bit machine in which there is
a NI card; I must have missed something...

> Best regards,
> Fernando
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>

Best regards,

Alexis.

