Subject: Re: [PATCH] debian: Enable dlopen-libs in userspace package
References: <20200121183401.24327-1-henning.schild@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <dd88330f-5b06-d4ac-b625-52b812149a24@siemens.com>
Date: Wed, 22 Jan 2020 18:21:55 +0100
MIME-Version: 1.0
In-Reply-To: <20200121183401.24327-1-henning.schild@siemens.com>
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
To: Henning Schild <henning.schild@siemens.com>, xenomai@xenomai.org

On 21.01.20 19:34, Henning Schild via Xenomai wrote:
> From: Henning Schild <henning.schild@siemens.com>
> 
> This feature might not be widely used but those debian packages are
> supposed to be generic. Having it default on brings more benefits than
> drawbacks for generic packages.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>   debian/rules | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/debian/rules b/debian/rules
> index 68e7a4e37..22c90586d 100755
> --- a/debian/rules
> +++ b/debian/rules
> @@ -19,7 +19,8 @@ CONFIG_OPTS = --prefix=/usr \
>               --with-testdir=/usr/lib/xenomai/testsuite \
>               --enable-smp \
>               --enable-lazy-setsched \
> -            --enable-debug=symbols
> +            --enable-debug=symbols \
> +            --enable-dlopen-libs
>   
>   ifneq ($(DEB_HOST_GNU_TYPE),$(DEB_BUILD_GNU_TYPE))
>   	CONFIG_OPTS += --build $(DEB_BUILD_GNU_TYPE) --host $(DEB_HOST_GNU_TYPE)
> 

Thanks, applied.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

