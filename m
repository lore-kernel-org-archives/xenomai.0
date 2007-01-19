Subject: Re: [Xenomai-core] Nocow patch.
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45B08DCF.3000708@domain.hid>
References: <45A52B04.1010706@domain.hid> <45A6554D.2060900@domain.hid>
	<1168714673.21854.17.camel@domain.hid> <45AB5BE6.8070309@domain.hid>
	<45B08DCF.3000708@domain.hid>
Content-Type: text/plain
Date: Fri, 19 Jan 2007 10:58:53 +0100
Message-Id: <1169200733.3964.29.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

On Fri, 2007-01-19 at 10:22 +0100, Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
> > However, after looking at the ARM patch, I am not so sure
> > __ipipe_update_all_pinned_mm() is the way to go on all architectures.
> > The ARM I-pipe handles vmalloc and ioremap faults without causing a mode
> > switch, I wonder if it is not better than having
> > __ipipe_update_all_pinned_mm() updating page directories all over the
> > place.
> 
> I checked with the I-pipe tracer the overhead on an ARM of a fault on a
> vmalloced area: it costs around 5 us.
> 

What is the average latency in user-space on this board for 1Khz and
10Khz periods?

Beyond that, we may want to keep both approaches at hand in the core
infrastructure; running the same benchmark on, say an integrator, may
give much higher latencies due to lousy cache issues. This still needs
to be verified though.

-- 
Philippe.



