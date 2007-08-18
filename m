MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18119.4541.303812.177137@domain.hid>
Date: Sat, 18 Aug 2007 17:35:25 +0200
In-Reply-To: <46C6DF38.7000904@domain.hid>
References: <46C6DF38.7000904@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] rtcan and USB legacy
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid

Roland Tollenaar wrote:
 > Hi,
 > 
 > I have understood that USB legacy set to be on in the BIOS is a 
 > potential cause for latency issues. Is that correct?
 > 
 > I have it turned on due to the fact that I boot from USB. I'd like to 
 > know how severe the problems might be. Does anyone have experience with 
 > this?

I guess the answer depends on the BIOS implementation of the legacy
emulation. I suppose you can observe latencies around some tens of
microseconds.

That said:
- I really doubt that you need legacy USB emulation to boot from USB;
- in some cases, loading the Linux USB HCIs drivers is known to turn off
  the legacy USB emulation.

-- 


					    Gilles Chanteperdrix.

