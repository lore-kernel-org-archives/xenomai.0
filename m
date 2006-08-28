Subject: Re: [Xenomai-help] Timer problems?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20060827122449.GC4340@domain.hid>
References: <1903864415@domain.hid> <1154964748.4322.31.camel@domain.hid>
	<44EF17E8.5040606@domain.hid> <44EF37BE.70207@domain.hid>
	<44F0B06B.6050102@domain.hid>
	<44F17616.9080701@domain.hid> <1156680494.4325.68.camel@domain.hid>
	<20060827122449.GC4340@domain.hid>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 16:46:24 +0200
Message-Id: <1156776385.4762.20.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bernhard Walle <Bernhard.Walle@domain.hid>
Cc: xenomai@xenomai.org

On Sun, 2006-08-27 at 14:24 +0200, Bernhard Walle wrote:
> Hello Philippe,
> 
> * Philippe Gerum <rpm@xenomai.org> [2006-08-27 14:08]:
> > With Linux 2.4, the sound generator is reached through a callback
> > pointer, so Xenomai just routes the latter to a dummy routine, and we
> > are done. With Linux 2.6, the callback has disappeared from the vanilla
> > kernel, and sound event requests are sent to the input sub-system for
> > processing, where we have currently no hack to void them. This is the
> > reason why disabling CONFIG_VT entirely is recommended when there is a
> > risk of conflict (which is rather drastic, I agree).
> 
> Why not patching the kernel at this point? Xenomai requires a kernel
> patch anyway.

This is why I did refer to Adeos as a mean to silence the speaker code,
as a last resort action (we need to keep this layer away from the
kitchen-sink disease). However, switching off CONFIG_PCSPKR would solve
the issue in a much more acceptable way.

> 
> 
> Regards, 
>   Bernhard
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



