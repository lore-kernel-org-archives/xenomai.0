Subject: Re: [PATCH] docs: Remove outdated note on biarch on x86
References: <20200302203659.9359-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d3111b15-d59b-b177-27e6-051e17f09f37@siemens.com>
Date: Mon, 2 Mar 2020 21:53:15 +0100
MIME-Version: 1.0
In-Reply-To: <20200302203659.9359-1-richard@nod.at>
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
To: Richard Weinberger <richard@nod.at>, xenomai@xenomai.org

On 02.03.20 21:36, Richard Weinberger via Xenomai wrote:
> Since fab9bf585638 ("cobalt: x86: Use ipipe_root_nr_syscalls") it is
> possible to run x86_32 Xenomai userspace on x86_64 kernels.
> 
> Reported-by: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>   doc/asciidoc/README.INSTALL.adoc | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/doc/asciidoc/README.INSTALL.adoc b/doc/asciidoc/README.INSTALL.adoc
> index cbd2adcd54ed..c83fda8ada70 100644
> --- a/doc/asciidoc/README.INSTALL.adoc
> +++ b/doc/asciidoc/README.INSTALL.adoc
> @@ -186,9 +186,7 @@ Building a _Cobalt/x86_ kernel (32/64bit)
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   
>   Building _Xenomai/cobalt_ for x86 is almost the same for 32bit and 64bit
> -platforms. You should note, however, that it is not possible to run
> -Xenomai libraries compiled for x86_32 on a kernel compiled for x86_64,
> -and conversely.
> +platforms.

Thanks, but maybe rather add a note that 32-bit on 64 is supported, 
provided that this is enabled in the kernel (CONFIG_IA32_EMULATION). I 
just recalled that we even support the dying x32 ABI, though I doubt 
anyone tested it recently.

Jan

>   
>   Assuming that you want to build natively for a x86_64 system (x86_32
>   cross-build options from x86_64 appear between brackets), you would
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

