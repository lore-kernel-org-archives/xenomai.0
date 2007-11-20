Message-ID: <47432325.5010509@domain.hid>
Date: Tue, 20 Nov 2007 19:10:45 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4738D9D1.5090802@domain.hid>
In-Reply-To: <4738D9D1.5090802@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH 0/5] Xenomai patch queue
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
Cc: Xenomai-core@domain.hid

Jan Kiszka wrote:
> Hi,
> 
> while the syscall tracing thing still puzzles me, I was now at least
> able to check that my patches do what they are supposed to. So here
> comes a flush of (most of) the stuff that piled up on my side, fixing or
> enhancing the following aspects:
> 
>  - x86 hal refactoring (-v2) - I decided to base my work on this because
>    it shakes the code anyway and also happens to touch hal stuff, thus
>    benefits from the unified version.
> 
>  - get timer frequency from ipipe (thus Linux) instead of relying on
>    home-brewed estimations (fixes inaccurate APIC frequency)
> 
>  - report configured timer and clock device via /proc/xenomai/timer
> 
>  - cleanup tickdev emulation (related to I-pipe refactorings)
>

Looks good. I will not even make a fuss about the ipipe_request_tickdev
API breakage (surprise, surprise...), since we should be able to avoid
the nuisance with proper detection of new I-pipe patches. To this end,
I'm going to introduce a known feature list as defines in new Adeos
releases, so that downstream may rely on their presence for proper
feature selection. This should hopefully help normalizing such kind of
detection code.

Will merge asap, to be included in -rc7 since most of the patch is about
moving code around to streamline the x86* HAL support.

Thanks,

-- 
Philippe.

