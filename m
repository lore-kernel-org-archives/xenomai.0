References: <1539773778-4283-1-git-send-email-sebastian.smolorz@gmx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5db67cb1-18b8-4b08-4e9e-cbeacbe65b6a@siemens.com>
Date: Wed, 17 Oct 2018 13:20:39 +0200
MIME-Version: 1.0
In-Reply-To: <1539773778-4283-1-git-send-email-sebastian.smolorz@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v3] rtdm: expose user-side file descriptors to
 drivers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sebastian Smolorz <sebastian.smolorz@gmx.de>, xenomai@xenomai.org

On 17.10.18 12:56, Sebastian Smolorz wrote:
> RTDM drivers refer to open files or sockets by using struct rtdm_fd.
> Normally, the user-side file descriptors returned by socket() or open()
> calls are not necessary for driver operations. However, in some special
> cases the user-side fd has to be determined, for example as return
> value of rt_tcp_accept() which is a driver function of RTnet's TCP
> protocol driver.
> 
> Signed-off-by: Sebastian Smolorz <sebastian.smolorz@gmx.de>
> ---
>   include/cobalt/kernel/rtdm/fd.h | 6 ++++++
>   kernel/cobalt/rtdm/fd.c         | 1 +
>   2 files changed, 7 insertions(+)
> 
> diff --git a/include/cobalt/kernel/rtdm/fd.h b/include/cobalt/kernel/rtdm/fd.h
> index 58d3c4a..572b17e 100644
> --- a/include/cobalt/kernel/rtdm/fd.h
> +++ b/include/cobalt/kernel/rtdm/fd.h
> @@ -298,6 +298,7 @@ struct rtdm_fd {
>   	struct rtdm_fd_ops *ops;
>   	struct cobalt_ppd *owner;
>   	unsigned int refs;
> +	int ufd;
>   	int minor;
>   	int oflags;
>   #ifdef CONFIG_XENO_ARCH_SYS3264
> @@ -320,6 +321,11 @@ static inline struct cobalt_ppd *rtdm_fd_owner(const struct rtdm_fd *fd)
>   	return fd->owner;
>   }
>   
> +static inline int rtdm_fd_ufd(const struct rtdm_fd *fd)
> +{
> +	return fd->ufd;
> +}
> +
>   static inline int rtdm_fd_minor(const struct rtdm_fd *fd)
>   {
>   	return fd->minor;
> diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
> index 8d577b2..807a11e 100644
> --- a/kernel/cobalt/rtdm/fd.c
> +++ b/kernel/cobalt/rtdm/fd.c
> @@ -166,6 +166,7 @@ int rtdm_fd_enter(struct rtdm_fd *fd, int ufd, unsigned int magic,
>   	fd->magic = magic;
>   	fd->ops = ops;
>   	fd->owner = ppd;
> +	fd->ufd = ufd;
>   	fd->refs = 1;
>   	set_compat_bit(fd);
>   
> 

Applied to next.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

