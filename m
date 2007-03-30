Subject: Re: [Xenomai-help] Newbie problem : xenomai 2.3.1 and kernel
	2.6.20.4 installation problem
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <cbe23c50703300045s5a389ce0s91ec515604a87404@domain.hid>
References: <5C40CD1E4697424ABDE3AC57CF1B22C603221032@domain.hid>
	<cbe23c50703300045s5a389ce0s91ec515604a87404@domain.hid>
Content-Type: text/plain
Date: Fri, 30 Mar 2007 11:32:12 +0200
Message-Id: <1175247132.14540.21.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
To: Eric Noulard <eric.noulard@domain.hid>
Cc: xenomai@xenomai.org, "RAKOTOSALAMA,
	Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>

On Fri, 2007-03-30 at 09:45 +0200, Eric Noulard wrote:
> 2007/3/29, RAKOTOSALAMA, Nirilanto <NIRILANTO.RAKOTOSALAMA@airbus.com>:
> > Hello everybody !
> >
> > I installed xenomai 2.3.0 on a FC6 linux distribution with vanilla kernel 2.6.19.7 following the
> > http://www.captain.at/xenomai-2.1-installation.php installation guide.
> > It worked well until I install a new xenomai version (2.3.1) and linux kernel (2.6.20.4)
> > with the same kernel configuration than the first install.
> 
> In your .config you have
> CONFIG_HPET_TIMER=y
> 
> Can you provider boot log in order to see if your box effectively
> have HPET discovered at boot time?
> 
> On my box with Xenomai 2.3.0 + linux 2.6.19 this setup make
> xeno-test to hard lock,
> see:
> https://mail.gna.org/public/xenomai-help/2007-02/msg00085.html
> 
> I don't know if HPET_TIMER is an issue in Xenomai 2.3.1
> anymore since my FAQ comment on this issues seems to
> have been removed
> see
> (http://www.xenomai.org/index.php?title=FAQs&diff=1674&oldid=1642)
> 
> Nevertheless SVN history says the HPET issue is not confirmed...
> 

It's generally not, because there is no issue with HPET over x86_64,
even if there _might_ be some issue over x86, I don't know yet. Maybe
this issue happens when HPET is combined with other options; looking at
the HPET support code does not immediately ring a bell about a potential
conflict with the I-pipe / Xenomai. I need to test this configuration
first and reproduce the issue unambiguously, but don't have any
HPET-enabled x86 hw at hand right now. Until that is done, it is
preferable not to document this issue as a known limitation, since it's
either a wild goose or a high priority must fix anyway.

-- 
Philippe.



