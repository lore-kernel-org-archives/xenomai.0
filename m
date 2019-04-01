Subject: Re: [PATCH 2/5] libcobalt: improve documentation regarding mutex
 initializers
References: <20190307132159.31206-1-norbert.lange@andritz.com>
 <20190307132159.31206-2-norbert.lange@andritz.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <0a7b453d-1c18-1386-5374-8f9562db9ccc@web.de>
Date: Mon, 1 Apr 2019 19:20:08 +0200
MIME-Version: 1.0
In-Reply-To: <20190307132159.31206-2-norbert.lange@andritz.com>
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
>   lib/cobalt/mutex.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/lib/cobalt/mutex.c b/lib/cobalt/mutex.c
> index be9f6ed80..125981d40 100644
> --- a/lib/cobalt/mutex.c
> +++ b/lib/cobalt/mutex.c
> @@ -49,8 +49,12 @@
>    * By default, Cobalt mutexes are of the normal type, use no
>    * priority protocol and may not be shared between several processes.
>    *
> - * Note that only pthread_mutex_init() may be used to initialize a mute=
x, using
> - * the static initializer @a PTHREAD_MUTEX_INITIALIZER is not supported=
.
> + * Note that pthread_mutex_init() should be used to initialize a mutex,=
 using
> + * the static initializer @a PTHREAD_MUTEX_INITIALIZER will delay the
> + * initialization to the first method called on the mutex and will
> + * most likely introduce switches to secondary mode.
> + * The documentation (and specififcally api-tags) of the mutex services=
 assumes

specifically

> + * a mutex was explicitely initialised with pthread_mutex_init().

explicitly

>    *
>    *@{
>    */
>

Jan

