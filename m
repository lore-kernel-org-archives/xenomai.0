MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17963.28109.848250.288610@domain.hid>
Date: Sun, 22 Apr 2007 16:14:37 +0200
In-Reply-To: <20070421215306.54260@domain.hid>
References: <20070420003655.216340@domain.hid>
	<17961.8740.319909.281709@domain.hid>
	<20070421215306.54260@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Timer frequency
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: karre@domain.hid
Cc: xenomai@xenomai.org

karre@domain.hid wrote:
 > Hi Gilles,
 > 
 > Thank you for your answer!
 > 
 > -------- Original-Nachricht --------
 > Datum: Fri, 20 Apr 2007 22:27:16 +0200
 > Von: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
 > An: karre@domain.hid
 > CC: xenomai@xenomai.org
 > Betreff: Re: [Xenomai-help] Timer frequency
 > 
 > > karre@domain.hid wrote:
 > >  > Hi folks,
 > >  > 
 > >  > does Xenomai adjust the system timer frequency? I probably does, so how
 > > can I find out the frequency on my system?
 > > 
 > > See:
 > > http://www.xenomai.org/documentation/branches/v2.3.x/html/api/group__native__timer.html#g66f026b0ac68ef3acde0e6d1bdb6baaf
 > > 
 > > In short, by default, the system timer is handled in aperiodic mode,
 > > which means that there is no timer frequency: the system timer is
 > > programmed at each software timer event to tick at next event. 
 >
 > Does the Linux-Kernel need to be triggered every now and then to
 > adjust system clock? I know that in times of DOS, the system timer
 > had to occur every 18.3 seconds, and I have heard that Linux adjusted
 > this for better scheduling. Do you know how often Xenomai issues a
 > timer irq during idle phases?

On most architectures, one of the tasks of Xenomai nucleus is to handle
a periodic software timer which emulates the system timer used by
Linux. The frequency of this timer is the same as the one expected by
Linux, it depends on CONFIG_HZ.

There is at least on exception to this scheme: the x86 with local
APIC. In this case, Xenomai uses the local APIC as system timer, and
Linux continues to use the PIT.

-- 


					    Gilles Chanteperdrix.

