References: <99BAB48E90E86D42AD41F0BCE3225AEB019FC0F9C2@GRZSMS582.andritz.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7e4b1371-384f-8858-b5e2-c37fd9580bda@siemens.com>
Date: Mon, 23 Apr 2018 15:21:11 +0200
MIME-Version: 1.0
In-Reply-To: <99BAB48E90E86D42AD41F0BCE3225AEB019FC0F9C2@GRZSMS582.andritz.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] add missing headers and casts,
	prefer POSIX definitions
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 2018-04-23 11:02, Lange Norbert wrote:
> Fix a few missing headers and casts
> 
> see http://man7.org/linux/man-pages/man2/bind.2.html
> and http://man7.org/linux/man-pages/man2/open.2.html
> and http://man7.org/linux/man-pages/man7/sigevent.7.html
> 
> Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
> ---
> demo/posix/cobalt/gpiopwm.c                  | 4 ++--
> testsuite/smokey/posix-select/posix-select.c | 3 +++
> 2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/demo/posix/cobalt/gpiopwm.c b/demo/posix/cobalt/gpiopwm.c
> index b34cbf1e1..eddd5cce5 100644
> --- a/demo/posix/cobalt/gpiopwm.c
> +++ b/demo/posix/cobalt/gpiopwm.c
> @@ -219,7 +219,7 @@ static void *gpiopwm_udp_ctrl_thread(void *cookie)
>            saddr.sin_port = htons(port);
>            saddr.sin_family = AF_INET;
> -           if (bind(sockfd, &saddr, sizeof(saddr)) < 0)
> +          if (bind(sockfd, (struct sockaddr *)&saddr, sizeof(saddr)) < 0)
>                        perror("bind");
>             clen = sizeof(caddr);
> @@ -230,7 +230,7 @@ static void *gpiopwm_udp_ctrl_thread(void *cookie)
>                        print_config("UDP Server\n");
>                         memset(buf,'\0', blen);
> -                       ret = recvfrom(sockfd, buf, blen - 1, 0, &caddr, &clen);
> +                      ret = recvfrom(sockfd, buf, blen - 1, 0, (struct sockaddr *)&caddr, &clen);
>                        if (ret < 0)
>                                    perror("recvfrom");
> diff --git a/testsuite/smokey/posix-select/posix-select.c b/testsuite/smokey/posix-select/posix-select.c
> index 6bd88ddb5..e9bf938b3 100644
> --- a/testsuite/smokey/posix-select/posix-select.c
> +++ b/testsuite/smokey/posix-select/posix-select.c
> @@ -30,6 +30,9 @@
> #include <pthread.h>
> #include <boilerplate/atomic.h>
> #include <sys/select.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> #include <smokey/smokey.h>
>  smokey_test_plugin(posix_select,
> --
> 2.17.0

Patch looks whitespace-demaged. Mailclient settings? Or try git send-email.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

