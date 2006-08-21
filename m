Subject: Re: [Xenomai-help] Oops on PPC405EP
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44E9C535.3050400@domain.hid>
References: <44E9B5A1.3010102@domain.hid>	<44E9BA20.4000607@domain.hid>
	<17641.49824.304831.889667@domain.hid>
	<44E9C535.3050400@domain.hid>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 18:46:30 +0200
Message-Id: <1156178791.3155.39.camel@domain.hid>
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
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-08-21 at 16:37 +0200, Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
> > Heikki Lindholm wrote:
> >  > Since your hardware AFAIK does not have an FPU, shouldn't you be 
> >  > compiling Xenomai without hardware FPU support?
> > 
> > Maybe we could prevent this mistake in Kconfig ?
> > 
> 
> I already wanted to ask the same.
> 
> Do we have such a dependency on other archs as well?

Yep, ARM.

> 
> Jan
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



