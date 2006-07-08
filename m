Message-ID: <e325d110607080808w7778fb6ayf1f033b79be7c92b@domain.hid>
Date: Sat, 8 Jul 2006 16:08:02 +0100
From: "Kim Chuan Lim" <lim.kim.chuan@domain.hid>
Subject: Re: [Xenomai-help] xenomai beginner problem.
In-Reply-To: <17583.47182.991802.118974@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e325d110607071259g5ebc019bs2565887803265adc@domain.hid>
	<44AEC245.7090702@domain.hid>
	<e325d110607080632u5d80322bte8d32d8e4828030e@domain.hid>
	<17583.47182.991802.118974@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,

> Try passing "lapic=1" as kernel boot parameter, and if it still does not
> work, recompile your kernel with APIC support disabled.

Thanks. It works.

I try to run some examples programs at /usr/xenomai/testsuite/latency/run ..
the following is the error i received..
warming up...
latency: failed to set periodic, code -110

Any quick suggest?

Regards,
Kim Chuan.

