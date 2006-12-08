From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4577E600.6030608@domain.hid>
References: <4577E600.6030608@domain.hid>
Content-Type: text/plain
Date: Fri, 08 Dec 2006 18:47:04 +0100
Message-Id: <1165600024.9091.26.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Adeos-main] Differences between IPIPE v1.5 and
	v1.6
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: adeos-main@gna.org, xenomai-core <xenomai@xenomai.org>

On Thu, 2006-12-07 at 10:59 +0100, Wolfgang Grandegger wrote:
> Hi Philippe,
> 
> what are the major differences between the ADEOS-IPIPE patch versions 
> v1.5 and v1.6, apart from support for the new genirq layer. I realized, 
> that the arch specific files ipipe-core.c and ipipe-root.c have been 
> merged into ipipe.c.

Relying on the genirq layer, and the related changes it implies on the
flow handling in the I-pipe code, has motivated the version change. The
rest is x86 specific, and does not include radical changes (e.g. a few
more spinlocks ironed in the legacy driver code).

> 
> Wolfgang.
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
-- 
Philippe.



