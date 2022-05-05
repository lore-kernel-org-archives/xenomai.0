Message-ID: <63e4b7c7-bc03-6ca1-f4e1-ac8b77d8826b@siemens.com>
Date: Thu, 5 May 2022 15:03:28 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] utils/net/rtnet.in: fixes after shellcheck inspection
Content-Language: en-US
References: <4e8c2890-bab4-ea31-4db3-0866b389db3e@tin.it>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <4e8c2890-bab4-ea31-4db3-0866b389db3e@tin.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Mauro S." <mau.salvi@tin.it>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03.05.22 10:22, Mauro S. via Xenomai wrote:
> Signed-off-by: Mauro Salvini <mau.salvi@tin.it>
> ---
>  utils/net/rtnet.in | 76 +++++++++++++++++++++++-----------------------
>  1 file changed, 38 insertions(+), 38 deletions(-)
> 
> diff --git a/utils/net/rtnet.in b/utils/net/rtnet.in
> index f81a7bb0a..06e796cd2 100644
> --- a/utils/net/rtnet.in
> +++ b/utils/net/rtnet.in
> @@ -9,7 +9,7 @@ RTNETCFG="@sysconfdir@/rtnet.conf"
> 
>  debug_func() {
>      echo "$*"
> -    eval $*
> +    eval "$*"

That may not work for all inputs as it breaks up formerly quoted
arguments and separates them by $IFS. You rather want "$@" to preserve
their structure.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

