Message-ID: <4731CFA4.1030503@domain.hid>
Date: Wed, 07 Nov 2007 15:45:56 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E08F23C@esealmw118.eemea.ericsson.se>
In-Reply-To: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E08F23C@esealmw118.eemea.ericsson.se>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] rtdm_iomap_to_user() with PowerPC
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Markus Osterried <markus.osterried@domain.hid>
Cc: Xenomai-core@domain.hid

Markus Osterried wrote:
> Hello,
> 
> two months ago I reported a problem with rtdm_iomap_to_user().
> Philippe acknowledged the problem and promised to submit a bug fix.
> Unfortunately, till now I don't have seen this bug fix, or have
> overlooked it?

Please post your bugs to our bugtracker on gna.org if you feel like it
is getting/already got lost. Everyone is busy, and I'm afraid this
particular issue remained unfixed unintentionally.

> Can you please give me a hint about the roadmap?

This is surely a must-fix for both 2.4 and the next 2.3 releases, we are
only lacking the patch. Unless Philippe is able to come out with
something over the next, say, two days, I would suggest to develop a fix
along his original suggestions on your own. As far as I understood, we
need an arch-specific wrapper for io-remapping in
include/asm-powerps/wrappers.h and awareness for this specific solution
in asm-generic/wrappers.h.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

