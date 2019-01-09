Subject: Re: [PATCHv2] cobalt/x86: fix condition in eager fpu code for kernels
 < 4.14
References: <20181221134452.15743-1-henning.schild@siemens.com>
 <20190107130416.25271-1-henning.schild@siemens.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <fee3a41a-b90c-9432-8f59-d3c93ed5aac1@web.de>
Date: Wed, 9 Jan 2019 22:22:06 +0800
MIME-Version: 1.0
In-Reply-To: <20190107130416.25271-1-henning.schild@siemens.com>
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
To: Henning Schild <henning.schild@siemens.com>, xenomai <xenomai@xenomai.org>

On 07.01.19 21:04, Henning Schild via Xenomai wrote:
> From: Henning Schild <henning.schild@siemens.com>
> 
> We should mark the current task as not owning the fpu anymore if it does
> actually own the fpu, not if the fpu itself is active.
> 
> Fixes cb52e6c7438fa
> 
> Reported-by: Mauro Salvini <mauro.salvini@smigroup.net>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>   kernel/cobalt/arch/x86/thread.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/cobalt/arch/x86/thread.c b/kernel/cobalt/arch/x86/thread.c
> index a09560075..ba807ac1e 100644
> --- a/kernel/cobalt/arch/x86/thread.c
> +++ b/kernel/cobalt/arch/x86/thread.c
> @@ -475,7 +475,7 @@ void xnarch_leave_root(struct xnthread *root)
>   	switch_fpu_finish(&current->thread.fpu, smp_processor_id());
>   #else
>   	/* mark current thread as not owning the FPU anymore */
> -	if (&current->thread.fpu.fpstate_active)
> +	if (fpregs_active())
>   		fpregs_deactivate(&current->thread.fpu);
>   #endif
>   }
> 

Thanks, applied it next.

Jan

