From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Date: Wed, 16 Aug 2006 13:05:53 +0200
References: <44E2DC1C.2010304@domain.hid>
	<200608161231.53239.Sebastian.Smolorz@domain.hid>
	<44E2F8DE.4000806@domain.hid>
In-Reply-To: <44E2F8DE.4000806@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608161305.54411.Sebastian.Smolorz@domain.hid>
Subject: [Xenomai-core] Re: Time representation in RTDM profiles
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

Jan Kiszka wrote:
> Sebastian Smolorz wrote:
> > The possibility of redefinition was not the main goal here. As you
> > mentioned it would be problematic. No, I introduced nanosecs_abs_t and
> > nanosecs_rel_t because they are more intuitive and more "speaking" to the
> > programmer. The meaning of a variable of such a type is clear at first
> > sight.
>
> Yeah, sounds reasonable to me. Then let's move these typedefs to rtdm.h
> and document them as self-explanatory defines of the underlying standard
> types, freezing their width and signedness at the same time.

Agreed.

>
> Actually, this would be useful for the driver API of RTDM as well.

That's right. No objections from my side.

Sebastian

