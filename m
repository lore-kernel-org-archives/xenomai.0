Message-ID: <48F897E7.90300@domain.hid>
Date: Fri, 17 Oct 2008 15:49:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48F3B231.6000105@domain.hid> <48F8745E.6070300@domain.hid>
	<48F89700.7090803@domain.hid>
In-Reply-To: <48F89700.7090803@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] xnpipe: fix state tracking of Linux side
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
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>> The state tracking of Linux tasks queue on xnpipe events was fairly
>>> broken. An easy way to corrupt some xnpipe_state_t object was to kill a
>>> Linux task blocked on opening a /dev/rtpX device (this left the state
>>> object queued in xnpipe_sleep, and hell broke loose on next queuing).
>>>
>>> Another problem that popped up after reworking xnpipe queuing was a
>>> stalled XNPIPE_USER_CONN after receiving a signal in xnpipe_open.
>>>
>>> The following patch addresses both issues, appears to run fine so far
>>> (at least the test case no longer triggers), and also cleans up some
>>> redundant nklock acquisitions/releases. Nevertheless, I may miss some
>>> corner case that might have triggered the original design. So please
>>> check carefully.
>> While fighting over a single bit elsewhere, let's not forget this open
>> issue:
> 
> I did not forget this issue. It is close to the top of stack now.
> 
>  Customer asks for a solution of the hard lock-up he faced, and
>> /me would like to know if this fix comes with no obvious regressions.
>>
> 
> The patch looks sane, but I want to run a few tests that have been developed
> over time to chase bugs in that code, before giving the patch a go. ETA: tomorrow.
> 

Great, thanks.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

