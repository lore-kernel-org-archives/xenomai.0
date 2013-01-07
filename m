Message-ID: <50EB537E.6000605@xenomai.org>
Date: Tue, 08 Jan 2013 00:00:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50CD8E87.2070906@xenomai.org> <50CDAD2C.8050209@antcom.de>
In-Reply-To: <50CDAD2C.8050209@antcom.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] next xenomai release
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roland Stigge <stigge@antcom.de>
Cc: Xenomai@xenomai.org

On 12/16/2012 12:14 PM, Roland Stigge wrote:

> Thank you for the note! This really simplified my update in Debian.
> 
> I just tested a snapshot from git.xenomai.org (using xenomai-head.git
> and building a test tarball with ./configure && make dist) - looks good
> so far.


Hi Roland,

it turned out that a little more work was needed to check whether the
release was ready for generating debian packages, as, you may have
follow, the 2.6.2 release was completely broken in this regard.

> There is also

> 
> http://www.xenomai.org/index.php/Building_Debian_packages


The information on this page is outdated, as support for dkms was
removed from the xenomai package, so, the "apply" script does not exist.

Thanks for the pointers.

Regards.

-- 
                                                                Gilles.

