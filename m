Subject: Re: [PATCH v3] utils: add kernel config check utility
References: <20211020080656.739-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8143c260-1611-d68a-ae08-705c6a927576@siemens.com>
Date: Thu, 21 Oct 2021 18:37:16 +0200
MIME-Version: 1.0
In-Reply-To: <20211020080656.739-1-hongzhan.chen@intel.com>
Content-Type: text/plain; charset=utf-8
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
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 20.10.21 10:06, Hongzhan Chen wrote:
> diff --git a/utils/chkkconf/Makefile.am b/utils/chkkconf/Makefile.am
> new file mode 100644
> index 000000000..3befee7f1
> --- /dev/null
> +++ b/utils/chkkconf/Makefile.am
> @@ -0,0 +1,20 @@
> +
> +data_DATA = kconf-checklist
> +
> +CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
> +
> +sbin_PROGRAMS = chkkconf
> +
> +chkkconf_SOURCES = checkconfig.c
> +
> +chkkconf_CPPFLAGS = 		\
> +	$(XENO_USER_CFLAGS)	\
> +	-I$(top_srcdir)/include \

Both not needed, see below.

> +	-DTESTDIR=\"$(datadir)\" -D_GNU_SOURCE

Renaming this to "DATADIR", to be consistent.

> +
> +chkkconf_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@ $(XENO_POSIX_WRAPPERS)
> +

Unneeded - no Xenomai program. And dropping that actually obsoletes
application_usage(), get_program_name etc. Sorry, didn't realized before.

> +chkkconf_LDADD =					\
> +	 @XENO_CORE_LDADD@			\
> +	 @XENO_USER_LDADD@			\
> +	-lpthread -lrt

Not needed anymore.

I've applied the patch with those changes (and related ones in the
source code). Please double check.

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

