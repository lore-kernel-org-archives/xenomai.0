Subject: Re: [PATCH] debian/rules: dh_strip exclude smokey
References: <20190813165628.31705-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2212a048-3324-3340-da07-c601b489458c@siemens.com>
Date: Wed, 14 Aug 2019 13:22:07 +0200
MIME-Version: 1.0
In-Reply-To: <20190813165628.31705-1-Quirin.Gylstorff@siemens.com>
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

On 13.08.19 18:56, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> To execute the smokey testsuite it is necessary to hold debug dbg
> symbols to test gdb. Debian normally strips all debug symbols from
> all build results. Exclude all components containing smokey from
> stripping.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   debian/rules | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/debian/rules b/debian/rules
> index 883ae3ed8..3d5729c22 100755
> --- a/debian/rules
> +++ b/debian/rules
> @@ -102,7 +102,7 @@ binary-arch: build install
>   	dh_installdocs -s -A README
>   	dh_link -s
>   	dh_installchangelogs -s
> -	dh_strip -s
> +	dh_strip -s --exclude=smokey
>   	dh_compress -s
>   	dh_fixperms -s
>   	dh_makeshlibs -s
> 

Applied to next.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

