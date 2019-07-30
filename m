Subject: Re: [RFC][PATCH] lib/cobalt: Warn if forking without
 CONFIG_XENO_OPT_DEBUG_POSIX_SYNCHRO
References: <9cf97198-1d8c-9499-0fc6-228bebdd7ab2@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <0c44b7ed-c906-d5aa-1b11-b0edee95e5f9@xenomai.org>
Date: Tue, 30 Jul 2019 22:00:51 +0200
MIME-Version: 1.0
In-Reply-To: <9cf97198-1d8c-9499-0fc6-228bebdd7ab2@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 7/30/19 7:36 PM, Jan Kiszka wrote:
> This can crash too easily when a resource allocated by the parent is
> erroneously reused in the child process.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> I debugged basically this mistake today:
> 
>     sem_init(&sem, 0, 0);
> 
>     res = fork();
>     if (res == 0)
>         sem_destroy(&sem);
>     else
>         waitpid(res, NULL, 0);
> 
> With that debug switch on, sem_destroy just returns an error. Without
> it, the kernel crashes. Now I'm wondering if
> 
> a) we should make that check mandatory
> b) make the check at least default y
> c) apply a warning patch like this
> 
> Thoughts welcome!

Everything is better than allowing the kernel to go south voluntarily on
receiving a wrong argument, even after polite warnings, so my take would
be a) with some tweaking.

AFAICT, the current implementation tried not to over-interpret the
meaning of the EINVAL status which the Opengroup standard tersely
defines as "The sem argument does not refer to a valid semaphore.",
which is pretty much useless until we know what "valid" means in the
first place. So EPERM was used instead of EINVAL to refer to an existing
sema4 used from the wrong process context.

I would vote to turn all extra checks for DEBUG_POSIX_SYNCHRO into
mandatory code, returning EINVAL instead of EPERM (which is not
POSIX-sanctioned in these cases). I cannot imagine any app seriously
checking for EPERM today given this is an opt-in debug feature anyway.

-- 
Philippe.

