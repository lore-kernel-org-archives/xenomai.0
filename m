Date: Tue, 9 Dec 2014 13:43:35 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141209124335.GB26366@hermes.click-hack.org>
References: <54858FCC.7080600@control.lth.se>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54858FCC.7080600@control.lth.se>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai-3/next is out of sync with regards to
 automake/autoconf...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: Xenomai <xenomai@xenomai.org>

On Mon, Dec 08, 2014 at 12:47:24PM +0100, Anders Blomdell wrote:
> ...which leads to rtnet utils not being properly built. I think
> the following is needed:
> 
> autoconf
> automake
> git add configure utils/Makefile.in utils/net/Makefile.in
> git commit

Oops. My fault. I did not commit the changes, because I do not have
the same versions of the autotools as Philippe, so the commit would
have changed all files (and at the time, I even had to comment out
some code in configure.ac to get my autotools to work, but this
issue has been resolved since then). But I forgot to tell Philippe
to bootstrap.

Note that if you do not want to think about what commands you should
run, you should use autoreconf. autoreconf is the reason why the
"bootstrap" script was removed.

I wonder if as long as Xenomai 3 is in its development stage, it
would not make sense to remove the autotools file from the
repository and ask the users who want to use the repository to run
autoreconf before compiling. I do not know if it will seem
acceptable to those who work from the repository.

-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 173 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20141209/0181fcb9/attachment.sig>
