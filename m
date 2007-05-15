Message-ID: <4649D4A3.6070400@domain.hid>
Date: Tue, 15 May 2007 17:41:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <DD39B5C3F4963040ADC9768BE7E430CB01EB2004@domain.hid>
	<4649A485.5010102@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01EB20E6@domain.hid>
	<4649C8B6.2050304@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01EB2122@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB01EB2122@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] memcpy performance on Xenomai
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
Cc: xenomai@xenomai.org

Daniel Schnell wrote:
> 2.) rt_timer_tsc
> If I use clock_gettime() this needs 3100 ns,
> If I use rt_timer_tsc() this needs 74 (!) ns.
> 
> 
> Oooh, we are using clock_gettime() a lot, so this makes a big difference for us.

Again, this issue should be adressed real soon.


-- 
                                                 Gilles Chanteperdrix

