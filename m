Message-ID: <4741849C.7090308@domain.hid>
Date: Mon, 19 Nov 2007 13:42:04 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <472F6C17.2070100@domain.hid>	<472F6DAD.20308@domain.hid>	<472F990A.2030209@domain.hid>	<473006D8.4080808@domain.hid>	<47302D55.9050808@domain.hid>	<47339C53.5010700@domain.hid>	<4734677E.6010904@domain.hid>	<47348EE0.5020007@domain.hid>	<473493CB.4080701@domain.hid>	<4734995B.20900@domain.hid>
	<4737510F.7010309@domain.hid> <47397C4B.1070901@domain.hid>
	<4739E19D.3000004@domain.hid> <47417ABC.3050100@domain.hid>
In-Reply-To: <47417ABC.3050100@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Adeos-main] [PATCH] i386: switch to root domain
 on unhandled non-root faults
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
Cc: adeos-main@gna.org, Xenomai-core@domain.hid

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> OK, attached is an attempt to follow your arguments, while also keeping
>> topics separate which have different backgrounds (ie. clarify the
>> messages). As we go for reporting user faults now, lets include those
>> (unlikely and really buggy) cases over user mode as well.
> 
> I guess you meant this?
> 
> - if ((error_code & 4) && !search_exception_tables(regs->eip))
> + if ((error_code & 4) || !search_exception_tables(regs->eip))

Oh... yeah.

> 
> In any case, I fully agree on the logic of your latest patch. Will
> commit, thanks.
> 

That's fine.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

