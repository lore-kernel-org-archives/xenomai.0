Message-ID: <b647ffbd0703100850g419b736bwe7dc5b1ab7f396fe@domain.hid>
Date: Sat, 10 Mar 2007 17:50:07 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] Adding mips support in configure file of xenomai
In-Reply-To: <528bc2040703092348k3cec93d5hc115718aad37ff7f@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <528bc2040703092348k3cec93d5hc115718aad37ff7f@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: manoj kumar <manojkpanghal@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Hi,

>
> I am working on mips board & i need to compile the xenomai soure &
> libraries for mips architecture, so that i can develope application on
> mips board.

Xenomai doesn't support MIPS architecture at the moment.

> whether for all this i need to update or add support for mips in
> configure scripts file in xenomai source? if yes, then how approch
> that, if no, then what is the altenative.

to add support one would need to implement:

(1) adeos-ipipe port over MIPS architecture;
(2) Xenomai (arch-dependent part) port over MIPS;

(3) additional board specific bits for (1) /and (2)/ where necessary.

btw, I started some activity on (1) this week [ yep, good plan is
nothing more but good intentions unless hard work starts immediately
:) ]
The initial port will be over Qemu. So I'm going to address the
generic MIPS support + (most likely) MIPS Malta systems (as it's
deemed to be emulated with the recent Qemu release).

But I don't have any strict time-schedule as I 'm doing it in my spare
time and just for fun :)


> Thanks in advance
>
> Regards
> Manoj Kumar.

-- 
Best regards,
Dmitry Adamushko

