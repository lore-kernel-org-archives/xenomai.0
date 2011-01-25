Message-ID: <4D3E385A.5010209@domain.hid>
Date: Tue, 25 Jan 2011 03:41:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=wo34Zr40GZ+HKegcFKYYcDqj8uzgEqyDCqDj=@mail.gmail.com>
In-Reply-To: <AANLkTi=wo34Zr40GZ+HKegcFKYYcDqj8uzgEqyDCqDj=@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Segmentation Fault when writing in
 registers	(AT91SAM - ARM9)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: at91_enthus <nwromania@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

at91_enthus wrote:
> Hi.
> 
> I  was testing Xenomai on my AT91SAM9G20-based board and tried to adapt the
> code found here:
> http://www.armadeus.com/wiki/index.php?title=Xenomai:Blinking_LEDs .

By the way, this code is ridiculous. It creates a real-time task to
write to some non real-time device, which makes the real-time task useless.


-- 
                                                                Gilles.

