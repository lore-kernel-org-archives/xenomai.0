From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17471.38482.617361.14216@domain.hid>
Date: Fri, 14 Apr 2006 14:32:18 +0200
Subject: Re: [Xenomai-help] Problems running testsuite
In-Reply-To: <200604141342.40129.tmarscha@domain.hid>
References: <200604131149.40706.tmarscha@domain.hid>
	<443E9FD2.6070807@domain.hid>
	<200604141342.40129.tmarscha@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tobias Marschall <tmarscha@domain.hid>
Cc: xenomai@xenomai.org

Tobias Marschall wrote:
 > Hello,
 > 
 > On Thursday 13 April 2006 21:00, you wrote:
 > > I saw a similar error when using --enable-x86-sep and not having NPTL
 > > enabled in glibc.
 > > Try configuring without --enable-x86-sep (used in the README.INSTALL
 > > Pentium x86 example, the default is disabled).
 > that did the trick, thank you for the hint! I did check that the cpu supported 
 > the sep instruction, but I wasn't aware that NPTL is required in this case.
 > 
 > Mentioning this in README.INSTALL would be helpful. I wonder if that mistake 
 > could be caught by configure. 

It could be caught by configure, at least if not cross-compiling, by
running getconf GNU_LIBPTHREAD_VERSION.

-- 


					    Gilles Chanteperdrix.

