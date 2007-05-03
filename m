MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17978.11531.902028.392269@domain.hid>
Date: Thu, 3 May 2007 20:42:19 +0200
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB01E43DC9@domain.hid>
References: <4639D724.5010702@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01E43D41@domain.hid>
	<1178204088.29605.85.camel@domain.hid> <4639FAC7.9060207@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01E43DC9@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Latency calculation and test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: Xenomai-help@domain.hid

Daniel Schnell wrote:
 > Hmm,
 > 
 > I understand now that the value for /proc/xenomai/latency is for the
 > anticipation algorithm of timers. This anticipation algorithm is
 > responsible for optimizing the minimal jitter time for timers. Is the
 > latency value used also elsewhere in Xenomai ?

No.

 > 
 > If, say, I would use latencies calibrated with user space POSIX
 > timers for a typical work load, what would happen to timers that are
 > running in kernel or interrupt space ? Would they then be too early ? 
 > Have negative values any negative effect besides running too early ?
 > 
 > In other words: when one uses timers inside Kernel, ISR's and User
 > space at the same time, which value should be used for
 > /proc/xenomai/latency ? Wouldn't it make sense then to have 3
 > different latency values for the 3 possible environments ?

Yes the current situation is that there is only one constant, so, if you
calibrate it for ISRs, user-space programs will be systematically
late. Having three different constants would mean that we track, at
nucleus level where each timer is used, and that we order timers in the
timer queue according to their anticipated expiration date. This is
quite a modification.

-- 


					    Gilles Chanteperdrix.

