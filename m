Message-ID: <2ff1a98a0801290035l1eafd08ai90124a1561dbdf4d@domain.hid>
Date: Tue, 29 Jan 2008 09:35:42 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <20080129080922.GA6314@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080123065221.GB6573@domain.hid>
	<2ff1a98a0801230204s15e4eefaifdd2c946c44549df@domain.hid>
	<2ff1a98a0801230515i77f8c22bk866c4cd592a3a9b8@domain.hid>
	<20080124094150.GA7503@domain.hid>
	<2ff1a98a0801240202g83ca10esd2f7fc928946e3c1@domain.hid>
	<20080125100404.GA8833@domain.hid>
	<2ff1a98a0801250900if03294epded12290544d5480@domain.hid>
	<20080128085123.GA7297@domain.hid>
	<2ff1a98a0801280519m62768928x5e5fa40123abe9cd@domain.hid>
	<20080129080922.GA6314@domain.hid>
Subject: Re: [Xenomai-help] AT91SAM9260 latency
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Juan Antonio Garcia Redondo <juan-antonio.garcia@domain.hid>
Cc: jagarcia@domain.hid, xenomai@xenomai.org

On Jan 29, 2008 9:09 AM, Juan Antonio Garcia Redondo
<juan-antonio.garcia@domain.hid> wrote:
>
> On 28/01/08 14:19, Gilles Chanteperdrix wrote:
> > > >
> > > >
> > > > > > No mystery: hitting a key on a telnet session causes an interrupt
> > > > > > masking section of 110us, you see it as the maximum if you never
> > > > > > observed longer masking sections, but it is not the maximum if you
> > > > > > observed longer masking sections.
> > > > >
> > > > > OK, but why the masking section on linux side affects to xenomai side ?
> > > > > Another thing I don't understand is why when the system has load (above
> > > > > I'm talking about calibrator but the same occurs with dd if=/dev/zero
> > > > > of=/dev/null), the effect seems to dissapear.
> > > >
> > > > It is probably not a masking section on linux side but rather a
> > > > masking section on I-pipe side. Anyway, the effect does not disappear:
> > > > it means that the cache effects cause larger latencies than the
> > > > ethernet interrupt, but maybe I did not understand what you explained.
> > > > The results you obtain with no load are simply irrelevant.
> > >
> > > I'll try to explain it better:
> > >
> > > o Without load I run ./latency -t0 -p500.
> > > RTD|      33.182|      53.479|      67.976|       0|      31.250| 77.319
> > > RTD|      43.170|      53.479|      67.654|       0|      31.250| 77.319
> > > RTD|      41.881|      53.479|      67.332|       0|      31.250| 77.319
> > > RTT|  00:02:07  (periodic user-mode task, 500 us period, priority 99)
> > >
> > > o Each time I press a key (over a telnet session) I can see the lat_max field increase on 40 to 50 us aprox.
> > > RTD|      33.505|      53.479|      71.842|       0|      26.739| 77.319
> > > RTD|      40.592|      62.177|     123.067|       0|      26.739| 123.067
> > >                                    -------
> > >                                       \_________: Key pressed
> > > RTD|      50.579|      53.479|      73.775|       0|      26.739| 123.067
> >
> > This is where you are wrong:
> > - first, let me repeat it: test made without load are irrelevant;
> I can't agree with you. When we stress a system with load is, as far as
> I know, because usually, the large latencies don't appear on a quiet
> system.

Wrong: they are less likely to appear, but may appear as well.

-- 
                                               Gilles Chanteperdrix

