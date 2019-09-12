Subject: Re: [PATCH] debian/rules: Add debug symbols
References: <20190911160519.25505-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <beb6d8bf-79e2-bc86-8818-2fd0cb5c93c3@siemens.com>
Date: Thu, 12 Sep 2019 07:51:24 +0200
MIME-Version: 1.0
In-Reply-To: <20190911160519.25505-1-Quirin.Gylstorff@siemens.com>
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
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>, xenomai@xenomai.org

On 11.09.19 18:05, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Configure debian build with debugging symbols to allow debugging.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   debian/rules | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/debian/rules b/debian/rules
> index 08562c7ab..ef209712f 100755
> --- a/debian/rules
> +++ b/debian/rules
> @@ -17,7 +17,8 @@ CONFIG_OPTS = --prefix=/usr \
>               --includedir=/usr/include/xenomai \
>               --mandir=/usr/share/man \
>               --with-testdir=/usr/lib/xenomai/testsuite \
> -            --enable-smp
> +            --enable-smp \
> +            --enable-debug
>   
>   ifneq ($(DEB_HOST_GNU_TYPE),$(DEB_BUILD_GNU_TYPE))
>   	CONFIG_OPTS += --build $(DEB_BUILD_GNU_TYPE) --host $(DEB_HOST_GNU_TYPE)
> 

Thanks, applied. Will also add this to stable.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

