Message-ID: <cbe23c50702070603t75e5bf59w5ddbc0b20280ee09@domain.hid>
Date: Wed, 7 Feb 2007 15:03:12 +0100
From: "Eric Noulard" <eric.noulard@domain.hid>
Subject: Re: [Xenomai-help] Multiple NIC trouble
In-Reply-To: <45C9BA26.1040205@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cbe23c50702061337yc411319l881b9402e4677d6d@domain.hid>
	<17864.63903.244809.994959@domain.hid>
	<cbe23c50702062357m6d8b913fsc65af3339ba092de@domain.hid>
	<45C9B7C4.8050705@domain.hid> <45C9BA26.1040205@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

2007/2/7, Jan Kiszka <jan.kiszka@domain.hid>:
> Jan Kiszka wrote:
> > Eric Noulard wrote:
> >> 2007/2/6, Jan Kiszka <jan.kiszka@domain.hid>:
> >>>  o check if you have MSI enabled, if yes, try to disable it
> >> Sorry but I don't know what MSI is?
> >> Could you tell me how to check (and may be some
> >> pointer to valuable information which explains what it is)?
> >
> > Your /proc/interrupts output already suggests it: CONFIG_PCI_MSI is set
> > in your config.

It is I've checked the .config.
Nevertheless it is set in the vanilla config as well.

I've seen documentation in kernel source Documentation/MSI-HOWTO.txt
so I will read it at least to know in which way it is related to
interrupt handling.

>> It's worth trying the disable it, because even plain
> > Linux has problems with certain board/device combinations. But I don't
> > recall if tg3 was recently involved in such, it may still be an ipipe
> > bug here.

I will try this.

>
> On the other hand, CONFIG_ACPI is not set which may cause problems on
> modern systems as well.

I may try that too.
Why may this overall non ACPI config cause problem?

> You only need to disable CONFIG_ACPI_PROCESSOR
> for hard RT, the rest of ACPI can safely be enabled. Or is it disabled
> in your vanilla setup as well?

My vanilla config has both ACPI and ACPI_PROCESSOR enabled ('y')

-- 
Erk

