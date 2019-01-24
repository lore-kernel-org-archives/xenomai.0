Subject: Re: [PATCH 4/9] cobalt/ancillaries: prevent false positive with
 -Wstringop-truncation
References: <20181026140825.5251-1-rpm@xenomai.org>
 <20181026140825.5251-4-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0d3ff214-e0a2-9ddd-70b3-cc0b3071b4ed@siemens.com>
Date: Thu, 24 Jan 2019 19:35:31 +0100
MIME-Version: 1.0
In-Reply-To: <20181026140825.5251-4-rpm@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 26.10.18 16:08, Philippe Gerum wrote:
> knamecpy() is meant to copying NUL terminated strings even if this
> incurs potential truncation of the source argument if need be, prevent
> GCC 8.x from detecting a false positive when -Wstringop-truncation is
> in effect.
> ---
>   include/cobalt/kernel/ancillaries.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/cobalt/kernel/ancillaries.h b/include/cobalt/kernel/ancillaries.h
> index cde9856da..b957310c7 100644
> --- a/include/cobalt/kernel/ancillaries.h
> +++ b/include/cobalt/kernel/ancillaries.h
> @@ -58,7 +58,7 @@ void __knamecpy_requires_character_array_as_destination(void);
>   	({								\
>   		if (!__builtin_types_compatible_p(typeof(__dst), char[])) \
>   			__knamecpy_requires_character_array_as_destination();	\
> -		strncpy((__dst), __src, sizeof(__dst) - 1);		\
> +		strncpy((__dst), __src, sizeof(__dst));			\
>   		__dst[sizeof(__dst) - 1] = '\0';			\
>   		__dst;							\
>   	 })
> 

Belatedly picking patch 1-4 of this series into stable to address compilation 
issues against gcc 8.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

