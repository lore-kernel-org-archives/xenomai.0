Date: Mon, 16 Aug 2010 22:54:02 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20100816205401.GA2698@domain.hid>
References: <CB64A448250ADE40A2D9459AEB556D5E0274D4FBBF@NIHMLBX15.nih.gov>
	<20100809221312.GB3876@domain.hid>
	<AANLkTikc8KTqLnNoXJnARAX_fh1rf3_N+uuTu3WrVJ76@domain.hid>
	<20100810213023.GB2471@domain.hid>
	<AANLkTinmjbuVG7MV2=Z0KLAPtYELKJq7Ru9F3rd5wLGM@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTinmjbuVG7MV2=Z0KLAPtYELKJq7Ru9F3rd5wLGM@mail.gmail.com>
Subject: Re: [Xenomai-help] Use of counter for quadratic encoder in NI
 PCI-6229 board
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jonghyun Kim <jong.h.kim@domain.hid>
Cc: xenomai@xenomai.org

Hi,

Sorry for the late answer.

Jonghyun Kim wrote:
> Thanks to the advise and 'gpct_encoder.c' in Comedi,
> it seems that the counter is successfully configured for quadratic encoder.
> 
> So, next step is to read the encoder.
> 
> I tried to use a4l_sync_read() and a4l_snd_insn() to read the encoder,
> but they did not work. The result always shows '0' value.
> 
> Is it right to use a4l_sync_read() or a4l_snd_insn() for reading the value
> of the encoder?
> Or, could you give me a sample code about this reading?
> 

What is the interest of reading a counter which is configured as a
quadratic encoder? I thought reading was only useful when the counter
is configured as an event counter.

Anyway, which channel have you tried to read? According to the source
code (tio_common.c), the counter can be read on 3 channels: 0, 1 and
2.
On channel 0, you read SW_Save_Reg (I thought this one was used for
event counting).
On channel 1 and 2, you read LoadA_Reg and LoadB_Reg; that may be the
ones you are looking for.

> Using two functions above, I read 4 bytes at once.
> ( nbyte =4 in a4l_sync_read() and data_size=4 in a4l_snd_insn() ).
> I tried other X bytes reading, but I got error.
> 
> Many thanks in advance.
> 
> 
> Jonghyun
> 
> 
> On Tue, Aug 10, 2010 at 5:30 PM, Alexis Berlemont <
> alexis.berlemont@domain.hid> wrote:
> 
> > Hi,
> >
> > Please, do not forget to CC the mailing-list.
> >
> > Jonghyun Kim wrote:
> > > I'm so Sorry. 'config.idx_subd = 10' was erratum.
> > > In my code, I used '11'.
> > >
> > > Anyway, thank you for your advise.
> > >
> > > Due to an another advise, I am going to try Xenomai 2.5.4.
> > > But, I cannot find any changelog on this issue in Xenomai 2.5.3 and 2.5.4
> > >
> > > So, my questions are...
> > >
> > > 1. Now, is ni_pcimio officially supporting the function of counter for
> > > quadratic encoder?
> > I know that the NI counters have been successfully used with
> > instructions (not by myself). The issue, once more, is that you have
> > to pass driver-dependent parameters to make them work. For example,
> > the mode A4L_INSN_CONFIG_GPCT_QUADRATURE_ENCODER cannot be used.
> >
> > So my answer is that counter configuration is not officially supported
> > because of the lack of a generic API.
> >
> > >
> > > 2. If ni_pcimio does not support the function of counter yet, when will
> > this
> > > function be implemented? (with a sample code, such as insn_read for
> > > AI)
> > I already tried to develop an insn_counter program as a
> > demonstration. I faced the problem detailed above: the instruction
> > parameters needed to configure a counter subdevice are not independant
> > from the acquisition card. For example, with the NI boards, you need
> > to pass NI_GPCT_COUNTING_MODE_NORMAL_BITS... and with the s526 board,
> > you need to use A4L_INSN_CONFIG_GPCT_QUADRATURE_ENCODER...
> >
> > >
> > > 3. I also have s526 board. In the case of s526, is this function now
> > worked
> > > officially?
> > The s526 driver is a port from the Comedi one (just like the NI PCI
> > driver). We have tried to reuse as many features as possible: the
> > original counter configuration method is present; so, you can have a
> > look at the driver code in order to know which parameter to pass to
> > configure it.
> > * data[0]: Application Type => A4L_INSN_CONFIG_GPCT_QUADRATURE_ENCODER
> > * data[1]: Counter Mode Register Value =>...
> > * data[2]: Pre-load Register Value
> > * data[3]: Conter Control Register
> >
> >
> > Unfortunately, the problem you are highlighting is not a new one. On
> > the mailing-list, I already had the opportunity to explain the main
> > issue with counters in the following mail:
> > https://mail.gna.org/public/xenomai-help/2010-03/msg00076.html
> >
> > Here is an extracted part of it:
> >
> > ...
> > The most striking examples were in the configuration of the counting
> > stuff. At least four comedi drivers manage gpct: the NI ones, s526,
> > me4000 and vmk80xx. Each one has defined its one configuration
> > instruction, in other words, its one interface. That means for me that a
> > user application must be specific to a driver to work properly (in some
> > cases, you must even give the registers values).
> >
> > Such a situation is, for me, not acceptable. Any acquisition user
> > application should work with any acquisition driver and especially
> > because of the acquisition framework.
> >
> > Starting from here, it is really difficult for me to find out what
> > interface I should implement so as to satisfy all of them.
> > ...
> >
> > Tackling this problem is interesting. It needs time and as many
> > counting cards as possible. If you are interested, do not hesitate :)
> > You can also give us an access to your hardware...
> >
> > >
> > >
> > > Thanks,
> > >
> > > Jonghyun Kim
> > >
> > >
> > > On Mon, Aug 9, 2010 at 6:13 PM, Alexis Berlemont <
> > alexis.berlemont@domain.hid
> > > > wrote:
> > >
> > > > Hi,
> > > >
> > > > Kim, Jonghyun (NIH/CC) [F] wrote:
> > > > > OS : Debian 5.0.4 + Xenomai 2.5.2
> > > > > HW : NI PCI-6229
> > > > >
> > > > >
> > > > > Hi.
> > > > > I have a question on the use of counter in NI PCI-6229 board.
> > > > >
> > > > > Thanks to analogy, I can use the functions of AI and AO using NI
> > > > PCI-6229.
> > > > > But, I failed to use its counter for quadratic encoder.
> > > > >
> > > > > I think it may work, but it is hard for me because I don't have any
> > > > verified example.
> > > > >
> > > > > Recently, I tried the following code to set the counter up for
> > quadratic
> > > > encoder:
> > > > >
> > > >
> > ---------------------------------------------------------------------------------------------------
> > > > > a4l_desc_t dsc = {.sbdata = NULL };
> > > > > a4l_insn_t config;
> > > > > unsigned int data[4];
> > > > >
> > > > > a4l_open(&dsc, filename);
> > > > > dsc.sbdata = malloc(dsc.sbsize);
> > > > > a4l_fill_desc(&dsc);
> > > > >
> > > > > config.type = A4L_INSN_CONFIG;
> > > > > config.idx_subd = 10;  // this is correct. I checked it
> > > > > data[0] = A4L_INSN_CONFIG_GPCT_QUADRATURE_ENCODER;
> > > > > data[1] = 0; // X1, X2, X4
> > > > > data[2] = 0; // indexphase HH, LH, ...
> > > > > data[3] = 0; // indexreset
> > > > > config.data = data;
> > > > > config.data_size = 4*sizeof(unsigned int);
> > > > >
> > > > > a4l_snd_insn(&dsc, &config);
> > > > >
> > > >
> > ----------------------------------------------------------------------------------------------------
> > > > >
> > > > > However, the last a4l_snd_insn() returned error code, -22.
> > > > >
> > > >
> > > > Are you still using the subdevice index 10 ? How did you check that it
> > > > was correct? With my NI6221 board, the GCPT counter seems to be
> > > > located at index 11 and the subdevice index are static (unless there
> > > > is a bug).
> > > >
> > > > # cat /proc/analogy/00-analogy_ni_pcimio
> > > > --  Subdevices --
> > > >
> > > > | idx | type
> > > > |  00 | Analog input subdevice
> > > > |  01 | Analog output subdevice
> > > > |  02 | Digital input/output subdevice
> > > > |  03 | Unused subdevice
> > > > |  04 | Unused subdevice
> > > > |  05 | Calibration subdevice
> > > > |  06 | Memory subdevice
> > > > |  07 | Digital input/output subdevice
> > > > |  08 | Unused subdevice
> > > > |  09 | Serial subdevice
> > > > |  10 | Unused subdevice
> > > > |  11 | Counter subdevice
> > > > |  12 | Counter subdevice
> > > > |  13 | Counter subdevice
> > > >
> > > > >
> > > > > Could you give me the verified sample code for quadratic encoder
> > using NI
> > > > PCI-6229 board?
> > > > > Or plz help me to use my encoder :(
> > > > >
> > > > > Many thanks in advance.
> > > > >
> > > > > Jonghyun
> > > > > _______________________________________________
> > > > > Xenomai-help mailing list
> > > > > Xenomai-help@domain.hid
> > > > > https://mail.gna.org/listinfo/xenomai-help
> > > >
> > > > --
> > > > Alexis.
> > > >
> >
> > --
> > Alexis.
> >

-- 
Alexis.

