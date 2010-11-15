From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4CE13133.4070006@domain.hid>
References: <AANLkTinuEh+5J4Osq895PN92VXNc1OgNF8HD526f--dA@mail.gmail.com>
	<1289813422.1933.79.camel@domain.hid>  <4CE13133.4070006@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 15 Nov 2010 16:07:02 +0100
Message-ID: <1289833622.1933.128.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Debug/trace tools for xenomai applications.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-help@domain.hid

On Mon, 2010-11-15 at 14:10 +0100, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > If you want to validate the pSOS emulation core, the best tool is the
> > simulator. Unfortunately, this tools still requires to be built with an
> > antiquated C++ toolchain, so the only sane way to enable it nowadays is
> > via qemu. You would need ~2 hours to set this up.
> > 
> > If you want to try this, I can help. Otherwise, other suggestions you
> > already got on this list will do.
> 
> Maybe we should put a page on the wiki on how to use the simulator?
> 

The problem is that we have no bandwidth to maintain it properly, this
is a project in itself; so this should be clearly stated on such
documentation. The gcc-based (2.95.x) instrumenter is 12-years old now,
and rewriting this part would a very significant work. It's really a
pity, since the simulator is definitely the ultimate tool for finding
functional bugs in emulators. Oh, well.

-- 
Philippe.



