From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Clean up noarch ipipe queue
Message-ID: <b5b40eb8-2add-fa43-3d17-70d111362ab9@siemens.com>
Date: Wed, 27 Feb 2019 07:21:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Hi Philippe,

I started to revert the patches in the x86 tree that are touching arch/arm. One 
fragment may be reverted for everyone:

--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -106,10 +106,6 @@ static inline u32 arch_timer_get_cntkctl(void)

  static inline void arch_timer_set_cntkctl(u32 cntkctl)
  {
-#ifdef CONFIG_IPIPE
-	/* Enable access to user-space (may not be needed) */
-	cntkctl |= ARCH_TIMER_USR_PCT_ACCESS_EN;
-#endif
  	asm volatile("mcr p15, 0, %0, c14, c1, 0" : : "r" (cntkctl));
  }


Or are we exploiting user space access?

FWIW, I've reverted now these three:

e219c3bbc14e4d00178b50bb7b992c9817a2aa16
259c0c09953d3559618c69f29f5c2aa9fe570a24
77361f93e4be1bf23025b01d0d64379a681e11a3

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

