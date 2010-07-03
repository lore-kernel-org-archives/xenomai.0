Message-ID: <4C2F97D6.6000506@domain.hid>
Date: Sat, 03 Jul 2010 22:04:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <22150A2C94CC924695BE248F94CD11F2CD0F@EXDB4.ug.kth.se>	<4C2A518F.8030302@domain.hid>	<22150A2C94CC924695BE248F94CD11F2CDC2@domain.hid>	<4C2B0043.1070108@domain.hid>	<AANLkTikdRdEXJd97HKlWzUmon8bu94n-ATNozWyOmTOu@domain.hid>	<22150A2C94CC924695BE248F94CD11F2D063@domain.hid>	<AANLkTinqA_l4Jersd-1EfCMecqal2ZkSepe5DhtQAEJ3@domain.hid>	<22150A2C94CC924695BE248F94CD11F2D27F@EXDB4.ug.kth.se>	<22150A2C94CC924695BE248F94CD11F2D375@domain.hid>	<4C2DDE49.1080009@domain.hid>	<22150A2C94CC924695BE248F94CD11F2D3C1@domain.hid>
	<AANLkTimw6Bz9-ZVvFl46_WTlo2Z-T8Kc0mebS5DYd-1K@mail.gmail.com>
	<22150A2C94CC924695BE248F94CD11F2D4D6@domain.hid>
In-Reply-To: <22150A2C94CC924695BE248F94CD11F2D4D6@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and Gumstix Overo
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fredrik Asplund <fasplund@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Fredrik Asplund wrote:
>> OK, just tried your kernel - same problem. That means that
>> something is wrong with my user-space build.... Will try to enable
>> EABI now as suggested by Gilles.
> 
> Ok. You can find a description of what I did, the images and the
> build files at "http://flyg.sagar.se/node/17".

I read this page and would have a few remarks. When using
prepare-kernel, you can pass all arguments on the command line to the
script so that it does not ask any question.

The Adeos project has a git: git://git.denx.de/ipipe-2.6.git
You can use it to merge the I-pipe with your vendor branch.

About the QA issues: if there is something wrong with Xenomai which
causes these QA issues, please tell us so that we can fix it, for
verifying Xenomai sources integrity, you can use the gpg signature.

-- 
					    Gilles.

