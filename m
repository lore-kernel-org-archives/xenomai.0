Message-ID: <533C3B2B.1050605@steinkuehler.net>
Date: Wed, 02 Apr 2014 11:30:35 -0500
From: Charles Steinkuehler <charles@steinkuehler.net>
MIME-Version: 1.0
References: <533C32E3.3090309@steinkuehler.net> <533C3622.1030601@xenomai.org>
 <533C38FF.5050703@steinkuehler.net> <533C395C.5060604@xenomai.org>
In-Reply-To: <533C395C.5060604@xenomai.org>
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

On 4/2/2014 11:22 AM, Gilles Chanteperdrix wrote:
> On 04/02/2014 06:21 PM, Charles Steinkuehler wrote:
>>
>>> linuxcnc@mah2:~/xenomai$ git-buildpackage
>>> --git-debian-branch=v2.6.3-deb --git-export-dir=.. -uc -us
>>> dh_testdir
>>> dh_testroot
>>> rm -f configure-stamp build-indep-stamp build-arch-stamp
>>> if test -f Makefile ; then \
>>>              /usr/bin/make distclean ; \
>>>          fi
>>> dh_clean
>>> rm -fR /home/linuxcnc/xenomai/tmp
>>> rm -f /home/linuxcnc/xenomai/*.patch
>>> rm -f configure
> 
> Ok, that is the "clean" target, so we should remove the rm configure
> from the clean target.

Yes, commenting "-rm -f configure" in the clean target gets it past this
particular problem.

-- 
Charles Steinkuehler
charles@steinkuehler.net

