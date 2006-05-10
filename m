Message-ID: <44621B00.7090703@domain.hid>
Date: Wed, 10 May 2006 18:55:28 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: [Xenomai-core] Pending ownership and resource stealing
References: <44619D0B.1080402@domain.hid>	<b647ffbd0605100216p7ba1d67eu7afc8df4fb29d828@domain.hid>
	<4461BB5A.3010403@domain.hid>
In-Reply-To: <4461BB5A.3010403@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:

> Besides this, we then may want to consider if introducing a pending
> ownership of synch objects is worthwhile to improve efficiency of PIP
> users. Not critical, but if it comes at a reasonable price... Will try
> to draft something.
> 

I've committed an implementation of this stuff to the trunk, tested on 
your testcase over the simulator. So far, it's ok. The only thing that 
should change downstream compared to the previous behaviour is that 
xnsynch_sleep_on() might unblock immediately at skin level without any 
xnsynch_wakeup_sleeper() calls being previously invoked, since the 
blocking call does the stealing during the pending ownership window.

This means that skins now _must_ fix their internal state when unblocked 
from xnsynch_sleep_on() if they happen to track their own resource owner 
field for instance, since they might become the owner of such resource 
without any unlock/release/whatever routine being called at the said 
skin level. I've fixed a couple of skins for that purpose (not checked 
RTDM btw), but it would be safer if you could double-check the impact of 
such change on the interfaces you've crafted.

This change only affects PIP-enabled synchronization objects in a 
reasonably limited manner and seems to behave properly, but please, give 
this code hell on your side too.

-- 

Philippe.

