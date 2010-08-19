From: Klaas Gadeyne <Klaas.Gadeyne@domain.hid>
Date: Thu, 19 Aug 2010 17:47:38 +0200
Message-ID: <45CD9FEC4B82E547A4065415E8ECFDAF3B1ED85F96@domain.hid>
References: <CB64A448250ADE40A2D9459AEB556D5E0274D4FBBF@NIHMLBX15.nih.gov>
	<20100809221312.GB3876@domain.hid>
	<AANLkTikc8KTqLnNoXJnARAX_fh1rf3_N+uuTu3WrVJ76@domain.hid>
	<20100810213023.GB2471@domain.hid>
	<AANLkTinmjbuVG7MV2=Z0KLAPtYELKJq7Ru9F3rd5wLGM@mail.gmail.com>
	<20100816205401.GA2698@domain.hid>
In-Reply-To: <20100816205401.GA2698@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Use of counter for quadratic encoder in
	NI	PCI-6229 board
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alexis Berlemont <alexis.berlemont@domain.hid>, Jonghyun Kim <jong.h.kim@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

> Jonghyun Kim wrote:
> > Thanks to the advise and 'gpct_encoder.c' in Comedi,
> > it seems that the counter is successfully configured for quadratic
> encoder.
> >
> > So, next step is to read the encoder.
> >
> > I tried to use a4l_sync_read() and a4l_snd_insn() to read the
> encoder,
> > but they did not work. The result always shows '0' value.
> >
> > Is it right to use a4l_sync_read() or a4l_snd_insn() for reading the
> value
> > of the encoder?
> > Or, could you give me a sample code about this reading?
> >
>
> What is the interest of reading a counter which is configured as a
> quadratic encoder? I thought reading was only useful when the counter
> is configured as an event counter.
>
> Anyway, which channel have you tried to read? According to the source
> code (tio_common.c), the counter can be read on 3 channels: 0, 1 and
> 2.
> On channel 0, you read SW_Save_Reg (I thought this one was used for
> event counting).
> On channel 1 and 2, you read LoadA_Reg and LoadB_Reg; that may be the
> ones you are looking for.

Nope, you should read channel 0.  See e.g.
<http://g-line.chess.cornell.edu/G-lineStatus/G-lineManuals/PCI-Boards/NI-6=
602-ProgrammingManual.pdf> page 2-6

HTH

Klaas


