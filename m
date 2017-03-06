References: <aa57407e-6064-eebf-6d9f-be2ba864d633@xenomai.org>
 <20170306140049.23493-1-henning.schild@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <9eefa102-ada8-9395-4962-998714f822b4@xenomai.org>
Date: Mon, 6 Mar 2017 17:18:23 +0100
MIME-Version: 1.0
In-Reply-To: <20170306140049.23493-1-henning.schild@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 1/2] cobalt: fix for incorrect assert wrappers
	commit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, xenomai@xenomai.org

On 03/06/2017 03:00 PM, Henning Schild wrote:

> -XENO_AUTOINIT_LDFLAGS='$(top_builddir)/lib/boilerplate/init/bootstrap-internal.o'" -Wl,--wrap=main -Wl,--dynamic-list=$topdir/scripts/dynlist.ld"
> +XENO_AUTOINIT_LDFLAGS='$(top_builddir)/lib/boilerplate/init/bootstrap-internal.o'" -Wl,--wrap=main -Wl,--dynamic-list=$topdir/scripts/dynlist.ld $XENO_ASSERT_WRAPPERS"
>  AC_SUBST(XENO_AUTOINIT_LDFLAGS)
>  

XENO_AUTOINIT_LDFLAGS is only used internally, inside the Xenomai tree
for building utilities and test programs which may want the
auto-bootstrap feature on. Is this the intent?

-- 
Philippe.

