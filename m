Subject: Re: fail clocktest -C CLOCK_HOST_REALTIME
References: <fa7df77f-23f9-4cc2-cc2e-aa1f9d4010bc@iit.it>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b2696236-4ba3-c9b0-a22f-9210f83cd163@siemens.com>
Date: Wed, 3 Jul 2019 19:26:16 +0200
MIME-Version: 1.0
In-Reply-To: <fa7df77f-23f9-4cc2-cc2e-aa1f9d4010bc@iit.it>
Content-Type: text/plain; charset=utf-8
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
To: alessio margan <alessio.margan@iit.it>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03.07.19 18:47, alessio margan via Xenomai wrote:
> Hi all,
> 
> I ve updated xenomai and switching from 3.0.6 to 3.0.9 with kernel 4.14.89
> 
> clocktest -C CLOCK_HOST_REALTIME
> 
> fails with this message
> 
> NVDSO_FEAT_HOST_REALTIME not available
> clock_gettime failed for clock id 32
> XNVDSO_FEAT_HOST_REALTIME not available
> 
> 
> I can not set CONFIG_XENO_OPT_HOSTRT=y in kernel config and seems that the 
> difference with the config I ve used with 3.0.6 was this.
> 

Argh... That got lost in the initial x86 ipipe port to 4.14. And, thus,
it's now also missing in 4.19. Will update both branches. You can try
this hunk already:

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b147b5c53af6..8409b9073422 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -147,6 +147,7 @@ config X86
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_IPIPE_SUPPORT		if X86_64
 	select HAVE_IPIPE_TRACER_SUPPORT
+	select IPIPE_HAVE_HOSTRT if IPIPE
 	select IPIPE_HAVE_SAFE_THREAD_INFO if IPIPE
 	select IPIPE_WANT_PTE_PINNING if IPIPE
 	select IPIPE_HAVE_VM_NOTIFIER if IPIPE

Thanks for reporting!
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

