Message-ID: <4732CE02.3060908@domain.hid>
Date: Thu, 08 Nov 2007 09:51:14 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E08F23C@esealmw118.eemea.ericsson.se>
	<4731CFA4.1030503@domain.hid>
	<E5E9C6CC7DC8844A8DA7A9EFE7B5350E08F23E@esealmw118.eemea.ericsson.se>
	<4731E311.7060406@domain.hid>
In-Reply-To: <4731E311.7060406@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] rtdm_iomap_to_user() with PowerPC
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Markus Osterried <markus.osterried@domain.hid>, Xenomai-core@domain.hid

Jan Kiszka wrote:
> Markus Osterried wrote:
>> Sorry for being intrusive.
>> I've already done a quick and dirty bug fix, so final bug fix is not
>> urgent.
>> Just wanted to know about time schedule.
> 
> At least 2.4 is near, but I guess another 2.3 release will follow as
> well (due to recently accumulated fixes). So the time is right to pick
> this up again.
> 
> And although Philippe said he would fix this one on his own, this does
> not have to mean no one else would be able to provide an equivalent fix
> as well and he wouldn't be happy to save the otherwise required time... :)
> 

Indeed. Quite frankly, the bug report is patiently pending in my queue,
so it was not lost, but I just had no time to address this seriously.
Have everything converge to roll out 2.4 drains much of my Xenomai time,
so I tend to put the non-critical issues on the back burner for now,
especially if they might break things in subtle ways.
Since there is a work around for this issue, and the final fix may make
it to any stable branch once 2.4 is out, I've postponed the latter.

-- 
Philippe.

