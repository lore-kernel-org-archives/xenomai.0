Date: Tue, 13 Jul 2010 00:29:26 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20100712222926.GA2463@domain.hid>
References: <20100627103712.GA2565@domain.hid>
	<46F86785-737D-41F4-BC37-5DC5A4462039@domain.hid>
	<20100630134535.GA2849@domain.hid>
	<B09D50F0-3A7A-4501-8E96-C5E67AE11D19@domain.hid>
	<20100705214047.GB2444@domain.hid>
	<20100705220238.GC2444@domain.hid>
	<5A2DB1C3-C660-45BE-9743-716F63C11825@domain.hid>
	<20100709221733.GC10254@domain.hid>
	<5BACCC6E-A481-4953-ABAC-ACE3185E1A9C@usc.edu>
	<3712D196-B8B5-430C-A5F5-189C77F76997@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3712D196-B8B5-430C-A5F5-189C77F76997@domain.hid>
Subject: Re: [Xenomai-core] analogy - experimental branch
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Schaal <sschaal@domain.hid>
Cc: Peter Pastor Sampedro <pastorsa@domain.hid>, xenomai@xenomai.org

Hi,

Stefan Schaal wrote:
> Hi Alexis,
> 
>   I guess I slowly understand that my clocking signal connected to
>   scan_begin_arg has to come from an external DIO input, if
>   scan_bigin_src = TRIG_EXT, and that the insn instruction is still
>   needed to trigger the entire acquisition. 

Yes. The trigger instruction is needed so as to start the whole
acquisition (which is composed of many scans). A periodic external
signal is needed so as to trigger each scan.

> 
>   Alternatively, would it be possible to use the internal clocking signals like 
> 
> scan_bigin_src = TRIG_FOLLOW
> 
> or 
> 
> scan_bigin_src = TRIG_TIMER

I think you are right. If the sampling clock comes from another
subdevice, TRIG_EXT may not be the most appropriate constant. However,
the original comedi driver only expects TRIG_EXT even if... the
sampling signal is not external.

TRIG_TIMER does not seem suitable because it assumes an independant
sampling clock is available.  

And TRIG_FOLLOW may be the most appropriate one. We should modify the
driver so that TRIG_FOLLOW is used if the analog sampling clock is
chosen.

> 
> 
> if I try any of these sources, I get an error -22, and dmesg reports:
> 
> [195882.321300] Analogy: a4l_check_cmddesc: scan_begin_src, trigger unsupported
> 

For me, the command interface is an empty shell because the various
parameters (start_src, scan_begin_src, ...) and the values (TRIG_*)
are imposed. And, on the other side, the driver is fully in charge of
the command structure as it is. So, the comedi command imposes a
communication method but does not ease the driver's task of managing
it (errors checking, translation, etc.)

And, in our case: DIO, we may conclude that this imposed API does not
fit well: in scan_begin_arg, we have to pass an index which is
supposed to correspond to some sampling clock (which is specific to a
board). Then, we use a generic interface with board-specific
arguments.

So, to sum up, I understand your point: the way we control the driver
may not always be the most appropriate one. But, we inherited from
comedi both the interface and the drivers. 

On my side, I am working on trying to implement (as a background task)
a generic interface a little bit more based on discovery (query /
enum) that would render the command interface obsolete. Unfortunately,
I have nothing interesting to show yet.

> Best wishes,
> 
> -STefan
> 
> 
> 
> 
> 
> On Jul 9, 2010, at 17:10, Stefan Schaal wrote:
> 
> > Hi Alexis,
> > 
> >  thanks a lot for the clarification. Thus, scan_begin_arg is set to the digital line that I would like to use as a trigger. The triggering itself has to happen by flipping the bit on this specific digital line, e.g., using a4l_sync_dio() on this specific line? I assume that I do not need to re-wire anything on my board.
> > 
> > In your cmd_bits.c code, you use the "a4l_insn_t insn" structure below for triggering, which is what I have to replace with a4l_sync_dio(), I guess?
> > 
> > Best wishes,
> > 
> > -Stefan
> > 
> > 
> > 
> > On Jul 9, 2010, at 15:17, Alexis Berlemont wrote:
> > 
> >> Stefan Schaal wrote:
> >>> Hi Alexis,
> >>> 
> >>> I conceptually understand what you are telling us, but I am bit confused how to implement your advice:
> >>> 
> >>>> So, Stefan, here is a quick solution:
> >>>> 
> >>>> if you have access to your board you can choose one of these signals
> >>>> (in which a regular pulse is occuring) and you can modify accordingly
> >>>> the field scan_begin_arg of the structure a4l_cmd_t in cmd_bits.c. 
> >>> 
> >>> The data structures in question are:
> >>> 
> >>> /* The command to send by default */
> >>> a4l_cmd_t cmd = {
> >>> 	.idx_subd = -1,
> >>> 	.flags = 0,
> >>> 	.start_src = TRIG_INT,
> >>> 	.start_arg = 0,
> >>> 	.scan_begin_src = TRIG_EXT,
> >>> 	.scan_begin_arg = 0, /* in ns */
> >>> 	.convert_src = TRIG_NOW,
> >>> 	.convert_arg = 0, /* in ns */
> >>> 	.scan_end_src = TRIG_COUNT,
> >>> 	.scan_end_arg = 4,
> >>> 	.stop_src = TRIG_NONE,
> >>> 	.stop_arg = 0,
> >>> 	.nb_chan = 4,
> >>> 	.chan_descs = chans,
> >>> };
> >>> 
> >>> a4l_insn_t insn = {
> >>> 	.type = A4L_INSN_INTTRIG,
> >>> 	.idx_subd = -1,
> >>> 	.data_size = 0,
> >>> };
> >>> 
> >>> 
> >>> Thus, I assume you mean that
> >>> 
> >>> scan_begin_src = TRIG_EXT
> >>> 
> >>> should be modified to one of the enum items below? Are all these
> >>> timers automatically running, or do they need to be configured, too?
> >>> Sorry, I am a bit at a loss how to proceed.
> >> 
> >> Sorry for the delay.
> >> 
> >> I was not clear enough. In fact, scan_begin_arg should be
> >> modified. scan_begin_src indicates the type of trigger and
> >> scan_begin_arg gives an associated argument. In our case, it is the
> >> signal number. Sorry for the comment (/* in ns */) which is an
> >> inappropriate copy-paste (as a matter of fact, it is the whole command
> >> interface which is unsuitable but that's another topic).
> >> 
> >>> 
> >>> Best wishes,
> >>> 
> >>> -Stefan
> >>> 
> >>> 
> >>> On Jul 5, 2010, at 15:02, Alexis Berlemont wrote:
> >>> 
> >>>> Hi,
> >>>> 
> >>>> Alexis Berlemont wrote:
> >>>>> Hi,
> >>>>> 
> >>>>> Stefan Schaal wrote:
> >>>>>> Hi Alexis,
> >>>>>> 
> >>>>>> thanks for the feedback. We have 32 bit DIO on subdevice #2, and I am not sure that there is anything special to be configured. I will check again. Feel free to log into our machine with the pwd I indicated to you some time ago. The computer is not used productively.
> >>>>>> 
> >>>>> 
> >>>>> Sorry for answering late, I was unavailable.
> >>>>> 
> >>>>> My question was: did you ensure that the digital line were properly
> >>>>> modified after having launched cmd_bits ? 
> >>>>> 
> >>>>> As I said, the digital output system does not consume the data (now I
> >>>>> am sure). I instrumetented the code and I found out that the mite
> >>>>> copied about 8000 bytes from the RAM and filled the digital output
> >>>>> FIFO. Then, the DO FIFO status register keeps on indicating the FIFO
> >>>>> is full. Nothing happens, the digital output system does not retrieve
> >>>>> data from the FIFO.
> >>>>> 
> >>>>> I tried to find out why and I had a close look at the driver: I
> >>>>> noticed that no sample clock was configured. The driver only proposes
> >>>>> to use an external signal (from the digital system, so AI/AO clocks,
> >>>>> counters, PFI, etc.) as sample clock. Unfortunately, I do not know
> >>>>> which value corresponds to which clock source.
> >>>>> 
> >>>>> I had a look a the DAQ documentation: unfortunately the M series
> >>>>> digital system is different (the DAQ-STC document is not valid for
> >>>>> this board). I tried to find the M series developer manual but it is
> >>>>> unavailable according to the NI support. I found a document named
> >>>>> mseries_registermap.doc in: 
> >>>>> http://digital.ni.com/express.nsf/bycode/exyv4w?opendocument
> >>>>> 
> >>>>> Unfortunately, it does not tell how to configure the sample clock
> >>>>> source (I know which register I have to fill, but I do not know which
> >>>>> value to put so as to use AI clock, digital counters or PFI...)
> >>>>> 
> >>>>> So, I am kind of stuck. I will proceed on looking for the missing
> >>>>> pieces of information. Please, if anyone have the info (the mapping
> >>>>> between the "CDO_Mode register" values and the sample clock source),
> >>>>> do not hesitate to help us.
> >>>>> 
> >>>> 
> >>>> Argh, I found it. I did not see an item in the url displayed above.
> >>>> 
> >>>> 
> >>>> Here is an enum found in:
> >>>> ftp://ftp.ni.com/support/daq/mhddk/examples/nimseries.zip
> >>>> 
> >>>>    // Field Accessors (Compile-time selectable)
> >>>>    typedef enum {
> >>>>       kCDO_Update_Source_SelectGround            = 0,
> >>>>       kCDO_Update_Source_SelectPFI0              = 1,
> >>>>       kCDO_Update_Source_SelectPFI1              = 2,
> >>>>       kCDO_Update_Source_SelectPFI2              = 3,
> >>>>       kCDO_Update_Source_SelectPFI3              = 4,
> >>>>       kCDO_Update_Source_SelectPFI4              = 5,
> >>>>       kCDO_Update_Source_SelectPFI5              = 6,
> >>>>       kCDO_Update_Source_SelectPFI6              = 7,
> >>>>       kCDO_Update_Source_SelectPFI7              = 8,
> >>>>       kCDO_Update_Source_SelectPFI8              = 9,
> >>>>       kCDO_Update_Source_SelectPFI9              = 10,
> >>>>       kCDO_Update_Source_SelectRTSI0             = 11,
> >>>>       kCDO_Update_Source_SelectRTSI1             = 12,
> >>>>       kCDO_Update_Source_SelectRTSI2             = 13,
> >>>>       kCDO_Update_Source_SelectRTSI3             = 14,
> >>>>       kCDO_Update_Source_SelectRTSI4             = 15,
> >>>>       kCDO_Update_Source_SelectRTSI5             = 16,
> >>>>       kCDO_Update_Source_SelectRTSI6             = 17,
> >>>>       kCDO_Update_Source_SelectAI_Start          = 18,
> >>>>       kCDO_Update_Source_SelectAI_Convert        = 19,
> >>>>       kCDO_Update_Source_SelectPXI_Star_Trigger  = 20,
> >>>>       kCDO_Update_Source_SelectPFI10             = 21,
> >>>>       kCDO_Update_Source_SelectPFI11             = 22,
> >>>>       kCDO_Update_Source_SelectPFI12             = 23,
> >>>>       kCDO_Update_Source_SelectPFI13             = 24,
> >>>>       kCDO_Update_Source_SelectPFI14             = 25,
> >>>>       kCDO_Update_Source_SelectPFI15             = 26,
> >>>>       kCDO_Update_Source_SelectRTSI7             = 27,
> >>>>       kCDO_Update_Source_SelectG0_Out            = 28,
> >>>>       kCDO_Update_Source_SelectG1_Out            = 29,
> >>>>       kCDO_Update_Source_SelectAnalog_Trigger    = 30,
> >>>>       kCDO_Update_Source_SelectAO_Update         = 31,
> >>>>       kCDO_Update_Source_SelectFreq_Out          = 32,
> >>>>       kCDO_Update_Source_SelectDIO_Change_Detect_Irq       = 33,
> >>>>    } tCDO_Update_Source_Select;
> >>>> 
> >>>> So, Stefan, here is a quick solution:
> >>>> 
> >>>> if you have access to your board you can choose one of these signals
> >>>> (in which a regular pulse is occuring) and you can modify accordingly
> >>>> the field scan_begin_arg of the structure a4l_cmd_t in cmd_bits.c. 
> >>>> 
> >>>>> 
> >>>>>> Best wishes,
> >>>>>> 
> >>>>>> -Stefan
> >>>>>> 
> >>>>>> 
> >>>>>> On Jun 30, 2010, at 15:45, Alexis Berlemont wrote:
> >>>>>> 
> >>>>>>> Hi,
> >>>>>>> 
> >>>>>>> Stefan Schaal wrote:
> >>>>>>>> Hi Alexis,
> >>>>>>>> 
> >>>>>>>> I did a reboot, ran my modified cmd_bits.c again one time. 
> >>>>>>>> 
> >>>>>>>> cat /proc/xenomai/irq  reports:
> >>>>>>>> 
> >>>>>>>> IRQ         CPU0        CPU1        CPU2        CPU3        CPU4        CPU5        CPU6        CPU7
> >>>>>>>> 56:           0           0           0           0           0           0           0           0         Analogy device
> >>>>>>>> 518:           0           1           1           1           1           1           1           1         [IPI]
> >>>>>>>> 521:      626392      618020      618539      620274      617326      625008      622464      626300         [timer]
> >>>>>>>> 522:           0           0           0           0           0           0           0           0         [critical sync]
> >>>>>>>> 546:           0           0           0           0           0           0           0           0         [virtual]
> >>>>>>>> 
> >>>>>>> 
> >>>>>>> I have not forgotten you. I am still stuck with your bug: The mite
> >>>>>>> transfers the first 8000 bytes and after does nothing; no interrupt is
> >>>>>>> generated by the mite so as to finally awake your application. 
> >>>>>>> 
> >>>>>>> It seems like the data retrieved by the mite are not consumed by the
> >>>>>>> board. Are you sure the digital output lines correspond to what you
> >>>>>>> configured with cmd_bits ? 
> >>>>>>> 
> >>>>>>> I think the digital output is misconfigured. I am working on it.
> >>>>>>> 
> >>>>>>>> 
> >>>>>>>> -Stefan
> >>>>>>>> 
> >>>>>>>> On Jun 27, 2010, at 3:37, Alexis Berlemont wrote:
> >>>>>>>> 
> >>>>>>>>> Hi,
> >>>>>>>>> 
> >>>>>>>>> 
> >>>>>>>>> Stefan Schaal wrote:
> >>>>>>>>>> Hi Alexis,
> >>>>>>>>>> 
> >>>>>>>>>> thanks so much for the new analogy software. Here are some first observations:
> >>>>>>>>>> 
> >>>>>>>>>> 1) cmd_bits.c works fine on our NI6250 board
> >>>>>>>>>> 
> >>>>>>>>>> 2) however, a slightly modified version hangs -- I appended my cmd_bits.c to this email. All what I added is a for loop around the a4l_async_write() and a4l_snd_insn() commands, i.e., I wanted to trigger a write repeatedly. Look for the "sschaal" comment in my modified cmd_bits.c .  After 32 iterations, cmd_bits hangs, no error messages in dmesg. Interesting, when I change your "trigger_threshold" variable from 128 to 256, my loop runs for 16 iterations (other changes of the trigger threshold adjust the number of iterations I get in a similar way). Thus, it feels like there is a buffer which does not get reset after a4l_snd_insn() is called -- does this make sense?
> >>>>>>>>>> 
> >>>>>>>>> 
> >>>>>>>>> Could you tell me if the mite triggered an interrupt ? Could you send
> >>>>>>>>> a dump of cat /proc/xenomai/irq after having made the test program
> >>>>>>>>> hang ?
> >>>>>>>>> 
> >>>>>>>>> Many thanks,
> >>>>>>>>> 
> >>>>>>>>>> Best wishes,
> >>>>>>>>>> 
> >>>>>>>>>> -Stefan
> >>>>>>>>>> 
> >>>>>>>>>> 
> >>>>>>>>>> On Jun 24, 2010, at 15:43, Alexis Berlemont wrote:
> >>>>>>>>>> 
> >>>>>>>>>>> Hi,
> >>>>>>>>>>> 
> >>>>>>>>>>> Alexis Berlemont wrote:
> >>>>>>>>>>>> Hi Stefan,
> >>>>>>>>>>>> 
> >>>>>>>>>>>> Stefan Schaal wrote:
> >>>>>>>>>>>>> Hi Alexis,
> >>>>>>>>>>>>> 
> >>>>>>>>>>>>> I was just wondering whether the new "experimental" branch in your git repository is something that can be tried already.
> >>>>>>>>>>>>> 
> >>>>>>>>>>>> 
> >>>>>>>>>>>> No. Not yet. This branch is aimed at temporarily holding the
> >>>>>>>>>>>> corrections I am trying to do for the cmd_bits issue. It needs quite a
> >>>>>>>>>>>> lot of work and I have not finished yet. 
> >>>>>>>>>>>> 
> >>>>>>>>>>>> If you have a look at the commits in this branch, we will see many
> >>>>>>>>>>>> "(broken)".
> >>>>>>>>>>>> 
> >>>>>>>>>>> 
> >>>>>>>>>>> I just rebased the experimental branch into the branch analogy. So,
> >>>>>>>>>>> starting from now, we should be able to properly use cmd_bits with a
> >>>>>>>>>>> clone of my git repository.
> >>>>>>>>>>> 
> >>>>>>>>>>> After having reworked the asynchronous buffer subsystem (and having
> >>>>>>>>>>> fixed some oops in the NI driver and in the new code), cmd_bits can
> >>>>>>>>>>> correctly communicate with the DIO subdevice. 
> >>>>>>>>>>> 
> >>>>>>>>>>> A command like "./cmd_bits 0xffff 0xffff" works on my
> >>>>>>>>>>> board. Unfortunately, I have not done the necessary to check the
> >>>>>>>>>>> digital output lines yet.
> >>>>>>>>>>> 
> >>>>>>>>>>> 
> >>>>>>>>>>>>> Best wishes,
> >>>>>>>>>>>>> 
> >>>>>>>>>>>>> -Stefan
> >>>>>>>>>>>> 
> >>>>>>>>>>>> -- 
> >>>>>>>>>>>> Alexis.
> >>>>>>>>>>> 
> >>>>>>>>>>> -- 
> >>>>>>>>>>> Alexis.
> >>>>>>>>>> 
> >>>>>>>>>> 
> >>>>>>>>>> ======================================================= cmd_bits.c ==================================================
> >>>>>>>>> 
> >>>>>>>>> 
> >>>>>>>>> 
> >>>>>>>>> -- 
> >>>>>>>>> Alexis.
> >>>>>>>> 
> >>>>>>> 
> >>>>>>> -- 
> >>>>>>> Alexis.
> >>>>>> 
> >>>>> 
> >>>>> -- 
> >>>>> Alexis.
> >>>> 
> >>>> -- 
> >>>> Alexis.
> >>> 
> >> 
> >> -- 
> >> Alexis.
> > 
> > 
> > _______________________________________________
> > Xenomai-core mailing list
> > Xenomai-core@domain.hid
> > https://mail.gna.org/listinfo/xenomai-core
> 

-- 
Alexis.

