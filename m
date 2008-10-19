Message-ID: <48FB6D40.5090903@domain.hid>
Date: Sun, 19 Oct 2008 19:24:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48FB693B.2080104@domain.hid>
In-Reply-To: <48FB693B.2080104@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH] x86: Don't instrument vdso functions
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

Jan Kiszka wrote:
> The mcount instrumentation is currently leaking into vdso functions.
> Patch below fixes this (bits taken from 2.6.27).

What are these vdso functions? Functions called from user-space?

-- 
					    Gilles.

