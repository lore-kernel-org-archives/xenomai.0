Message-ID: <443A5D7B.2040707@domain.hid>
Date: Mon, 10 Apr 2006 15:28:27 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG?] stalled xeno domain
References: <4437D2EE.4040902@domain.hid>
	<4437E704.4010607@domain.hid>	<443A437B.6010403@domain.hid>
	<443A5212.7020001@domain.hid> <443A56E2.1010204@domain.hid>
In-Reply-To: <443A56E2.1010204@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
>>>
>>>Philippe, do you see any remaining issues, e.g. that the leak survived
>>>the task termination? Does this have any meaning for correct driver and
>>>skin code?
>>>
>>
>>The only way I could see this leakage survive a switch transition would
>>require it to happen over the root context, not over a primary context.
>>Was it the case?
>>
> 
> 
> The task had to leave from primary mode. If I forced it to secondary
> before terminating, the problem did not show up.
> 

But does the code causing the leakage could have been run by different 
contexts in sequence, including the root one?

-- 

Philippe.

