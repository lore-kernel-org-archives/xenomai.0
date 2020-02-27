Subject: Re: [PATCH] libs: Add linking dependencies to libraries
References: <4d132aef-75ce-3b7a-21b7-d8f8afde1967@siemens.com>
 <20200225153054.5c7830da@md1za8fc.ad001.siemens.net>
 <ff952c07-e291-46c6-82bb-9aade7479fe1@siemens.com>
 <a7e13035-2f7b-2f2e-a0b7-05f6986109d9@siemens.com>
 <20200225163747.27c2c234@md1za8fc.ad001.siemens.net>
 <CAPnNZ0X5SdnN+FD8W23-+E-CXCzwqi+cJicErg_eFOaXeX47AQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <02c9d776-a86f-8587-7506-a56b20de55d3@siemens.com>
Date: Thu, 27 Feb 2020 08:26:33 +0100
MIME-Version: 1.0
In-Reply-To: <CAPnNZ0X5SdnN+FD8W23-+E-CXCzwqi+cJicErg_eFOaXeX47AQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
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
To: Antoine Hoarau <antoine@flr.io>, Henning Schild <henning.schild@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 26.02.20 22:35, Antoine Hoarau wrote:
> Same error when reverting the patch !
> : symbol lookup error: /usr/lib/libalchemy.so.0: undefined symbol: 
> __real_free
>   /usr/lib/xenomai/testsuite/smokey: test dlopen failed: Unknown error -127
> child 8610 returned: exited with status 1

Please revert the patch only AFTER you applied the fix shared in this 
thread. Don't forget to reran also scripts/bootstrap before rebuilding 
the Xenomai userland.

Thanks,
Jan

> 
> Le mar. 25 févr. 2020 à 16:37, Henning Schild 
> <henning.schild@siemens.com <mailto:henning.schild@siemens.com>> a écrit :
> 
>     On Tue, 25 Feb 2020 15:33:45 +0100
>     Jan Kiszka <jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>>
>     wrote:
> 
>      > [adding the list]
>      >
>      > On 25.02.20 15:32, Jan Kiszka wrote:
>      > > On 25.02.20 15:30, Henning Schild wrote:
>      > >> I guess that is related to lds --(no-)as-needed which is different
>      > >> in the ubuntu toolchain. Back when i looked into it Ubuntu managed
>      > >> to patch the default behaviour but forgot to patch the
>     man-pages ;)
>      > >>
>      > >> See
>      > >>
>     https://gitlab.denx.de/Xenomai/xenomai/commit/83dea2ad712ee2d2137942c7ab9891da7d4ef841
> 
>      > >>
>      > >>
>      > >> Maybe this can actually be reverted after the proposed fix.
>      > >
>      > > If someone can validate that, I'm happy to do so...
> 
>     That is why i pulled in Antoine again. He has a ubuntu setup and can
>     probably check whether applying your fix works, and reverting the other
>     one still works.
> 
>     Henning
> 
>      > > Jan
>      > >
>      > >>
>      > >> Henning
>      > >>
>      > >> On Wed, 19 Feb 2020 13:31:29 +0100
>      > >> Jan Kiszka via Xenomai <xenomai@xenomai.org
>     <mailto:xenomai@xenomai.org>> wrote:
>      > >>
>      > >>> From: Jan Kiszka <jan.kiszka@siemens.com
>     <mailto:jan.kiszka@siemens.com>>
>      > >>>
>      > >>> This ensures that no optimization will drop dependencies of our
>      > >>> shared objects, preventing to load them via dlopen without
>      > >>> explicitly loading those dropped dependencies first. See also
>      > >>> https://xenomai.org/pipermail/xenomai/2020-February/042449.html
>      > >>>
>      > >>> As trank now explicitly depends on alchemy, reorder the build to
>      > >>> ensure that the latter is available before the former is built
>      > >>> (analogy is only moved for consistency reasons).
>      > >>>
>      > >>> Reported-by: Antoine Hoarau <antoine@flr.io
>     <mailto:antoine@flr.io>>
>      > >>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com
>     <mailto:jan.kiszka@siemens.com>>
>      > >>> ---
>      > >>>   lib/Makefile.am         | 11 +++++++----
>      > >>>   lib/alchemy/Makefile.am |  4 ++++
>      > >>>   lib/analogy/Makefile.am |  2 ++
>      > >>>   lib/psos/Makefile.am    |  4 ++++
>      > >>>   lib/trank/Makefile.am   |  4 ++++
>      > >>>   lib/vxworks/Makefile.am |  4 ++++
>      > >>>   6 files changed, 25 insertions(+), 4 deletions(-)
>      > >>>
>      > >>> diff --git a/lib/Makefile.am b/lib/Makefile.am
>      > >>> index c927a9bd85..e909030564 100644
>      > >>> --- a/lib/Makefile.am
>      > >>> +++ b/lib/Makefile.am
>      > >>> @@ -1,10 +1,7 @@
>      > >>>   SUBDIRS = boilerplate
>      > >>>   if XENO_COBALT
>      > >>> -SUBDIRS +=    \
>      > >>> -    cobalt    \
>      > >>> -    analogy    \
>      > >>> -    trank
>      > >>> +SUBDIRS += cobalt
>      > >>>   else
>      > >>>   SUBDIRS += mercury
>      > >>>   endif
>      > >>> @@ -16,6 +13,12 @@ SUBDIRS +=        \
>      > >>>       vxworks        \
>      > >>>       psos
>      > >>> +if XENO_COBALT
>      > >>> +SUBDIRS +=         \
>      > >>> +    analogy        \
>      > >>> +    trank
>      > >>> +endif
>      > >>> +
>      > >>>   DIST_SUBDIRS =         \
>      > >>>       alchemy        \
>      > >>>       analogy        \
>      > >>> diff --git a/lib/alchemy/Makefile.am b/lib/alchemy/Makefile.am
>      > >>> index 5362695ed2..f97bd69bf8 100644
>      > >>> --- a/lib/alchemy/Makefile.am
>      > >>> +++ b/lib/alchemy/Makefile.am
>      > >>> @@ -2,6 +2,10 @@ lib_LTLIBRARIES = libalchemy.la
>     <http://libalchemy.la>
>      > >>>   libalchemy_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 0:0:0
>      > >>> +libalchemy_la_LIBADD =
>      > >>>     \
>      > >>> +    @XENO_CORE_LDADD@                    \
>      > >>> +    $(top_builddir)/lib/copperplate/libcopperplate.la
>     <http://libcopperplate.la>
>      > >>> +
>      > >>>   libalchemy_la_SOURCES =    \
>      > >>>       init.c        \
>      > >>>       internal.c    \
>      > >>> diff --git a/lib/analogy/Makefile.am b/lib/analogy/Makefile.am
>      > >>> index e53d8a11ab..4c6f0de013 100644
>      > >>> --- a/lib/analogy/Makefile.am
>      > >>> +++ b/lib/analogy/Makefile.am
>      > >>> @@ -2,6 +2,8 @@ lib_LTLIBRARIES = libanalogy.la
>     <http://libanalogy.la>
>      > >>>   libanalogy_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 1:0:0
>      > >>> -lm +libanalogy_la_LIBADD = @XENO_CORE_LDADD@
>      > >>> +
>      > >>>   libanalogy_la_SOURCES =    \
>      > >>>       async.c        \
>      > >>>       descriptor.c    \
>      > >>> diff --git a/lib/psos/Makefile.am b/lib/psos/Makefile.am
>      > >>> index 4eb7ad84ce..6fe50881cc 100644
>      > >>> --- a/lib/psos/Makefile.am
>      > >>> +++ b/lib/psos/Makefile.am
>      > >>> @@ -2,6 +2,10 @@ lib_LTLIBRARIES = libpsos.la <http://libpsos.la>
>      > >>>   libpsos_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 0:0:0
>      > >>> +libpsos_la_LIBADD =                        \
>      > >>> +    @XENO_CORE_LDADD@                    \
>      > >>> +    $(top_builddir)/lib/copperplate/libcopperplate.la
>     <http://libcopperplate.la>
>      > >>> +
>      > >>>   libpsos_la_SOURCES =    \
>      > >>>       init.c        \
>      > >>>       internal.h    \
>      > >>> diff --git a/lib/trank/Makefile.am b/lib/trank/Makefile.am
>      > >>> index 816a1a4047..ee353c6f20 100644
>      > >>> --- a/lib/trank/Makefile.am
>      > >>> +++ b/lib/trank/Makefile.am
>      > >>> @@ -3,6 +3,10 @@ lib_LTLIBRARIES = libtrank.la
>     <http://libtrank.la>
>      > >>>   libtrank_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 0:0:0
>      > >>> +libtrank_la_LIBADD =                        \
>      > >>> +    @XENO_CORE_LDADD@                    \
>      > >>> +    $(top_builddir)/lib/alchemy/libalchemy.la
>     <http://libalchemy.la>
>      > >>> +
>      > >>>   libtrank_la_SOURCES =    \
>      > >>>       init.c        \
>      > >>>       internal.c    \
>      > >>> diff --git a/lib/vxworks/Makefile.am b/lib/vxworks/Makefile.am
>      > >>> index a123864079..4217a994b0 100644
>      > >>> --- a/lib/vxworks/Makefile.am
>      > >>> +++ b/lib/vxworks/Makefile.am
>      > >>> @@ -2,6 +2,10 @@ lib_LTLIBRARIES = libvxworks.la
>     <http://libvxworks.la>
>      > >>>   libvxworks_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 0:0:0
>      > >>> +libvxworks_la_LIBADD =
>      > >>>     \
>      > >>> +    @XENO_CORE_LDADD@                    \
>      > >>> +    $(top_builddir)/lib/copperplate/libcopperplate.la
>     <http://libcopperplate.la>
>      > >>> +
>      > >>>   libvxworks_la_SOURCES = \
>      > >>>       init.c        \
>      > >>>       errnoLib.c    \
>      > >>
>      > >
>      >
> 


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

