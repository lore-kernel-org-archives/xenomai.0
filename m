Subject: Re: [Xenomai-help] Re: Timer problems?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44F16426.5010207@domain.hid>
References: <1903864415@domain.hid> <1154964748.4322.31.camel@domain.hid>
	<44EF17E8.5040606@domain.hid>
	<slrneeuefr.v1d.Bernhard.Walle@domain.hid>
	<44F0BBB7.7030703@domain.hid> <1156630353.4730.70.camel@domain.hid>
	<44F16426.5010207@domain.hid>
Content-Type: text/plain
Date: Sun, 27 Aug 2006 11:34:44 +0200
Message-Id: <1156671284.4325.4.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Kreyer <steve.kreyer@domain.hid>
Cc: Bernhard Walle <bernhard@domain.hid>, xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

On Sun, 2006-08-27 at 11:21 +0200, Steve Kreyer wrote:
> Hi Philippe,
> 
> disabling PM in Kernel was a good tip!
> 
> Now I can call standard linux library functions without resulting in a 
> system lock up :)
> But the ETIMEDOUT error when calling e.g. rt_task_wait_period or 
> rt_task_sleep still persists.
> The latency test gives me the following output:
> 
> -------------------------------------------------------------------------------------------------------------------
> == Test mode: periodic user-mode task
> == All results in microseconds
> latency: failed to set periodic, code -110
> warming up...
> ---|------------|------------|------------|--------|-------------------------
> RTS| -208983.489|       0.000|  208983.489|       0|    00:00:26/00:00:26
> -------------------------------------------------------------------------------------------------------------------
> 
> Also the attached application produces the below output:
> -------------------------------------------------------------------------------------------------------------------
> working!
> working!
> Warning: Cannot wait for task period! errcode=-110 110 timeout=1
> working!
> Warning: Cannot wait for task period! errcode=-110 110 timeout=1
> -------------------------------------------------------------------------------------------------------------------
> 
> The output string "working!" and the warning messages printed at once 
> and not as expected every second (see attachment)...
> The TROUBLESHOOTING file has no answer to this behaviour...
> 
> Do you have any hints on this?
> 

Try disabling ACPI completely, just to see if it is somehow involved.

-- 
Philippe.



