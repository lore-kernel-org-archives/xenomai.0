MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17506.9231.555209.471522@domain.hid>
Date: Wed, 10 May 2006 19:34:07 +0200
Subject: Re: [Xenomai-core] Pending ownership and resource stealing
In-Reply-To: <44621B00.7090703@domain.hid>
References: <44619D0B.1080402@domain.hid>
	<b647ffbd0605100216p7ba1d67eu7afc8df4fb29d828@domain.hid>
	<4461BB5A.3010403@domain.hid> <44621B00.7090703@domain.hid>
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Philippe Gerum wrote:
 > This means that skins now _must_ fix their internal state when unblocked 
 > from xnsynch_sleep_on() if they happen to track their own resource owner 
 > field for instance, since they might become the owner of such resource 
 > without any unlock/release/whatever routine being called at the said 
 > skin level. I've fixed a couple of skins for that purpose (not checked 
 > RTDM btw), but it would be safer if you could double-check the impact of 
 > such change on the interfaces you've crafted.

When waking up, how do we know that we are in the problematic situation
? Can we do the house keeping in the callback registered with
xnsynch_register_cleanup, or are you talking of a different situation ?


-- 


					    Gilles Chanteperdrix.

