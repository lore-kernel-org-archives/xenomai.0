Content-Type: text/plain; charset="us-ascii"
Date: Mon, 14 May 2007 13:20:27 +0200
From: "Karl Reichert" <Karl-Trampe@domain.hid>
In-Reply-To: <20070511112422.282090@domain.hid>
Message-ID: <20070514112027.167950@domain.hid>
MIME-Version: 1.0
References: <20070510120938.307800@domain.hid> <46434561.2090309@domain.hid>
	<46434837.9080605@domain.hid> <20070511112422.282090@domain.hid>
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] high latency with Intel Core 2 Duo
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

> > Jan Kiszka wrote:
> > > Karl Reichert wrote:
> > > 
> > >>Hello,
> > >>
> > >> I'm using an Intel Core 2 Duo at work and an AMD XP3000+ at home. I
> > installed Xenomai 2.3.1 with nearly same configuration at both and run
> the
> > xeno-test. I get 10 times higher latency with Core 2 Duo. How is it
> possible?
> > May the SMP be the reason?
> > > 
> > > 
> > > SMP surely increases latencies (more synchronisation overhead), but
> the
> > > tests you ran were also far to short for a thorough comparison. 2 us
> > > worst-case is far too good, even on high end. Also 20 us on loaded SMP
> > > boxes may not hold. Leave the test running for a longer period ("-T"
> > > parameter, I think).
> Will do that and report the results later.
> 
> > 
> > You should configure the user-space libraries with the --enable-smp
> > option when configuring for SMP.
> > 
> I did that, but nothing changes, still the same latencys (see attached
> file).
> 
> > Also, did you compile a 32 bits or 64 bits kernel for the core 2 duo ?
> > 
> It's a 32 bit one.
> > If you think that you observe high latencies, check the TROUBLESHOOTING
> > file.
> > 
> > -- 
> >                                                  Gilles Chanteperdrix
> Karl
> -- 
> von Karl Reichert
> 
> GMX FreeMail: 1 GB Postfach, 5 E-Mail-Adressen, 10 Free SMS.
> Alle Infos und kostenlose Anmeldung: http://www.gmx.net/de/go/freemail
Is there any possibility to tell Xenomai to use one core for (NonRT-)Linux and one for RTApps?
-- 
von Karl Reichert

Ist Ihr Browser Vista-kompatibel? Jetzt die neuesten 
Browser-Versionen downloaden: http://www.gmx.net/de/go/browser

