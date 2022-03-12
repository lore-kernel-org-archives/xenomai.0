Message-ID: <65881e30-4a61-9591-66fd-2a02aa72d41d@siemens.com>
Date: Sat, 12 Mar 2022 13:58:51 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] build: Add c++ build support
Content-Language: en-US
References: <20220310081513.12314-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220310081513.12314-1-hongzhan.chen@intel.com>
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
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org, florian.bezdeka@siemens.com

On 10.03.22 09:15, Hongzhan Chen wrote:
> Add c++ build support or use specific c++ compiler
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> 
> diff --git a/configure.ac b/configure.ac
> index e7a170161..afe08b8f2 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -79,6 +79,18 @@ AC_ARG_WITH(cc,
>      ])
>  AC_PROG_CC
>  
> +AC_ARG_WITH(cxx,
> +    AS_HELP_STRING([--with-cxx=compiler],[use specific C++ compiler]),
> +    [
> +	case "$withval" in
> +	"" | y | ye | yes | n | no)
> +	    AC_MSG_ERROR([You must supply an argument to --with-cxx])
> +	  ;;
> +	esac
> +	CXX="$withval"
> +    ])
> +AC_PROG_CXX
> +
>  # Do not let autoconf set the default value of CFLAGS
>  if $XENO_EMPTY_CFLAGS; then
>  	CFLAGS=""

Thanks, this one applied as-is. Will send the others as v7 because I
modified the build system.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

