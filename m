Subject: Re: [PATCH 9/9] cobalt/debug: Detect vDSO via absence of vm_file
References: <cover.1634126152.git.jan.kiszka@siemens.com>
 <24c44d412bea623b3815e0b82428c7201e46a6b0.1634126152.git.jan.kiszka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <14c72470-93e6-8f88-2633-7e85edcd1bd7@siemens.com>
Date: Wed, 10 Nov 2021 13:23:35 +0100
MIME-Version: 1.0
In-Reply-To: <24c44d412bea623b3815e0b82428c7201e46a6b0.1634126152.git.jan.kiszka@siemens.com>
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
To: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

On 13.10.21 13:55, Jan Kiszka via Xenomai wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> VM_DENYWRITE was removed in 5.15, so we need a different criteria.
> Absence of a file-backing seems to be a good one.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  kernel/cobalt/debug.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/cobalt/debug.c b/kernel/cobalt/debug.c
> index a6e2cc42d3..0521fca45d 100644
> --- a/kernel/cobalt/debug.c
> +++ b/kernel/cobalt/debug.c
> @@ -249,13 +249,12 @@ void xndebug_trace_relax(int nr, unsigned long *backtrace,
>  			continue;
>  
>  		/*
> -		 * Hack. Unlike DSOs, executables and interpreters
> -		 * (e.g. dynamic linkers) are protected against write
> -		 * attempts. Use this to determine when $pc should be
> -		 * fixed up by subtracting the mapping base address in
> -		 * the DSO case.
> +		 * DSOs are not file-backed. Use this to determine when $pc
> +		 * should be fixed up by subtracting the mapping base address
> +		 * in the DSO case.
>  		 */
> -		if (!(vma->vm_flags & VM_DENYWRITE))
> +		file = vma->vm_file;
> +		if (file == NULL)
>  			pc -= vma->vm_start;
>  
>  		spot.backtrace[depth].pc = pc;
> @@ -265,7 +264,6 @@ void xndebug_trace_relax(int nr, unsigned long *backtrace,
>  		 * record the PC value, which may still give some hint
>  		 * downstream.
>  		 */
> -		file = vma->vm_file;
>  		if (file == NULL)
>  			goto next_frame;
>  
> 

Philippe, could you comment on this change? Does this sound safe enough
to you? How to test that best?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

