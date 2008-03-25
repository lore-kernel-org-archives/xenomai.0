From: Wolfgang Denk <wd@domain.hid>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Sun, 23 Mar 2008 11:14:10 +0100."
	<47E62D72.4060306@domain.hid>
Date: Tue, 25 Mar 2008 23:49:19 +0100
Sender: wd@domain.hid
Message-Id: <20080325224919.582BD243A7@domain.hid>
Subject: Re: [Xenomai-core] Xenomai/SOLO - RTOS emulation for standard Linux
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roland Stigge <stigge@domain.hid>
Cc: xenomai@xenomai.org

Dear Roland,

in message <47E62D72.4060306@domain.hid> you wrote:
> 
> Is it worth providing a separate xenomai-solo package in Debian right
> now (considering it being propagated to Debian 5.0 and supported there
> in this form until ca. 2010), or should we wait until Xenomai/SOLO is
> integrated into Xenomai mainline?

Integration into Xenomai mainline means waiting for Xenomai 3, which
seems still a pretty long way to go.

On the other hand, you need a PREEMPT_RT enhanced  Linux  kernel  for
Xenomai/SOLO  to provide real-time behaviour which is probably needed
in most cases when you try and emulate a RTOS.  This  is  probably  a
bigger hurdle?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
It is clear that the individual who persecutes a  man,  his  brother,
because he is not of the same opinion, is a monster.       - Voltaire

