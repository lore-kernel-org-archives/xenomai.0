Subject: Making skin libraries not dlopenable (was: Re: [Xenomai-core]
	[PATCH] silence libtool warnings)
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44DCABB2.1060706@domain.hid>
References: <44DCABB2.1060706@domain.hid>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 15:08:03 +0200
Message-Id: <1155906484.4326.82.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Fri, 2006-08-11 at 18:09 +0200, Jan Kiszka wrote:
> As we should not statically link the native/rtdm libraries against our
> new CAN tools (that code may reside on small embedded devices soon...),
> the old "Linking the executable XXXX ... is not portable!" warning now
> pops up again during Xenomai user-space build.
> 
> Here is an approach to work around that warnings already at libtool
> level (though I'm still convinced dropping "-module" would make more sense).

I don't like the idea of patching the .la files, really. But thinking a
bit more about the -module option than previously, it's likely that one
would want to dlopen a library using the skin, rather than the skin
itself. So I would eventually vote for getting rid of -module instead;
it looks like much saner.

If people have objections so as making skin libraries not dlopenable
anymore, it's the right time to express them.

-- 
Philippe.



