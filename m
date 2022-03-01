Message-ID: <ce5b129d-0e20-160c-a8d6-acb4b96515e4@siemens.com>
Date: Tue, 1 Mar 2022 08:30:59 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] build: Add c++ build support
Content-Language: en-US
References: <20220228054055.16112-1-hongzhan.chen@intel.com>
 <20220228054055.16112-2-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220228054055.16112-2-hongzhan.chen@intel.com>
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
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 28.02.22 06:40, Hongzhan Chen wrote:
> Add c++ build support or use specific c++ compiler
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> ---
>  configure.ac | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index 0389cf008..16cffd8f8 100644
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

Will that make a C++ compiler mandatory for the build? Or only when
pulling in KernelShark support?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

