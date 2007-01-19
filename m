Message-ID: <45B08DCF.3000708@domain.hid>
Date: Fri, 19 Jan 2007 10:22:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Nocow patch.
References: <45A52B04.1010706@domain.hid>
	<45A6554D.2060900@domain.hid>	<1168714673.21854.17.camel@domain.hid>
	<45AB5BE6.8070309@domain.hid>
In-Reply-To: <45AB5BE6.8070309@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> However, after looking at the ARM patch, I am not so sure
> __ipipe_update_all_pinned_mm() is the way to go on all architectures.
> The ARM I-pipe handles vmalloc and ioremap faults without causing a mode
> switch, I wonder if it is not better than having
> __ipipe_update_all_pinned_mm() updating page directories all over the
> place.

I checked with the I-pipe tracer the overhead on an ARM of a fault on a
vmalloced area: it costs around 5 us.

-- 
                                                 Gilles Chanteperdrix

