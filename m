Date: Thu, 5 Aug 2010 14:58:28 +0200
From: Tschaeche IT-Services <services@domain.hid>
Message-ID: <20100805125828.GA22855@domain.hid>
References: <1276880276.12743.73.camel@domain.hid>
	<4C1BA6F7.9080004@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C1BA6F7.9080004@domain.hid>
Subject: Re: [Xenomai-help] [Xenomai-core] [PULL REQUEST] fixes for 2.5.4
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
Cc: xenomai@xenomai.org

On Fri, Jun 18, 2010 at 07:03:51PM +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > Recovery from runaway loops in primary mode is introduced by the mayday
> > patch series; the faulty thread gets relaxed, instead of being killed,
> > when the nucleus watchdog triggers.

just adapted to Xenomai 2.5.4 with a simple patch,
exporting the xnshadow_call_mayday() symbol from nucleus,
so that we can call it from our watchdog driver.

Should we call xnshadow_call_mayday() in another (official) way?

Regards,

	Olli

