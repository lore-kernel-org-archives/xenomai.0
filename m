Date: Tue, 20 Jul 2010 00:01:29 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20100719220129.GA3662@domain.hid>
References: <5A2DB1C3-C660-45BE-9743-716F63C11825@domain.hid>
	<20100709221733.GC10254@domain.hid>
	<5BACCC6E-A481-4953-ABAC-ACE3185E1A9C@usc.edu>
	<3712D196-B8B5-430C-A5F5-189C77F76997@domain.hid>
	<20100712222926.GA2463@domain.hid>
	<F730DBD8-DEB8-4C64-BA65-19657D6EFA95@domain.hid>
	<4495E38D-134C-425D-B797-1174E8849E3F@usc.edu>
	<20100714210331.GC3246@domain.hid>
	<373BD2C2-B474-4E1F-A46C-0C704E6C318B@usc.edu>
	<EDE3463F-03C5-44C5-BAEA-A44321376428@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EDE3463F-03C5-44C5-BAEA-A44321376428@domain.hid>
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

Sorry for answering late. 

Stefan Schaal wrote:
> Hi Alexis,
> 
>   I managed to port some of the Comedi examples to Analogy. In particular, I could configure one of my counter subdevices to become a high frequency clock, following the gpct_pulse_generator.c example. I routed the output of the clock to my PFI0 pin, and could visualize the signal on an oscilloscope. Thus, I know have the clock I need to trigger CMD-based DIO, as you suggested. (I will post some sample code of this in the near future after all is cleaned up).
> 
>    Next, I went back to cmd_bits.c and try to make it work on my NI6259 board. For scan_begin_src=TRIG_EXT   I need to choose scan_begin_arg = 28 (which is kCDO_Update_Source_SelectG0_Out in the NI documentation, and NI_CDIO_SCAN_BEGIN_SRC_G0_OUT in the comedi.h file).
> 
>    When running cmd_bits.c in this way and monitoring the DO channels on an oscilloscope, the DO switches to HIGH when the acquisition is triggered (i.e., the value of the first element in the FIFO), but the FIFO is not processed any further, i.e., not emptied. If I DO NOT run the counter-clock above, the DO does not even switch to HIGH. I also checked whether 28 is the right value for scan_begin_arg by trying a wide range of values, but only for scan_begin_arg = 28 I get the DO bit switched to HIGH at the beginning of the acquisition.
> 
>   In Comedi, the cmd.flags is set to CMDF_WRITE for such externally triggered acquisitions, which I tried, but it did not help.
> 
>   Thus, it appears that I still have a problem in processing the FIFO, despite it appears that all other things are now correctly connected (Comedi has an example do_waveform.c, which is pretty much what I try to use for testing in my own code).
> 
>   Would you have any thoughts on what might go wrong? It looks like we are just a tiny bit away from succeeding with cmd_bits.c on my board.
> 

I had time to have a look at your problem. Unfortunately, I do not
have any solution. I just have some questions you may find stupid:

- Did you try to invert the sample clock polarity by setting the flag
  CR_INVERT in the command field scan_begin_arg?
- Which frequencies did you generate with the counter subdevice? Even
  the lowest one did nothing (Something like 10Hz)?
- Did you try to send 0 with cmd_bits ? Just to check that the DO stay
  to LOW, which would mean that the values (or at least the first one)
  are properly loaded into the device.
- So far, cmd_bits always sends the same value (the one you passed as
  argument); we should modify it so that the complement value is
  written every two samples. That would allow us to physically check
  how many samples are "played" by the DO. 

> Best wishes,
> 
> -Stefan
> 
> 
> 
> 
> 
> On Jul 14, 2010, at 17:46, Stefan Schaal wrote:
> 
> > Hi Alexis,
> > 
> >  in the Comedi examples (http://www.comedi.org/download/comedilib-0.8.1.tar.gz, the do_waveform.c example), they suggest to use a general purpose counter as clocking input to a cmd-based DIO acquisition. This seems to be the signal "kCDO_Update_Source_SelectG0_Out            = 28" from the enum you found in the NI documentation.
> > 
> > For this purpose, the counter needs to be configured and triggered. Does Analogy already have the functionality to do such operations? The Comedi libraries have an example for this, too, in gpct_pulse_generator.c, just that this example uses a variety of function calls that I cannot directly map to the current Analogy functionality.
> > 
> > Or, do you happen to know whether there is another, easier to access, clock source?
> > 
> > Best wishes,
> > 
> > -Stefan
> > 
> > 
> > On Jul 14, 2010, at 14:03, Alexis Berlemont wrote:
> > 
> >> Stefan Schaal wrote:
> >>> Hi Alexis,
> >>> 
> >>> maybe it is more useful to mention what I actually want to achieve with DIO on my NI6259.  My DIO communication involves a series of interactions with another board to collect sensory data from a robot, and to send out commands to this board. For instance, to read one of the sensors, a sequence of DIO values need to be written to tell the board to send the data. I programmed this initially with synchronous instructions using a4l_sync_dio(), but this turns out to be too slow. Thus, the hope is to use commands, i.e., fill the FIFO with the sequence of values which I need to execute, and then use asynchronous DIO to obtain much higher speed of communicating the values in the FIFO.
> >>> 
> >>>  Thus, what I essentially try to do is to put about 10-20 scans in the FIFO, and then write the FIFO as fast as possible to my NI6259 DIO subdevice.
> >>> 
> >>> Would you have any ideas how to do this fast writing of the scans in the FIFO with the current analogy functionality?
> >>> 
> >> Right now, I don't know. I think your idea of using DIO commands may
> >> be suitable (I don't know your timing constraints). So what not
> >> proceeding ?
> >> 
> >>> Thanks a lot!
> >>> 
> >>> -Stefan
> >>> 
> >>> 
> >>> On Jul 12, 2010, at 22:51, Stefan Schaal wrote:
> >>> 
> >>>> Hi Alexis,
> >>>> 
> >>>> thanks a lot for the explanations. One item I am confused about is that you write that TRIG_TIMER is not suitable for DIO, but in cmd_write.c in your sample code, it is used for the analog write without problems. Wouldn't one be able to just use the same clock source for DIO as in analogue I/O?
> >>>> 
> >>>> Best wishes,
> >>>> 
> >>>> -Stefan
> >>>> 
> >>>> 
> >>>> 
> >>>> On Jul 12, 2010, at 15:29, Alexis Berlemont wrote:
> >>>> 
> >>>>> Hi,
> >>>>> 
> >>>>> Stefan Schaal wrote:
> >>>>>> Hi Alexis,
> >>>>>> 
> >>>>>> I guess I slowly understand that my clocking signal connected to
> >>>>>> scan_begin_arg has to come from an external DIO input, if
> >>>>>> scan_bigin_src = TRIG_EXT, and that the insn instruction is still
> >>>>>> needed to trigger the entire acquisition. 
> >>>>> 
> >>>>> Yes. The trigger instruction is needed so as to start the whole
> >>>>> acquisition (which is composed of many scans). A periodic external
> >>>>> signal is needed so as to trigger each scan.
> >>>>> 
> >>>>>> 
> >>>>>> Alternatively, would it be possible to use the internal clocking signals like 
> >>>>>> 
> >>>>>> scan_bigin_src = TRIG_FOLLOW
> >>>>>> 
> >>>>>> or 
> >>>>>> 
> >>>>>> scan_bigin_src = TRIG_TIMER
> >>>>> 
> >>>>> I think you are right. If the sampling clock comes from another
> >>>>> subdevice, TRIG_EXT may not be the most appropriate constant. However,
> >>>>> the original comedi driver only expects TRIG_EXT even if... the
> >>>>> sampling signal is not external.
> >>>>> 
> >>>>> TRIG_TIMER does not seem suitable because it assumes an independant
> >>>>> sampling clock is available.  
> >>>>> 
> >>>>> And TRIG_FOLLOW may be the most appropriate one. We should modify the
> >>>>> driver so that TRIG_FOLLOW is used if the analog sampling clock is
> >>>>> chosen.
> >>>>> 
> >>>>>> 
> >>>>>> 
> >>>>>> if I try any of these sources, I get an error -22, and dmesg reports:
> >>>>>> 
> >>>>>> [195882.321300] Analogy: a4l_check_cmddesc: scan_begin_src, trigger unsupported
> >>>>>> 
> >>>>> 
> >>>>> For me, the command interface is an empty shell because the various
> >>>>> parameters (start_src, scan_begin_src, ...) and the values (TRIG_*)
> >>>>> are imposed. And, on the other side, the driver is fully in charge of
> >>>>> the command structure as it is. So, the comedi command imposes a
> >>>>> communication method but does not ease the driver's task of managing
> >>>>> it (errors checking, translation, etc.)
> >>>>> 
> >>>>> And, in our case: DIO, we may conclude that this imposed API does not
> >>>>> fit well: in scan_begin_arg, we have to pass an index which is
> >>>>> supposed to correspond to some sampling clock (which is specific to a
> >>>>> board). Then, we use a generic interface with board-specific
> >>>>> arguments.
> >>>>> 
> >>>>> So, to sum up, I understand your point: the way we control the driver
> >>>>> may not always be the most appropriate one. But, we inherited from
> >>>>> comedi both the interface and the drivers. 
> >>>>> 
> >>>>> On my side, I am working on trying to implement (as a background task)
> >>>>> a generic interface a little bit more based on discovery (query /
> >>>>> enum) that would render the command interface obsolete. Unfortunately,
> >>>>> I have nothing interesting to show yet.
> >>>>> 
> >>>>>> Best wishes,
> >>>>>> 
> >>>>>> -STefan
> >>>>>> 
> >>>>>> 
> >>>>> 
> >>>> 
> >>>> 
> >>>> _______________________________________________
> >>>> Xenomai-core mailing list
> >>>> Xenomai-core@domain.hid
> >>>> https://mail.gna.org/listinfo/xenomai-core
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

