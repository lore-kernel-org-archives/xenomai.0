Message-ID: <47EDFEA4.2020701@domain.hid>
Date: Sat, 29 Mar 2008 09:32:36 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20080328190310.GB9009@domain.hid>	<47ED4C7A.8070809@domain.hid>
	<20080328204631.GC9009@domain.hid>
In-Reply-To: <20080328204631.GC9009@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH][SOLO] add more warnings
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
To: Robert Schwebel <r.schwebel@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Robert Schwebel wrote:
> On Fri, Mar 28, 2008 at 08:52:26PM +0100, Philippe Gerum wrote:
>>> I've looked into the first ones only yet and it looks to me like the
>>> type definitions have to be reviewed carefully. For example, TASK_ID is
>>> defined to be unsigned long, whereas the vxworks documentation [1] looks
>>> more like if we need 'int' there. Which also makes me wonder if vxworks
>>> has a special idea about what 'int' is;
>> VxWorks assumes 32bit and sizeof(void *) == sizeof(int), unfortunately. See
>> taskSpawn() for instance.
> 
> Yes, which probably means that using 'int' and friends is not a good
> idea.
> 
>> Did you mean stdint.h?
> 
> Probably better, yes.
> 
>> What we need is an integer type which is able to carry a pointer on
>> 32/64bit platforms, so we should rather use intptr_t I guess, as per
>> C99, which expands as a long type. Object ids as unsigned long is a
>> left over from the co-kernel version, where we use actual integer
>> handles returned from kernel space, and not pointers in disguise. Will
>> fix, thanks.
> 
> Hmm, if vxworks assumes "int" to be 32 bit, couldn't it lead to problems
> if the pointer size itself isn't 32 bit as well?
>

VxWorks only documents that one may assume TASK_ID == pointer to TCB, which
implies sizeof(int) == sizeof(struct WIND_TCB *) as per the taskInit
documentation and the original taskSpawn prototype. But using a different scalar
type than int to underlay TASK_ID, which would guarantee sizeof(TASK_ID) ==
sizeof(struct WIND_TCB *) is logically ok (and actually always worked so far in
actual ports of legacy apps over the VxWorks skin).

Said differently, any application assuming that a task identifier must be 32bit
wide would only work in a 32bit environment anyway, as implied by the initial
VxWorks assumption that sizeof(TASK_ID) == sizeof(struct WIND_TCB *). Given that
sizeof(intptr_t) is 32bit in such environment, we would be fine in this case as
well.

>> Merged, thanks.
> 
> Doesn't show up on http://www.denx.de/cgi-bin/gitweb.cgi?p=xenomai-solo.git;a=summary
> 

My GIT tree is mirrored by a cron job to the public repo. You will see the
changes after the next refresh has taken place.

> ?
> 
> Robert


-- 
Philippe.

