Message-ID: <4587ECF0.4000907@domain.hid>
Date: Tue, 19 Dec 2006 14:45:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: [RFC] git workflow
References: <4582E67C.70108@domain.hid> <4587E99D.9070404@domain.hid>
In-Reply-To: <4587E99D.9070404@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

Jan Kiszka wrote:
> Jan Kiszka wrote:
> 
>>...
>>[Keeping up-to-date]
>> 1. The original kernel tree may have been updated, and the ipipe patch
>>    needs to be rebased
>>
>>    # git fetch
>>    # git rebase origin
> 
> 
> I meanwhile learned that rebasing doesn't work well with public git
> tree. Once you pushed some tree, say, linux-2.6.19 + ipipe-patch1..n
> out, you cannot rebase to 2.6.20 + ipipe-patch1..n without breaking the
> linear history.
> 
> Either we only push out final trees (but that would lock-out early
> testers that may want to pull from devel-head), or we need to evolve
> with ipipe patches deeply merged. That means when we have 2.6.19 + ipipe
> cleanly on top of it, pulling 2.6.20 origin may cause conflicts (like
> the paravirt stuff does on i386 ATM). We would then have to merge the
> upstream patches into the I-pipe tree, effectively adopting them to
> I-pipe. An extraction of a potential I-pipe patch stack would be more
> complicated that way, but not infeasible.
> 
> Comments?

I am a complete git newbie myself. But the simpler way I would imagine
to develop the I-pipe would be to create one branch for each version of
the kernel. We would then use a script to generate all architectures
specific patches.

Porting from one version to the next means merging the difference
between the ipipe branch for linux 2.x.y and the linux 2.x.y sources
with the linux-2.x.y+1 sources.


-- 
                                                 Gilles Chanteperdrix

