Date: Fri, 8 Apr 2011 08:29:28 +0200
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110408062928.GA9935@domain.hid>
References: <20110407170855.GA22659@domain.hid>
	<4D9E0354.4010600@domain.hid>
	<20110407190258.GA27879@domain.hid>
	<20110407201204.GA4913@domain.hid>
	<4D9E1DDA.1000503@domain.hid>
	<20110408060503.GA6174@domain.hid>
	<4D9EA831.3020109@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D9EA831.3020109@domain.hid>
Subject: Re: [Xenomai-core] [Adeos-main] ARM IXP: ipipe regression from
 2.6.31 to .33 and .35
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org, Xenomai-core@domain.hid

On Fri, Apr 08, 2011 at 08:16:17AM +0200, Gilles Chanteperdrix wrote:
> Yes, you can try changing the #ifdef. But note also that the big endian
> code was never actually tested. So, you probably would be better
> compiling a little user-space application to test this tsc code.

Yes, it worked. I sent a patch for 2.6.33.

> the Linksys WRT54GS is an ixp 425, right?.

I don't know about that one.

The NSLU is ixp42x, but many people run it in little endian.

Thanks,
Richard


