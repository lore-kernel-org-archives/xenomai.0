Subject: Re: [PATCH 3/8] build: fix make distcheck
References: <20200131152713.1811748-1-rpm@xenomai.org>
 <20200131152713.1811748-4-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <622280d2-8777-c97b-f609-49b861677e84@siemens.com>
Date: Fri, 31 Jan 2020 16:40:04 +0100
MIME-Version: 1.0
In-Reply-To: <20200131152713.1811748-4-rpm@xenomai.org>
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

On 31.01.20 16:27, Philippe Gerum via Xenomai wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> Uninstall udev rules.
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>   Makefile.am | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile.am b/Makefile.am
> index ec1d0a07e..891e53f66 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -29,7 +29,7 @@ dist-hook:
>   	rm -fr `find $(distdir) -name '.svn' -o -name CVS  -o -name '.#*' \
>   		-o -name '*~' -o -name autom4te.cache`
>   
> -udev-rules:
> +install-udev-rules:
>   if XENO_COBALT
>   	if test -r $(DESTDIR)/$(sysconfdir)/udev/udev.rules ; then \
>   	    for f in $(srcdir)/kernel/cobalt/udev/*.rules ; do \
> @@ -45,10 +45,19 @@ if XENO_COBALT
>   	fi
>   endif
>   
> +uninstall-udev-rules:
> +if XENO_COBALT
> +	cd $(srcdir)/kernel/cobalt/udev && for f in *.rules; do \
> +	    rm -f $(DESTDIR)/$(sysconfdir)/udev/rules.d/$$f ; \
> +	done
> +endif
> +
>   # legacy alias
>   install-user: install
>   
> -install-exec-local: udev-rules
> +install-exec-local: install-udev-rules
> +
> +uninstall-local: uninstall-udev-rules
>   
>   uninstall-local:
>   if XENO_COBALT
> 

This overlaps with 1a84919771c6.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

