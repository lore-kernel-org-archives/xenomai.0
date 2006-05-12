Message-ID: <44642811.20500@domain.hid>
Date: Fri, 12 May 2006 08:15:45 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: Stalled xenomai domain with head-optimisation
References: <446364DB.50908@domain.hid> <4463BB6F.8050008@domain.hid>
	<4463CF17.8070901@domain.hid>
In-Reply-To: <4463CF17.8070901@domain.hid>
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> 
> As long as I didn't messed my build up (it's late...): no effect for
> both patches.
> 

Ok, thanks. So does the following patch on the trunk/ make the bug
disappear, when using a vanilla Adeos support?

--- include/asm-generic/hal.h	(revision 1078)
+++ include/asm-generic/hal.h	(working copy)
@@ -118,7 +118,7 @@
  /* Obsolete Adeos patches do not support the invariant pipeline head
     optimization, so we check for the presence of __ipipe_pipeline_head
     to detect it. */
-#if defined(CONFIG_XENO_OPT_PIPELINE_HEAD) && defined(__ipipe_pipeline_head)
+#if defined(CONFIG_XENO_OPT_PIPELINE_HEAD) && defined(__ipipe_pipeline_head) && 0
  #define rthal_local_irq_disable()	ipipe_stall_pipeline_head()
  #define rthal_local_irq_enable()	ipipe_unstall_pipeline_head()
  #define rthal_local_irq_save(x)		((x) = !!ipipe_test_and_stall_pipeline_head())

-- 

Philippe.

