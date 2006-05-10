MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17506.18027.836408.819871@domain.hid>
Date: Wed, 10 May 2006 22:00:43 +0200
Subject: Re: [Xenomai-core] Pending ownership and resource stealing
In-Reply-To: <44623377.2090801@domain.hid>
References: <44619D0B.1080402@domain.hid>
	<b647ffbd0605100216p7ba1d67eu7afc8df4fb29d828@domain.hid>
	<4461BB5A.3010403@domain.hid> <44621B00.7090703@domain.hid>
	<17506.9231.555209.471522@domain.hid>
	<44623377.2090801@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
 > prio(task1) > prio(task2)
 > 
 > 1. task1 grabs a resource
 > 2. task1 sleeps for some time
 > 3. task2 blocks requesting the resource
 > 4. task1 wakes up from the sleep and releases the resource to task2
 > 5. task1 wants the resource back immediately and calls 
 > xnsynch_sleep_on() since the ownership has been transferred to task2 
 > since step 4.
 > 6a. old way: task1 would block and task2 would run anyway, with a PIP 
 > boost, blocking task1 until the resource is released
 > 6b. new way: task1 steals the resource previously granted to task2 
 > directly from xnsynch_sleep_on(), but doing so, nobody downstream has 
 > had a chance to update any skin-specific data, such as an additional 
 > "owner" field.

Posix skin mutexes work the new way without calling xnsynch_sleep_on, so
probably need fixing.

-- 


					    Gilles Chanteperdrix.

