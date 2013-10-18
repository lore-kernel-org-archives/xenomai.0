Message-ID: <52612F95.1080204@xenomai.org>
Date: Fri, 18 Oct 2013 14:54:45 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <patchbomb.1382100607@devws164.be.alcatel-lucent.com>
	<feae5f95fd2d2de1b24f.1382100609@devws164.be.alcatel-lucent.com>
In-Reply-To: <feae5f95fd2d2de1b24f.1382100609@devws164.be.alcatel-lucent.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 2 of 2] Xenomai-forge notifier_init: panic on
 failed pipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kim De Mey <kim.demey@gmail.com>, xenomai@xenomai.org

On 10/18/2013 02:50 PM, Kim De Mey wrote:
> Panic if one of the pipe() system calls fails. To indicate that there
> is an underlying problem.
>
> Signed-off-by: Kim De Mey <kim.demey@gmail.com>
>
> ---
>
>   lib/copperplate/notifier.c |  4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/copperplate/notifier.c b/lib/copperplate/notifier.c
> --- a/lib/copperplate/notifier.c
> +++ b/lib/copperplate/notifier.c
> @@ -144,12 +144,12 @@ int notifier_init(struct notifier *nf,
>   	int fd;
>
>   	if (pipe(nf->psfd) < 0)
> -		return __bt(-errno);
> +		panic("failed to create file descriptors");
>
>   	if (pipe(nf->pwfd) < 0) {
>   		__STD(close(nf->psfd[0]));
>   		__STD(close(nf->psfd[1]));
> -		return __bt(-errno);
> +		panic("failed to create file descriptors");
>   	}
>
>   	nf->callback = callback;
>

Nack. This routine returns a status code, the caller should check it.

-- 
Philippe.

