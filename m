Subject: Re: [PATCH] libs: Add linking dependencies to libcopperplate and
 libsmokey
References: <20200914215233.10877-1-vt@altlinux.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e005d8e1-3e59-5c67-ba2f-74c648fd7dd4@siemens.com>
Date: Tue, 15 Sep 2020 12:38:55 +0200
MIME-Version: 1.0
In-Reply-To: <20200914215233.10877-1-vt@altlinux.org>
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
To: Vitaly Chikunov <vt@altlinux.org>, Xenomai <xenomai@xenomai.org>

On 14.09.20 23:52, Vitaly Chikunov wrote:
> ALT rpmbuild QA script detects that libsmokey and libcopperplate is improperly
> linked (when built for Mercury core).
> 
> Excerpt from the error message:
>    verify-elf: ERROR: ./usr/lib64/libsmokey.so.0.0.0: undefined symbol: get_mem_size
>    verify-elf: ERROR: ./usr/lib64/libcopperplate.so.0.0.0: undefined symbol: get_mem_size
> 

Could such a test be added to our regular build, or is it depending on 
rpm or altlinux?

> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>   lib/copperplate/Makefile.am | 3 ++-
>   lib/smokey/Makefile.am      | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/copperplate/Makefile.am b/lib/copperplate/Makefile.am
> index f832d1c89..c7104eb02 100644
> --- a/lib/copperplate/Makefile.am
> +++ b/lib/copperplate/Makefile.am
> @@ -2,7 +2,8 @@
>   lib_LTLIBRARIES = libcopperplate.la
>   
>   libcopperplate_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -lpthread -lrt -version-info 0:0:0
> -libcopperplate_la_LIBADD =
> +libcopperplate_la_LIBADD = @XENO_CORE_LDADD@
> +
>   noinst_LTLIBRARIES =
>   
>   libcopperplate_la_SOURCES =	\
> diff --git a/lib/smokey/Makefile.am b/lib/smokey/Makefile.am
> index 53c775c68..4ecae1f16 100644
> --- a/lib/smokey/Makefile.am
> +++ b/lib/smokey/Makefile.am
> @@ -1,6 +1,7 @@
>   lib_LTLIBRARIES = libsmokey.la
>   
>   libsmokey_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 0:0:0
> +libsmokey_la_LIBADD = @XENO_CORE_LDADD@
>   
>   libsmokey_la_SOURCES =	\
>   	helpers.c	\
> 

Thanks, applied to next.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

