From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17961.8740.319909.281709@domain.hid>
Date: Fri, 20 Apr 2007 22:27:16 +0200
In-Reply-To: <20070420003655.216340@domain.hid>
References: <20070420003655.216340@domain.hid>
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
 > Hi folks,
 > 
 > does Xenomai adjust the system timer frequency? I probably does, so how can I find out the frequency on my system?

See:
http://www.xenomai.org/documentation/branches/v2.3.x/html/api/group__native__timer.html#g66f026b0ac68ef3acde0e6d1bdb6baaf

In short, by default, the system timer is handled in aperiodic mode,
which means that there is no timer frequency: the system timer is
programmed at each software timer event to tick at next event. 

If you are using the stable version or previous releases, the system
timer can be set to periodic mode at compilation time or by passing
parameters to skins modules.

Xenomai trunk emulates periodic mode over aperiodic mode and allows to
set for each skin whether it will use the aperiodic timer, or an
(emulated) periodic timer.

-- 


					    Gilles Chanteperdrix.

