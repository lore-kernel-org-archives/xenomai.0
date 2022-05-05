Message-ID: <0731ccb1-8246-3b19-129b-d4b6bee54fc9@siemens.com>
Date: Thu, 5 May 2022 14:57:20 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] doc: Fix coreclk typo
Content-Language: en-US
References: <20220429191406.838-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220429191406.838-1-richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>, xenomai@xenomai.org

On 29.04.22 21:14, Richard Weinberger via Xenomai wrote:
> It's coreclk not coreclck.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  doc/asciidoc/MIGRATION.adoc     | 6 +++---
>  doc/asciidoc/man1/autotune.adoc | 8 ++++----
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/doc/asciidoc/MIGRATION.adoc b/doc/asciidoc/MIGRATION.adoc
> index dce7f40e9cbe..7a32b992183d 100644
> --- a/doc/asciidoc/MIGRATION.adoc
> +++ b/doc/asciidoc/MIGRATION.adoc
> @@ -226,11 +226,11 @@ of the Xenomai core clock:
>      
>  ------------------------------------------------------
>      /* change the user gravity (default) */
> -# echo 3000 > /proc/xenomai/clock/coreclck
> +# echo 3000 > /proc/xenomai/clock/coreclk
>      /* change the IRQ gravity */
> -# echo 1000i > /proc/xenomai/clock/coreclck
> +# echo 1000i > /proc/xenomai/clock/coreclk
>      /* change the user and kernel gravities */
> -# echo "2000u 1000k" > /proc/xenomai/clock/coreclck
> +# echo "2000u 1000k" > /proc/xenomai/clock/coreclk
>  ------------------------------------------------------
>  
>  +interfaces+ removed::
> diff --git a/doc/asciidoc/man1/autotune.adoc b/doc/asciidoc/man1/autotune.adoc
> index 3462e6b3fb91..2f9866c4d52a 100644
> --- a/doc/asciidoc/man1/autotune.adoc
> +++ b/doc/asciidoc/man1/autotune.adoc
> @@ -125,17 +125,17 @@ estimation. Although this delay may vary across hardware platforms,
>  running for 30 seconds is common.
>  
>  Once the gravity values are known for a particular hardware, one may
> -write them to +/proc/xenomai/clock/coreclck+ from some system init
> +write them to +/proc/xenomai/clock/coreclk+ from some system init
>  script to set up the Xenomai core clock accordingly, instead of
>  running the auto-tuner after each boot e.g:
>      
>  ------------------------------------------------------
>      /* change the user gravity to 1728 ns (default) */
> -# echo 1728 > /proc/xenomai/clock/coreclck
> +# echo 1728 > /proc/xenomai/clock/coreclk
>      /* change the IRQ gravity to 129 ns */
> -# echo 129i > /proc/xenomai/clock/coreclck
> +# echo 129i > /proc/xenomai/clock/coreclk
>      /* change the user and kernel gravities to 1728 and 907 ns resp. */
> -# echo "1728u 907k" > /proc/xenomai/clock/coreclck
> +# echo "1728u 907k" > /proc/xenomai/clock/coreclk
>  ------------------------------------------------------
>  
>  Alternatively, the gravity values can be statically defined in the

thanks, applied

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

