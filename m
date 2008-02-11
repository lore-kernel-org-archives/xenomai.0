Message-ID: <47B098F7.9080203@domain.hid>
Date: Mon, 11 Feb 2008 19:50:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47B0371E0200000100192400@domain.hid>
	<47B093D8.2050605@domain.hid>
In-Reply-To: <47B093D8.2050605@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] T_RRB
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Hubert Talbot <Hubert.Talbot@domain.hid>, xenomai@xenomai.org

Philippe Gerum wrote:
> Hubert Talbot wrote:
>> Hi,
>>
>> I'm new to Xenomai.
>>
>> I am studying xenomai and I would like to kwow how to apply round-robin.
>>
>> Specifically, what to do with (do I have to?):
>>
>> 	- the kernel configuration
>>
>> 		Real-time sub-system/Timing/Enable periodic timing ?
>>
> 
> Yes. Round-robin scheduling is only available with tick-based timing.

IMHO, this should finally be implemented for one-shot timebases as well.
Setting up an additional time-slice timer for such tasks shouldn't be
infeasible. Well, if I happen to have the time for this, one day... :)

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

