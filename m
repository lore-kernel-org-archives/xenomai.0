From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4CA09007.6060101@domain.hid>
References: <4C9E15A9.8070601@domain.hid>  <4C9E3100.4020003@domain.hid>
	<1285589890.1717.5.camel@domain.hid>
	<4CA09007.6060101@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 27 Sep 2010 14:47:42 +0200
Message-ID: <1285591662.1717.6.camel@domain.hid>
Mime-Version: 1.0
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

On Mon, 2010-09-27 at 14:37 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > Fine with me. The nucleus should always know better regarding the timer
> > setup latency, so leaving it untouched by the /proc knob makes sense.
> > 
> 
> Ok. My concern was about user settings, but guaranteeing an ABI never
> meant we had to maintain the latency over Xenomai revisions, that was
> kind of silly.
> 

It is even recommended to make it shorter over time.

-- 
Philippe.



