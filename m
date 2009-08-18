Message-ID: <4A8AAB92.6050901@domain.hid>
Date: Tue, 18 Aug 2009 15:24:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7a15153d0908180547s1d542689r30992d62662c4710@domain.hid>
In-Reply-To: <7a15153d0908180547s1d542689r30992d62662c4710@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Xenomai and PXA
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: felipe felipe <felipecpc1@domain.hid>
Cc: xenomai@xenomai.org

felipe felipe wrote:
> Hi all , 
> I'm starting with xenomai, i tried to get a realtime linux embedded for
> a medical device. 
> I run some examples, but I'm a little bit lost.
> I tried to run the cross-link example , tha uses the module xeno_16550A
> but it seems that this module is not compatible with PXA serial driver
> right?

Dunno. You should be the one who knows if the serial driver you use is
16550 or not. In any case, if you implement another serial driver, we
would be happy to include it in future releases of Xenomai.

> There are some driver to get a serial driver working with PXA (Toradex
> colobri) SOM ?
> Another issue is about GPIO. I need to read some GPIO's , there are some
> example , driver or something like that ?

Nope. But again, if you implement a framework for GPIOs, we would be
happy to include it in Xenomai.

-- 
                                          Gilles


