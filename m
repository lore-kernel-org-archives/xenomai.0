Message-ID: <533C38FF.5050703@steinkuehler.net>
Date: Wed, 02 Apr 2014 11:21:19 -0500
From: Charles Steinkuehler <charles@steinkuehler.net>
MIME-Version: 1.0
References: <533C32E3.3090309@steinkuehler.net> <533C3622.1030601@xenomai.org>
In-Reply-To: <533C3622.1030601@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Debian Package Building Broken
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 4/2/2014 11:09 AM, Gilles Chanteperdrix wrote:
>>
> Does this still happen if you remove the line "autoreconf -fi" from
> debian/rules ?

Yes, see below (pasted as a quote to hopefully avoid wrapping).  The
build complains about uncommitted changes immediately after deleting the
configure file, which is what causes the uncommitted change.

I have some other problem as well, even if I remove the configure file
the build still dies, but I think that's something on my end.  It's
unrelated to the configure file, anyway.

> linuxcnc@mah2:~/xenomai$ git-buildpackage --git-debian-branch=v2.6.3-deb --git-export-dir=.. -uc -us
> dh_testdir
> dh_testroot
> rm -f configure-stamp build-indep-stamp build-arch-stamp
> if test -f Makefile ; then \
>             /usr/bin/make distclean ; \
>         fi
> dh_clean
> rm -fR /home/linuxcnc/xenomai/tmp
> rm -f /home/linuxcnc/xenomai/*.patch
> rm -f configure
> gbp:error: You have uncommitted changes in your source tree:
> gbp:error: # On branch v2.6.3-deb
> # Changes not staged for commit:
> #   (use "git add/rm <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #
> #       deleted:    configure
> #
> no changes added to commit (use "git add" and/or "git commit -a")
> 
> gbp:error: Use --git-ignore-new to ignore.

-- 
Charles Steinkuehler
charles@steinkuehler.net

