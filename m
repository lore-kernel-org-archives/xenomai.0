From: Paul <paul_c@domain.hid>
Date: Thu, 30 Dec 2010 06:54:27 +0000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201012300654.27439.paul_c@domain.hid>
Subject: [Adeos-main] Bug in 2.6.35-7 patch
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>


Compiling the current ipipe patch for x86 
(adeos-ipipe-2.6.35.7-x86-2.8-00.patch), hit a problem with 
__ipipe_spin_unlock_debug being unresolved. Digging in to 
linux/ipipe.h, I see it is conditional on CONFIG_IPIPE_DEBUG_INTERNAL, 
yet in core.c, it also depends on CONFIG_SMP. The blackfin & powerpc 
patches are correct... Could someone please take a look at ipipe.h, 
line 193 and confirm the error.

Regards, Paul.


