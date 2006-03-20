Message-ID: <441F1675.1010703@domain.hid>
Date: Mon, 20 Mar 2006 21:54:13 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] CONFIG_XENO_OPT_DEBUG_LEVEL
References: <441EFB6D.8000507@domain.hid>
In-Reply-To: <441EFB6D.8000507@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> as I started to actually use XENO_ASSERT, I noticed that there is no
> infrastructure yet to enable it. CONFIG_XENO_OPT_DEBUG_LEVEL is nowhere
> defined. Add this as integer to Kconfig? Or better convert
> nucleus/assert.h to CONFIG_OPT_DEBUG for now until we really feel like
> we need more than on/off for this? I would vote for the latter ATM.

Actually, we already need more than a simple switch: I'd really like the 
queue debugging option to become a level on its own (say, 4294967295?). 
I'll add this tomorrow.

> 
> Jan
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

