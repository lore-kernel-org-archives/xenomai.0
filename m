Subject: Re: Fwd: [Patch 1/5] Problems with upstream SPECTRE mitigation found
 in sendmsg/recvmsg syscalls
References: <1174-5fce0a00-6b-37e14c00@74918186>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b2847e78-c7c9-056c-1c47-3404eaaad2aa@siemens.com>
Date: Fri, 11 Dec 2020 07:55:22 +0100
MIME-Version: 1.0
In-Reply-To: <1174-5fce0a00-6b-37e14c00@74918186>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <francois.legal@thom.fr.eu.org>, xenomai@xenomai.org

On 07.12.20 11:55, François Legal via Xenomai wrote:
> From: François LEGAL <devel@thom.fr.eu.org>
> 
> Remove the copy of struct struct user_msghdr onto stack allocated buffer.
> 

Reasoning is missing here: The driver callbacks are supposed to do that
copy-from-user.

But the Question is: why? Is that local copy history left-over, or do
only the drivers know how much to copy?

Jan

> Signed-off-by: François LEGAL <devel@thom.fr.eu.org>
> ---
>  kernel/cobalt/posix/io.c          | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
>  
> diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
> index f35aaf8..85272a5 100644
> --- a/kernel/cobalt/posix/io.c
> +++ b/kernel/cobalt/posix/io.c
> @@ -79,18 +79,7 @@ COBALT_SYSCALL(write, handover,
>  COBALT_SYSCALL(recvmsg, handover,
>  	       (int fd, struct user_msghdr __user *umsg, int flags))
>  {
> -	struct user_msghdr m;
> -	ssize_t ret;
> -
> -	ret = cobalt_copy_from_user(&m, umsg, sizeof(m));
> -	if (ret)
> -		return ret;
> -
> -	ret = rtdm_fd_recvmsg(fd, &m, flags);
> -	if (ret < 0)
> -		return ret;
> -
> -	return cobalt_copy_to_user(umsg, &m, sizeof(*umsg)) ?: ret;
> +	return rtdm_fd_recvmsg(fd, umsg, flags);
>  }
>  
>  static int get_timespec(struct timespec *ts,
> @@ -123,12 +112,7 @@ COBALT_SYSCALL(recvmmsg, primary,
>  COBALT_SYSCALL(sendmsg, handover,
>  	       (int fd, struct user_msghdr __user *umsg, int flags))
>  {
> -	struct user_msghdr m;
> -	int ret;
> -
> -	ret = cobalt_copy_from_user(&m, umsg, sizeof(m));
> -
> -	return ret ?: rtdm_fd_sendmsg(fd, &m, flags);
> +	return rtdm_fd_sendmsg(fd, umsg, flags);
>  }
>  
>  static int put_mmsglen(void __user **u_mmsg_p, const struct mmsghdr *mmsg)
> 
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

