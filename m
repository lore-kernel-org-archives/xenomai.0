Message-ID: <4601059E.6040903@domain.hid>
Date: Wed, 21 Mar 2007 11:14:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai support for ARM926EJ
References: <fdba73240703151522l3aa73a81v84661caf17f489ae@domain.hid>	<17914.63535.18893.207257@domain.hid>	<fdba73240703201122w447cce8bl186ba32df55665c7@domain.hid>	<17920.13832.789072.876398@domain.hid>	<b647ffbd0703201721g1752e0falbe3fed8df405b3f8@domain.hid>
	<17920.60301.400005.135175@domain.hid>
	<4600F735.2030205@domain.hid>
In-Reply-To: <4600F735.2030205@domain.hid>
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
To: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> I think implementing coloured caches (with reservations for RT
> processes) could be an option as well. Once RT context switches no
> longer require full cache flushes, those for non-RT processes could be
> made interruptible. But all this would require heavy Linux hacking, I'm
> afraid.

Using TCM removes any cache effect and does not require Linux hacking.

-- 
                                                 Gilles Chanteperdrix


