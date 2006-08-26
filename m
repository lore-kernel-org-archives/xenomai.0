Subject: Re: [Xenomai-help] Re: Timer problems?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44F0BBB7.7030703@domain.hid>
References: <1903864415@domain.hid> <1154964748.4322.31.camel@domain.hid>
	<44EF17E8.5040606@domain.hid>
	<slrneeuefr.v1d.Bernhard.Walle@domain.hid>
	<44F0BBB7.7030703@domain.hid>
Content-Type: text/plain
Date: Sun, 27 Aug 2006 00:12:33 +0200
Message-Id: <1156630353.4730.70.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Kreyer <steve.kreyer@domain.hid>
Cc: xenomai@xenomai.org, Bernhard Walle <Bernhard.Walle@domain.hid>

On Sat, 2006-08-26 at 23:23 +0200, Steve Kreyer wrote:
> Hi Bernhard, :)
> Bernhard Walle wrote:
> > Hello,
> >
> > first of all: you replied to a previous mail which results in a broken
> > thread three in the mail client ... Pleaes create new mail for new
> > requests.
> > The example you've provided exits immediately here because you don't
> > wait in the main() function.
> >   
> Yes, Iam aware of this, but in fact the waiting via pause or sleep in 
> the Linux process (main function)
> failed and results in a system lock up.

The latency test issues a number of native API calls mixed with standard
glibc calls. Does it run on your box?

Btw, your .config shows that PM is enabled, which is a known source of
latency problems; you should disable it. Additionally, make sure to read
the TROUBLESHOOTING file thoroughly: a number of configuration caveats
for x86 are explained, including the PM one.

Last point: the kernel shipped by Kanotix might have been patched up
beyond all recognition. Did the Adeos patch apply cleanly against it?

-- 
Philippe.



