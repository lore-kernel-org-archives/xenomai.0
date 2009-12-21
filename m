From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B2F3898.2060900@domain.hid>
References: <4B2EB7DA.7020709@domain.hid> <4B2EBA98.5060002@domain.hid>
	<4B2F3898.2060900@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 22 Dec 2009 00:01:23 +0100
Message-ID: <1261436483.19080.124.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Remove outdated x86 adeos patches
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Mon, 2009-12-21 at 09:58 +0100, Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
> > Jan Kiszka wrote:
> >> Hi Philippe,
> >>
> >> as adeos-ipipe-2.4.35.5-i386-1.3-05.patch and
> >> adeos-ipipe-2.6.29.5-x86-2.4-02.patch are no longer up to date /wrt to
> >> latest i-pipe fixes, I would suggest to remove them for 2.5-final.
> >> Avoids that people trap into known issues.
> > 
> > What latest fixes? Are they expected to oops or something?
> 
> 2.6.29 on x86-64: definitely (irq stack corruption). 32 bits and 2.4.35
> are lacking the halt fix (I bet other arch beyond x86 that use a
> hlt-like idle do so as well). It's not that they aren't fixable, it's
> just the question if we should bother anymore.
> 

Ack.

I don't even know whether anybody ever tried to run Xenomai over 2.4/x86
anyway, and I don't think this would ever make sense to do so today, so
2.4.35 will be removed.

2.6.29.4 will go away as well, since 2.6.30.8 and 2.6.31.1 have been
fixed, and hopefully, 2.6.33/86 will be supported in a foreseeable
future.

In any case, the README in the patches/ directory clearly states 
that adventurous people may try other options available from
http://download.gna.org/adeos/patches/

-- 
Philippe.



