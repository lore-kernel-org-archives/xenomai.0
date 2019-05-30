Subject: Re: [RFC PATCH] cobalt: Allow tasks with non-locked memory
References: <20190529210559.20860-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <64455108-2e8b-146c-15f9-e3a98030f0dc@web.de>
Date: Thu, 30 May 2019 11:54:12 +0200
MIME-Version: 1.0
In-Reply-To: <20190529210559.20860-1-richard@nod.at>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>, xenomai@xenomai.org

On 29.05.19 23:05, Richard Weinberger via Xenomai wrote:
> libsanitizer intercepts mlockall() and makes it a nop.
> Handle this case here to allow debugging Xenomai applications
> with ASAN and friends.
>
> While fixing Linux or libsanitizer would be the prettiest approach,
> making cobalt less strict regarding VM_LOCKED is the most practical
> way to get libsanitizer work with Xenomai.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> Hi!
>
> I'm using a variant of this patch to utilize ASAN/UBSAN to test in-house
> Xenomai applications.
>
> libsanitizer seems do disable mlockall() due to a Linux bug:
> https://github.com/gcc-mirror/gcc/blob/master/libsanitizer/sanitizer_com=
mon/sanitizer_common_interceptors.inc#L5982
>
> Thanks,
> //richard
> ---
>   kernel/cobalt/posix/process.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process=
.c
> index 6b10abb699d5..86ceac826ae0 100644
> --- a/kernel/cobalt/posix/process.c
> +++ b/kernel/cobalt/posix/process.c
> @@ -579,11 +579,9 @@ static inline int disable_ondemand_memory(void)
>   	siginfo_t si;
>
>   	if ((p->mm->def_flags & VM_LOCKED) =3D=3D 0) {
> -		memset(&si, 0, sizeof(si));
> -		si.si_signo =3D SIGDEBUG;
> -		si.si_code =3D SI_QUEUE;
> -		si.si_int =3D SIGDEBUG_NOMLOCK | sigdebug_marker;
> -		send_sig_info(SIGDEBUG, &si, p);
> +		printk(XENO_WARNING
> +			"%s[%d] Task without VM_LOCKED, latencies expected!\n",
> +			current->comm, task_pid_nr(current));
>   		return 0;
>   	}
>
>

Why not simply installing a signal handler in the application that swallow=
s this
reason for SIGDEBUG when it's under libsanitizer controller? Or setting th=
e
whole signal on ignore?

Jan

