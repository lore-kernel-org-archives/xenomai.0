Message-ID: <44463272.8020009@domain.hid>
Date: Wed, 19 Apr 2006 08:52:02 -0400
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [patch] xeno-test email addition
References: <200604171047.51730.niklaus.giger@domain.hid>	<4445068A.8000008@domain.hid>	<44450CC2.4080505@domain.hid>	<200604191255.09080.rlenglet@domain.hid>
	<4445FC6E.7050001@domain.hid>
In-Reply-To: <4445FC6E.7050001@domain.hid>
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
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Romain Lenglet wrote:
>>>>> The -M option works, since I just received an email Id sent
>>>>> earlier, but I also sent one to xenomai-core, and it hasnt
>>>>> shown up yet. I suspect that the mail looks like spam, and
>>>>> has been rejected, since my hostname is not a real FQDN.
>>>>> So Im not so sure that email is the best way here, but it
>>>>> is conceptually simple.
>>>>
>>>> Oof.  Now attached.
>>>
>>> Applied, thanks.
>>

Doh - small err. 
if [ $sendit = 1 ] needs quotes around the var, for when its undeffd.
will patch soon.

Im looking for other things to add, in part to prevent a changelog entry 
that says
"fixed a dumb tested-new-but-not-old, so bug got out" entry :-/

- change the prewired -m email-addy ?  (to xeno-stats@domain.hid)
- add From: header to get past subscriber-only check.
    should this be a prewired addy (forex  xeno-test-output@domain.hid)
    or the user's name ( if so, which ENVAR should we use ?  XENO_USER ?)
- verbose (send whole config atm, perhaps others later)
- run xeno-info, xeno-config
- grep more config-items out of config (for non-verbose mode)
    latency-killers presumably, PREEMPT, others ?
- NPTL availability (kinda overkill, since its absence when needed is 
already detected)

Can anyone think of other possibly useful raw data ?
I think Ive already got everything that LiveCD collected, plus some.


thanks
jimc


PS.  Is "Engines of Creation" another Joe Satriani album ?

PPS.    the dude can *rip* a fretboard.  In "real-time"

PPPS.  I bet Philippe plays a mean air-guitar ;-)

