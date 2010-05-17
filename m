MIME-Version: 1.0
In-Reply-To: <AANLkTilkPw0u4JZ5XzNrTUzOhe3nPxqaLXqiMrzqZuzp@domain.hid>
References: <AANLkTil1N6ULXXuv4nx5n_amHqE61tZNuSaw6ndLPdPL@mail.gmail.com>
	<4BF18A00.706@domain.hid>
	<AANLkTinkr4vDIHFMJigC7i9dCXjoG2d_gNG11txXrjpd@domain.hid>
	<4BF192A6.6080508@domain.hid>
	<AANLkTilkPw0u4JZ5XzNrTUzOhe3nPxqaLXqiMrzqZuzp@domain.hid>
Date: Mon, 17 May 2010 12:30:12 -0700
Message-ID: <AANLkTikV7HNazV5kbF27GVwvkrSpEUMf8opyOuYSH4WI@mail.gmail.com>
From: Jeremy Brown <jhbrown@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] Error building userspace: "selected processor
	does not support `rsc r7, r7, #0'
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
Cc: xenomai-help <xenomai@xenomai.org>

On Mon, May 17, 2010 at 12:24 PM, Jeremy Brown <jhbrown@domain.hid> wrote:
> Something in cond.c is now causing a gcc internal compiler error, so I think this toolchain is generally suspect, but that's not even vaguely a Xenomai problem now.)

Hm.  Turning off optimization, the ICE goes away and I get
"cond.c:30:  error:  r7 cannot be used in asm here."  This is at the
expansion of XENOMAI_SKINCALL1.  Is this more thumb-related headaches?
  Am I going to be better off just finding or building a toolchain
that's not trying to use the unified instructions?

Thanks again,
Jeremy

