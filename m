Subject: Re: [PATCH 4/5] libcobalt: improve documentation regarding condvar
 initializers
References: <20190307132159.31206-1-norbert.lange@andritz.com>
 <20190307132159.31206-4-norbert.lange@andritz.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <1ab84963-4da9-61cf-7c92-4af945d2833a@web.de>
Date: Mon, 1 Apr 2019 19:27:55 +0200
MIME-Version: 1.0
In-Reply-To: <20190307132159.31206-4-norbert.lange@andritz.com>
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
To: Norbert Lange <nolange79@gmail.com>, xenomai@xenomai.org

On 07.03.19 14:21, Norbert Lange via Xenomai wrote:
> Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
> ---
>   lib/cobalt/cond.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/lib/cobalt/cond.c b/lib/cobalt/cond.c
> index 92eb230ff..cdbd512ae 100644
> --- a/lib/cobalt/cond.c
> +++ b/lib/cobalt/cond.c
> @@ -47,9 +47,13 @@
>    * several processes (it may not be shared by default, see
>    * pthread_condattr_setpshared()).
>    *
> - * Note that only pthread_cond_init() may be used to initialize a condi=
tion
> - * variable, using the static initializer @a PTHREAD_COND_INITIALIZER i=
s
> - * not supported.
> + * Note that pthread_cond_init() should be used to initialize a conditi=
on
> + * variable, using the static initializer @a PTHREAD_COND_INITIALIZER w=
ill
> + * delay the initialization to the first method called on the condition
> + * variable and will most likely introduce switches to secondary mode.
> + * The documentation (and specififcally api-tags) of the
> + * condition variable services assumes the condition variable was expli=
citely
> + * initialised with pthread_cond_init().

All typos of patch 2 were consistently reproduced.

Jan

>    *
>    *@{
>    */
>


