Subject: Re: Re: [Xenomai-help] Howto catch SEGV signals in Xenomai
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <15252298.1173871082792.JavaMail.ngmail@domain.hid>
References: <1173868500.32259.10.camel@domain.hid>
	<22180008.1173860253238.JavaMail.ngmail@domain.hid>
	<1173825460.16997.107.camel@domain.hid>
	<11906791.1173797505269.JavaMail.ngmail@domain.hid>
	<45F6C278.4040709@domain.hid> <1173801179.16997.56.camel@domain.hid>
	<17910.63947.624116.867944@domain.hid>
	<1173825266.16997.105.camel@domain.hid>
	<21950566.1173862047952.JavaMail.ngmail@domain.hid>
	<15252298.1173871082792.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Wed, 14 Mar 2007 14:32:53 +0100
Message-Id: <1173879173.32259.52.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2007-03-14 at 12:18 +0100, M. Koehrer wrote:
> Hello Philippe,
> 
> here is a table of the test I have done:
> With the Xenomai SVN (#2292) I used the patches in the SVN repository:
> 2.6.19.2 with adeos-ipipe-2.6.19-i386-1.7-02.patch
> 2.6.20.2 with adeos-ipipe-2.6.20-i386-1.7-02.patch
> 
> With Xenomai-2.3.0 I used 
> 2.6.19.2 with adeos-ipipe-2.6.19-i386-1.6-03.patch
> 
> The result was, that with 2.6.20.2 it was working as expected,
> with 2.6.19.2 there was the PC freeze.

Ok, could you activate the nmi watchdog for the kernel (nmi_watchdog=2
added to the bootparams) and CONFIG_FRAME_POINTER, and also the nucleus
watchdog (CONFIG_XENO_OPT_WATCHDOG), in the failing case? Maybe one of
them would trigger. TIA,

> 
> Regards
> 
> Mathias
> > Could you confirm that, Adeos-wise, you tried both 2.6.19-1.6-03 (not
> > working) and 2.6.20-1.7-02 (working)? if so, does 2.6.19-1.7-02 (or -03)
> > also work in your configuration?
> > 
> 
> 
-- 
Philippe.



