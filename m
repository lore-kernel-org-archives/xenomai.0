Message-ID: <443036D6.2020206@domain.hid>
Date: Sun, 02 Apr 2006 22:40:54 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Adeos/2.6.16-ia64: need tester
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: adeos-main@gna.org
Cc: xenomai@xenomai.org


I've upgraded the Adeos support for the Itanium architecture to the 
latest 2.6.16 kernel, but unfortunately, I just can't make it boot on 
HP's "ski" ia64 simulator, even with the I-pipe feature disabled, albeit 
everything worked like a charm up to 2.6.15.

Since I have no ia64 hw at hand, I just cannot validate this patch at 
all myself. If anyone on these lists has any interest in running Adeos 
w/wo Xenomai over this architecture with access to the proper hw, please 
let me know if this patch works for you. TIA,

PS: in order to run Xenomai over this patch, you will need to pull the 
Xenomai code from our SVN trunk/ since a few things need to be fixed for 
using 2.6.16 on this arch.

http://download.gna.org/adeos/patches/v2.6/ia64/testing/adeos-ipipe-2.6.16-ia64-1.2-02.patch

-- 

Philippe.

