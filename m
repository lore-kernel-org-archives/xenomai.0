From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4BB10712.708@domain.hid>
References: <4BAFBF32.8030507@domain.hid>  <4BB10712.708@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Apr 2010 17:41:19 +0200
Message-ID: <1271173279.2365.136.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [announce] Xenomai v2.5.2
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roland Stigge <stigge@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On Mon, 2010-03-29 at 22:01 +0200, Roland Stigge wrote:
> Hi!
> 
> Gilles Chanteperdrix wrote:
> > here comes Xenomai v2.5.2, codenamed "Souls Of Distortion" available
> > from Xenomai download area:
> > http://download.gna.org/xenomai/stable/xenomai-2.5.2.tar.bz2
> 
> Cool, thanks!
> 
> I'm attaching a patch from Debian. I needed to introduce it because
> without it, --with-test didn't cause /usr/bin/xeno to access the
> executables in the specified directory.
> 
> Thanks for considering!
> 

Ack. We need even more, we have to consider both $prefix and
XENO_TEST_DIR, when looking for a possible target. I've queued a patch
addressing this. Thanks.

> bye,
>   Roland
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.



