Subject: Re: xenomai-doc.deb is not built for the next branch
References: <06dad7fa-7579-9565-97d3-68cb8c33e7a9@rambler.ru>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <66958f4a-8f10-b727-77f3-bc3ae9772d44@siemens.com>
Date: Fri, 23 Nov 2018 18:48:49 +0100
MIME-Version: 1.0
In-Reply-To: <06dad7fa-7579-9565-97d3-68cb8c33e7a9@rambler.ru>
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
To: leo <feedcom@rambler.ru>, Xenomai@xenomai.org

On 22.11.18 18:57, leo via Xenomai wrote:
> All good health.
> 
> I am trying to build all xenomai packages for Ubuntu-18.04
> from the next branch for arm64 architecture.
> https://gitlab.denx.de/Xenomai/xenomai/tree/next
> 
> Configuration settings in ./ debian/rules led to:
> CONFIG_OPTS = --prefix=/usr \
>              --includedir=/usr/include/xenomai \
>              --mandir=/usr/share/man \
>              --with-testdir=/usr/lib/xenomai/testsuite \
>              --enable-smp \
>          --enable-doc-build
> 
> While on HEAD, commit 04d874ce, all packages are not built.
> Error related to the absence of html/asciidoc-icons directory
> and its contents.
> 
> In Ubuntu /usr/share/asciidoc/images/icons this is a link to ../icons
> so the command from the file doc/asciidoc/Makefile.am
> 
> cp -a /usr/share/asciidoc/images/icons html/asciidoc-icons || \
> cp -a /usr/share/asciidoc/icons html/asciidoc-icons
> 
> simply copies a symbolic link to the directory and
> completes without error.
> As a result, we have a broken link in the target directory.
> 
> For example in OpenSUSE /usr/share/asciidoc/images/icons
> this is the directory and no error occurs.
> 
> Patch 001-fix-copi-icons.patch fixes this issue.
> 
> After applying the patch, the compilation passes without errors,
> the documentation in the $(DESTDIR) folder is present
> but the xenomai-doc.deb package is missing.

Please send patches inlined, not attached, and also check CONTRIBUTING.md for 
the format.

I'm not seeing all details yet, but I agree that we need a clean installation 
pattern: first create dirs as needed (BTW, "install-d" does not need that 
additional test), then install (not cp) the files.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

