MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18041.27594.473072.29460@domain.hid>
Date: Wed, 20 Jun 2007 20:02:50 +0200
In-Reply-To: <18041.27025.80273.654686@domain.hid>
References: <467639BE.30504@domain.hid> <467641F3.3010308@domain.hid>
	<1182357772.6137.39.camel@domain.hid>
	<18041.27025.80273.654686@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [PATCH-STACK] Synchronised timebases and more
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
 > xnpod_settime does not do what the posix spec wants is the reason why

s/xnpod_settime/xntbase_set_time/

The code changed when I was not looking.

-- 


					    Gilles Chanteperdrix.

