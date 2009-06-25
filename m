Message-ID: <4A43820B.2020701@domain.hid>
Date: Thu, 25 Jun 2009 15:56:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1245226350.3614.10.camel@domain.hid>
	<4A38AD4D.9090802@domain.hid>
	<E5CDD68F7A516B4F863D651CDA2DBF71010A9E64@domain.hid>
In-Reply-To: <E5CDD68F7A516B4F863D651CDA2DBF71010A9E64@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RE :  problem with gtk
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: LEMARCHAND Ludovic <Ludovic.LEMARCHAND@tech.viveris.com>
Cc: xenomai@xenomai.org

LEMARCHAND Ludovic wrote:
> Hello
> 
> I solved the problem of the freeze.
> 
> I disabled the Symmetric multi-processing support (SMP) and now it works with no freeze.
> 
> Ludovic Lemarchand

That is not normal. Does the SMP kernel freeze with Xenomai 2.4.8 and
the ipipe patch for 2.6.29 it contains ?

If yes, then please try to get the kernel logs and post them on this list.

-- 
                                          Gilles


