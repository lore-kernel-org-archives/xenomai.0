Subject: Re: [PATCH 1/3] lib/cobalt: Do not call glibc's {recv|send}mmsg if it
 is too old
References: <1540895354-16866-1-git-send-email-sebastian.smolorz@gmx.de>
 <1540895354-16866-2-git-send-email-sebastian.smolorz@gmx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <58c3bcfa-ee6e-377b-23b9-beec14c69a97@siemens.com>
Date: Wed, 31 Oct 2018 18:45:25 +0100
MIME-Version: 1.0
In-Reply-To: <1540895354-16866-2-git-send-email-sebastian.smolorz@gmx.de>
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
To: Sebastian Smolorz <sebastian.smolorz@gmx.de>, xenomai@xenomai.org

On 30.10.18 11:29, Sebastian Smolorz wrote:
> Fix linking error when using glibc versions which do not provide
> recvmmsg or sendmmsg.
> 
> Signed-off-by: Sebastian Smolorz <sebastian.smolorz@gmx.de>
> ---
>   lib/cobalt/wrappers.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/lib/cobalt/wrappers.c b/lib/cobalt/wrappers.c
> index 20ad63a..951cd15 100644
> --- a/lib/cobalt/wrappers.c
> +++ b/lib/cobalt/wrappers.c
> @@ -260,7 +260,11 @@ __weak
>   int __real_recvmmsg(int fd, struct mmsghdr *msgvec, unsigned int vlen,
>   		    unsigned int flags, struct timespec *timeout)
>   {
> +#if (__GLIBC__ == 2) && (__GLIBC_MINOR__ < 12)
> +	return -ENOSYS;
> +#else
>   	return recvmmsg(fd, msgvec, vlen, flags, timeout);
> +#endif
>   }
>   
>   __weak
> @@ -273,7 +277,11 @@ __weak
>   int __real_sendmmsg(int fd, struct mmsghdr *msgvec, unsigned int vlen,
>   		    unsigned int flags)
>   {
> +#if (__GLIBC__ == 2) && (__GLIBC_MINOR__ < 14)
> +	return -ENOSYS;
> +#else
>   	return sendmmsg(fd, msgvec, vlen, flags);
> +#endif
>   }
>   
>   __weak
> 

Shouldn't we rather probe for the availability of such functions during configure?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

