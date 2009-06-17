From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1245226350.3614.10.camel@domain.hid>
References: <1245226350.3614.10.camel@domain.hid>
Content-Type: text/plain
Date: Thu, 18 Jun 2009 00:13:41 +0200
Message-Id: <1245276821.19887.10.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] problem with gtk
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ludovic Lemarchand <ludovic.lemarchand@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2009-06-17 at 10:12 +0200, Ludovic Lemarchand wrote:
> Hello
> 
> I have patched a debian kernel 2.6.26 with Xenomai 2.4.7.
> 
> When I use Xenomai with gnome environment my computer freeze.
> 
> So, I have install kde. Its works perfectly but when I use a gtk
> software like firefox or eclipse, my computer freeze too.
> 
> I don't understand why Xenomai is not compatible with gtk.
> 

Any x86 patch older than adeos-ipipe-2.6.28.9-x86-2.2-07 is broken on
recent kernel releases on SMP hardware running a SMP kernel config, due
to a TLB flush issue. 2.6.26 patches are known to have this issue. You
should definitely use anything >= 2.2-07 for the x86 series.

> 
> I thank you for any response and suggestions.
> 
> Ludovic Lemarchand
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



