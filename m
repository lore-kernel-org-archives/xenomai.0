Message-ID: <44905D1D.6070703@domain.hid>
Date: Wed, 14 Jun 2006 13:01:49 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Porting xeno-{info|load|test} to a busybox system
References: <200605252134.08614.niklaus.giger@domain.hid>
	<44770814.5040009@domain.hid>
	<200605261852.45980.niklaus.giger@domain.hid>
	<4485E647.7010205@domain.hid> <448DCF9F.807@domain.hid>
	<448DD841.1040906@domain.hid>
In-Reply-To: <448DD841.1040906@domain.hid>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Jim Cromie wrote:
>>
>>> Niklaus Giger wrote:
>>>
>>>> Am Freitag, 26. Mai 2006 15:52 schrieb Jan Kiszka:
>>>>
>>>>
>>>>> Niklaus Giger wrote:    ...
>>>>> If anybody has a working target with a Xenomai + BusyBox 
>>>>> combination and
>>>>> would be willing to test drive my changes, I would appreciate a 
>>>>> feedback
>>>>> enormously.
>>>>>  
>>>
>>> I hope this isnt waiting on my 'approval'.
>>> I think its a great idea, and has been on my (way too stagnant) list 
>>> for
>>> a while.
>>> Your work has at least urged me to install busybox on my xeno-box. ;-)
>>>
>>> My only concern is whether we've sufficiently distinguished the issues:
>>>
>>> 1 - ash vs bash
>>>
>>> Its not entirely clear to me which flavors of sh busybox has:
>>>    ash / dash / not-bash
>>> I gather u worked with ash, and it seems most valuable sh features
>>> work there just fine ( shell-functions, even 'job-control' of a 
>>> fashion)
>>>
>>> 2 - busybox 'executables' only
>>>
>>> I coded in a lot of 'full linux' gimme's, like zgrep, script, etc.
>>> Niklaus has repaired many of these.  I think a more thorough cleanup is
>>> possible,
>>> esp if things like 'script' are jettisoned for a simpler 
>>> shell-functions
>>> or helper scripts.
>>> This all implies a re-write, which is on my list...
>>> (esp the job-control testing and repair)
>>
>>
>> Just stumbled over this again while cleaning up my mailbox. What's the
>> status? Waiting for improvements, or waiting for /someone/ to type svn
>> ci (and improve the topics above later)?
>>
>
> It's queued for now, waiting for a combined ack to merge the current 
> patch from JimC and Niklaus.
>

AFAIC, Niklaus is in the lead atm.
Im trying to get some GPIO stuff ready for -mm.
( I'll post separately on this ..)

I ran his changes once, I dont even remember what it did.
(which suggests that it didnt explode ;-)
IMO, take it when Niklaus says its ready.
I have some local changes here, but Ill work them into shape after
Niks changes go in (maybe much later :-(

We should probly confer on the longer-term issues too.

- a rational option-pass-thru, or a means to avoid doing so.
if we assume OPTS_${TOOLNAME} exists, we could
grab it out of env, and pass it into the benchmark prog.
 - would require no prog mods, but gives us complete control
- would play nicer than assuming -T <secs> has meaning for all progs.




