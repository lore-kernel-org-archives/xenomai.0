From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20100805125828.GA22855@domain.hid>
References: <1276880276.12743.73.camel@domain.hid>
	<4C1BA6F7.9080004@domain.hid>
	<20100805125828.GA22855@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 05 Aug 2010 16:00:45 +0200
Message-ID: <1281016845.1706.0.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Tschaeche IT-Services <services@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2010-08-05 at 14:58 +0200, Tschaeche IT-Services wrote:
> On Fri, Jun 18, 2010 at 07:03:51PM +0200, Gilles Chanteperdrix wrote:
> > Philippe Gerum wrote:
> > > Recovery from runaway loops in primary mode is introduced by the mayday
> > > patch series; the faulty thread gets relaxed, instead of being killed,
> > > when the nucleus watchdog triggers.
> 
> just adapted to Xenomai 2.5.4 with a simple patch,
> exporting the xnshadow_call_mayday() symbol from nucleus,
> so that we can call it from our watchdog driver.
> 
> Should we call xnshadow_call_mayday() in another (official) way?

xnshadow_call_mayday() is already exported to modules in 2.5.4.

> 
> Regards,
> 
> 	Olli

-- 
Philippe.



