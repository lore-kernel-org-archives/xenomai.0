Message-ID: <44623377.2090801@domain.hid>
Date: Wed, 10 May 2006 20:39:51 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Pending ownership and resource stealing
References: <44619D0B.1080402@domain.hid>	<b647ffbd0605100216p7ba1d67eu7afc8df4fb29d828@domain.hid>	<4461BB5A.3010403@domain.hid>	<44621B00.7090703@domain.hid>
	<17506.9231.555209.471522@domain.hid>
In-Reply-To: <17506.9231.555209.471522@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > This means that skins now _must_ fix their internal state when unblocked 
>  > from xnsynch_sleep_on() if they happen to track their own resource owner 
>  > field for instance, since they might become the owner of such resource 
>  > without any unlock/release/whatever routine being called at the said 
>  > skin level. I've fixed a couple of skins for that purpose (not checked 
>  > RTDM btw), but it would be safer if you could double-check the impact of 
>  > such change on the interfaces you've crafted.
> 
> When waking up, how do we know that we are in the problematic situation
> ?

The only possible issue with the new implementation is when the skin 
maintains its own specific data for tracking ownership of a resource, 
that complements the synch::owner field of the core nucleus resource 
object. The example code Jan has posted lately to raise the concern 
about the XNBREAK issue is also demonstrative of the issue of pending 
ownership, i.e.:

prio(task1) > prio(task2)

1. task1 grabs a resource
2. task1 sleeps for some time
3. task2 blocks requesting the resource
4. task1 wakes up from the sleep and releases the resource to task2
5. task1 wants the resource back immediately and calls 
xnsynch_sleep_on() since the ownership has been transferred to task2 
since step 4.
6a. old way: task1 would block and task2 would run anyway, with a PIP 
boost, blocking task1 until the resource is released
6b. new way: task1 steals the resource previously granted to task2 
directly from xnsynch_sleep_on(), but doing so, nobody downstream has 
had a chance to update any skin-specific data, such as an additional 
"owner" field.

The caller of xnsynch_sleep_on() in native/mutex.c illustrates this 
(i.e. grab_mutex label).

  Can we do the house keeping in the callback registered with
> xnsynch_register_cleanup, or are you talking of a different situation ?
> 
> 

It's different. The cleanup handler as described by Jan is only there to 
perform some housekeeping chores on synch objects which get forcibly 
released because their previous owner went away (typically xnpod_delete()).

-- 

Philippe.

