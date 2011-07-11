Message-ID: <4E1B3988.9000907@domain.hid>
Date: Mon, 11 Jul 2011 19:57:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAL+uwv-XzsN_+4MHXTo+SW7jAh98rf22ER4uGb5DV+HXktELOg@domain.hid>
In-Reply-To: <CAL+uwv-XzsN_+4MHXTo+SW7jAh98rf22ER4uGb5DV+HXktELOg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Regarding xeno test (somethign died at 3150)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: suresh reddy <sureshreddy.balijepalli@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 07/11/2011 06:06 PM, suresh reddy wrote:
> Dear Xenomai Team,
> 
> I run the xeno-test on pandaboard and it giving me the mentioned error.

Please do not run xeno-test. Run the "latency" test directly instead,
typing:

/usr/bin/latency

And run some load in the background using a combination of network load
using netcat, disk load using dd, and cpu/cache load using hackbench.

-- 
                                                                Gilles.

