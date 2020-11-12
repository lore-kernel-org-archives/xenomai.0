Subject: Re: [PATCH] lib/boilerplate: Allow building with GCC 10.2
References: <20201111145926.104952-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <159b4065-c996-8ee9-05da-c5095b314740@siemens.com>
Date: Thu, 12 Nov 2020 07:58:25 +0100
MIME-Version: 1.0
In-Reply-To: <20201111145926.104952-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Interesting corner of our code base...

On 11.11.20 15:59, florian.bezdeka--- via Xenomai wrote:
> When trying to compile using GCC 10.2 the following warning / error
> appeared:
> 
> iniparser/iniparser.c: In function ‘iniparser_load’:
> iniparser/iniparser.c:616:13: error: ‘sprintf’ arguments 3, 4 may overlap destination object ‘buf’ [-Werror=restrict]
>   616 |             sprintf(tmp, "%s:%s", section, key);
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 

Strange, cannot reproduce this report here with

gcc-10 (SUSE Linux) 10.2.1 20200825 [revision
c0746a1beb1ba073c7981eb09f55b3d993b32e5c]

even when explicitly adding -Wrestrict.

> According to POSIX and C99 standard using sprintf() on overlapping
> buffers may lead to undefined behavior, so using a dedicated buffer for
> the destination (first argument to sprintf) is necessary.
> 
> While at it:
>  - Fixed some indentations
>  - Fixed some error handling code paths
>    Some resources were not properly cleaned up in error conditions
>  - Fixed buffer initializations: The last bytes were never set to zero
> 

We likely first of all want a resync with
https://github.com/ndevilla/iniparser. If there is an upstream issue,
maybe fix there first.

> Fixes: 67803dce543e ("lib/boilerplate: add iniparser to boilerplate")
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  lib/boilerplate/iniparser/iniparser.c | 39 ++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/lib/boilerplate/iniparser/iniparser.c b/lib/boilerplate/iniparser/iniparser.c
> index 5b2094a00..b79f965a6 100644
> --- a/lib/boilerplate/iniparser/iniparser.c
> +++ b/lib/boilerplate/iniparser/iniparser.c
> @@ -551,25 +551,37 @@ dictionary * iniparser_load(const char * ininame)
>      dict = dictionary_new(0) ;
>      if (!dict) {
>          fclose(in);
> -	errno = ENOMEM;
> +        errno = ENOMEM;
>          return NULL ;
>      }
>  
> -    buf = malloc((ASCIILINESZ+1) * 5);
> +    buf = malloc((ASCIILINESZ+1) * 4);
>      if (buf == NULL) {
> -	    errno = -ENOMEM;
> -	    return NULL;
> +            dictionary_del(dict);
> +            fclose(in);
> +            errno = ENOMEM;
> +            return NULL;
>      }
> +
> +    tmp = malloc(ASCIILINESZ + 1);
> +    if (!tmp) {
> +            free(buf);
> +            dictionary_del(dict);
> +            fclose(in);
> +            errno = ENOMEM;
> +            return NULL;
> +    }
> +

This split-up is just silencing the compiler, right? It does no take
away the possibility that we overrun the target buffer in sprintf
(section+key > ASCIILINESZ). Upstream seems to have addressed that.

But it also does not use snprintf yet. Likely with the argument that
buffer sizes are under full control.

>      line = buf;
>      section = line + ASCIILINESZ + 1;
>      key = section + ASCIILINESZ + 1;
> -    tmp = key + ASCIILINESZ + 1;
> -    val = tmp + ASCIILINESZ + 1;
> +    val = key + ASCIILINESZ + 1;
>  
> -    memset(line,    0, ASCIILINESZ);
> -    memset(section, 0, ASCIILINESZ);
> -    memset(key,     0, ASCIILINESZ);
> -    memset(val,     0, ASCIILINESZ);
> +    memset(line,    0, ASCIILINESZ + 1);
> +    memset(section, 0, ASCIILINESZ + 1);
> +    memset(key,     0, ASCIILINESZ + 1);
> +    memset(val,     0, ASCIILINESZ + 1);
> +    memset(tmp,     0, ASCIILINESZ + 1);
>      last=0 ;
>  
>      while (fgets(line+last, ASCIILINESZ-last, in)!=NULL) {
> @@ -585,8 +597,9 @@ dictionary * iniparser_load(const char * ininame)
>  #endif
>              dictionary_del(dict);
>              fclose(in);
> -	    free(buf);
> -	    errno = EINVAL;
> +            free(buf);
> +            free(tmp);
> +            errno = EINVAL;
>              return NULL ;
>          }
>          /* Get rid of \n and spaces at end of line */
> @@ -613,6 +626,7 @@ dictionary * iniparser_load(const char * ininame)
>              break ;
>  
>              case LINE_VALUE:
> +            /* Already checked for overflows, see above */
>              sprintf(tmp, "%s:%s", section, key);
>              errs = dictionary_set(dict, tmp, val) ;
>              break ;
> @@ -642,6 +656,7 @@ dictionary * iniparser_load(const char * ininame)
>      }
>      fclose(in);
>      free(buf);
> +    free(tmp);
>      if (errs) {
>          dictionary_del(dict);
>          dict = NULL ;
> 

Jan
-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


