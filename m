From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Date: Wed, 16 Aug 2006 12:31:52 +0200
References: <44E2DC1C.2010304@domain.hid>
In-Reply-To: <44E2DC1C.2010304@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608161231.53239.Sebastian.Smolorz@domain.hid>
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
> the current representation of timeouts and timestamps in RTDM device
> profiles is inconsistent.

I would welcome a consistent time value representation above all RTDM 
profiles, too.

> In the serial profile we use [u]int64_t 
> directly, the CAN profile defines its own types called
> nanosecs_{abs|rel}_t (though they just wrap the int64 ones).
>
> What is the idea of nanosecs? Having a way to redefine that type looks
> nice, but it's unfortunately the ABI, so we cannot easily change it
> without breaking apps.

The possibility of redefinition was not the main goal here. As you mentioned 
it would be problematic. No, I introduced nanosecs_abs_t and nanosecs_rel_t 
because they are more intuitive and more "speaking" to the programmer. The 
meaning of a variable of such a type is clear at first sight.

Sebastian

