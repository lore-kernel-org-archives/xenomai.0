From: Jan Kiszka <jan.kiszka@siemens.com>
References: <6aedc4bc-74b5-4a9f-5c38-036a3d7850b9@siemens.com>
Message-ID: <9bd1c65a-ec5e-9d86-f9f4-179a4cd55eeb@siemens.com>
Date: Tue, 13 Mar 2018 07:29:39 -0700
MIME-Version: 1.0
In-Reply-To: <6aedc4bc-74b5-4a9f-5c38-036a3d7850b9@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PULL] ipipe 4.4 updates
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

On 2018-03-09 08:51, Jan Kiszka wrote:
> The following changes since commit 5618f90d33b17ab0ee9352705610a5e9f00f9964:
> 
>   Revert "ipipe: printk: defer dev_printk() output to safe context" (2017-12-15 18:10:01 +0100)
> 
> are available in the git repository at:
> 
>   git://git.xenomai.org/ipipe-jki for-upstream/4.4-update
> 
> for you to fetch changes up to c6de6878f74e4b079066eddc373f3e8c125fdaa7:
> 
>   Merge tag 'v4.4.120' into for-upstream/4.4-update (2018-03-08 18:49:28 +0100)
> 
> 
> I-pipe specific commits:
> 
> Jan Kiszka (5):
>       arm/ipipe: Avoid open-coded __ipipe_call_mayday
>       x86/ipipe: Deny JUMP_LABEL over I-pipe
>       Merge tag 'v4.4.109' into for-upstream/4.4-update
>       x86/ipipe: Disable access_ok context under I-pipe
>       Merge tag 'v4.4.120' into for-upstream/4.4-update
> 
> Philippe Gerum (1):
>       ipipe: printk: enable dev_printk() from the head stage
> 

I've force pushed a new version, now
94e9b41aa1e88636aff5e3e339a44d27fe93b3a6, because Simon spotted a
mistake in my entry_32.S merge:

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 62c356c5b7a6..d8fdbe2470cf 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1021,7 +1021,7 @@ error_code:
 	TRACE_IRQS_OFF
 #endif	
 	movl	%esp, %eax			# pt_regs pointer
-	CALL_NOSPEC *%edi
+	CALL_NOSPEC %edi
 #ifdef CONFIG_IPIPE
 	testl %eax,%eax
 	jnz restore_nocheck

The macros does the dereferencing.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

