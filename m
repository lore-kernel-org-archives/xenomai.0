From: Thomas Kuhlmann <maillist@domain.hid>
Date: Tue, 29 Jun 2004 12:42:32 +0200
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406291242.32834.maillist@domain.hid>
Subject: [Adeos-main] what should __adeos_set_timer(hz) do?
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos-main@gna.org

Hello,

based on the adeos-linux-2.4.22-armnommu-r12.patch for uClinux 2.4.22-uc0 from 
http://download.gna.org/adeos/patches/v2.4/armnommu/ I'm trying to extend 
(port) this patch for armnommu/arch-netarm/ (NetSilicon NS7520 processor).

Has anybody tried a patch for armnommu/arch-netarm (just to prevent me doing 
it again)?

The function __adeos_set_time(unsigned long hz) has to be ported to netarm. 
However what should it do?
In the given patch for the armnommu/arch-atmel/ it looks like the kernel timer 
is disabled, the frequency is changed, and the timer is enabled again (not 
one shot, but periodic mode). Is this the correct semantics of 
__adeos_set_timer(hz)?

Sorry if my question is misplaced here and I'd better contact the ARM 
responsible persons (let me know of this).

Thanks, Thomas.
-- 
Thomas Kuhlmann, FS Forth-Systeme GmbH, www.fsforth.de
Kueferstrasse 8, D-79206 Breisach, Germany
Phone: +49 (7667) 908 144 Fax: +49 (7667) 908 221

