MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18228.55287.695219.531113@domain.hid>
Date: Fri, 9 Nov 2007 22:58:15 +0100
In-Reply-To: <e4ef24880711091329g3dd27f0ds6fe033ef79993022@domain.hid>
References: <e4ef24880711091329g3dd27f0ds6fe033ef79993022@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Synchronizing CLOCK_REALTIME between
	networked	computers
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Robert Gubler <rgubler@domain.hid>
Cc: xenomai@xenomai.org

Robert Gubler wrote:
 > Hello,
 > 
 > I'd like to synchronize CLOCK_REALTIME between some computers that share an
 > Ethernet switch.  I am using RTNet as my networking stack.  My approach
 > right now is very simplistic.  I have a central server that will be sending
 > out one 1 packet per second, with its struct timespec it got as a result of
 > calling clock_gettime(CLOCK_REALTIME,...). The computers listening for this
 > packet would then call clock_settime(CLOCK_REALTIME,..).
 > 
 > In the Xenomai POSIX skin API doc it says clock_settime() isn't supported.
 > Is there a recommended approach to accomplishing this?   I am using Xenomai
 > 2.4-rc4.

clock_settime IS supported by Xenomai 2.4, where does it still say in
the doc that it is not supported ?

However clock_settime is a costly service since it walks the system
timers list to recompute their expiration date, so calling it often may
not be a good idea.

Also note that xenomai CLOCK_REALTIME clock is set to the value of Linux
CLOCK_REALTIME clock on system startup, but then does not follow the
corrections made by ntp, which means that it drifts if you compare them.

-- 


					    Gilles Chanteperdrix.

