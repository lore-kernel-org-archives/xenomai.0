From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17636.45050.799595.610729@domain.hid>
Date: Thu, 17 Aug 2006 20:05:46 +0200
Subject: Re: [Xenomai-help] problem with installation
In-Reply-To: <1155817937.4366.29.camel@domain.hid>
References: <20060816190510.20935.qmail@domain.hid>
	<44E36F6A.7060004@domain.hid>
	<200608162137.09103.nicola17@domain.hid>
	<44E37823.8080407@domain.hid>
	<33646.155.98.4.150.1155767832.squirrel@domain.hid>
	<1155803145.4356.33.camel@domain.hid> <44E42BE3.1060709@domain.hid>
	<1155814285.4366.22.camel@domain.hid> <44E45645.10106@domain.hid>
	<1155817937.4366.29.camel@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Philippe Gerum wrote:
 > > That all sounds a bit fragile configuration-wise, also given that native
 > > and posix skins are on by default and that you can enable vxworks
 > > without having to switch on periodic timer support (BTW, are the other
 > > legacy RTOS skins with this dependency?).
 > > 
 > 
 > Yes. Most of traditional RTOSes deal with periodic ticks.
 > 
 > > I would suggest to enforce the later and maybe enhance the timer
 > > initialisation interface in a way that a user/skin can request to lock
 > > the mode if it only supports one.
 > 
 > This is a LART, not a fix.
 > 
 > >  Than the latency test should fail to
 > > start, thus indicating a wrong usage. Or we "hack" periodic support over
 > > aperiodic mode, but that's a different topic.
 > > 
 > 
 > This would not be a hack, but the real fix. Keeping the periodic timing
 > handled as a separate hw-dependent mode is the real problem and the
 > source of fragility, which does not buy us anything now that we have a
 > scalable aperiodic timer management code.

It sounds a bit complicated. vxworks emulator can run over aperiodic
mode directly: the only requirement is to use tickRateGet() instead of
assuming that this function always returns 100. I guess the same goes
for other emulators.

-- 


					    Gilles Chanteperdrix.

