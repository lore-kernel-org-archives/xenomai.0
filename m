Message-ID: <4DA422D4.7010800@domain.hid>
Date: Tue, 12 Apr 2011 12:00:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20110409184122.GA11908@domain.hid>
	<20110409185503.GB11908@domain.hid>
	<4DA0B580.4070602@domain.hid> <4DA0B878.9010106@domain.hid>
	<20110410065250.GA28869@domain.hid>
	<4DA17996.3010103@domain.hid>
	<20110411171437.GA3715@domain.hid>
	<4DA37209.4000503@domain.hid>
	<20110412054348.GA2973@domain.hid>
	<4DA3FC97.10807@domain.hid>
	<20110412094223.GA3006@domain.hid>
In-Reply-To: <20110412094223.GA3006@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] arm ixp: more trouble with recent xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: xenomai@xenomai.org

Richard Cochran wrote:
> On Tue, Apr 12, 2011 at 09:17:43AM +0200, Gilles Chanteperdrix wrote:
>> What compiler are you using by the way?
> 
> I compiled this one myself using crosstool-ng. At the time I had first
> tried gcc 4.3, but you advised me that it would not work for xenomai.

All codesourcery version work with 2.5.6, including the latest one which
is based on gcc 4.5. Ah, but they do not support big endian. I was just
asking to know if you were not using something like gcc 3.x. gcc 4.2 is
OK, though it has some bug with stack unwinding which we do not care about.

-- 
					    Gilles.

