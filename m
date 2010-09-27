Message-ID: <4CA09007.6060101@domain.hid>
Date: Mon, 27 Sep 2010 14:37:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C9E15A9.8070601@domain.hid> <4C9E3100.4020003@domain.hid>
	<1285589890.1717.5.camel@domain.hid>
In-Reply-To: <1285589890.1717.5.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] RFC: /proc/xenomai/latency change
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Fine with me. The nucleus should always know better regarding the timer
> setup latency, so leaving it untouched by the /proc knob makes sense.
> 

Ok. My concern was about user settings, but guaranteeing an ABI never
meant we had to maintain the latency over Xenomai revisions, that was
kind of silly.

-- 
					    Gilles.

