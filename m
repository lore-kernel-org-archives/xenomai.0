From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 11 Jul 2012 13:48:44 -0400
Message-ID: <20120711174844.GG19565@csclub.uwaterloo.ca>
References: <4FFC89CA.70809@xenomai.org> <4FFDA171.3010201@nta-inc.net>
	<4FFDAF59.9010000@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FFDAF59.9010000@xenomai.org>
Subject: Re: [Xenomai] Debian packaging bug in Xenomai v2.6.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Jul 11, 2012 at 06:52:41PM +0200, Gilles Chanteperdrix wrote:
> Well, maybe we should, from time to time, import the changes which are
> done by the debian maintainers. Or forget the debian directory
> altogether, as there is one correctly maintained by the debian
> maintainer. I do not really know what to think of this as I do not use
> the debian packaging. As a user of debian packaging, what do you think?

Perhaps it is a question of occationally testing that 'make install'
with DESTDIR set to some /tmp/ place that doesn't exist actually works.
Very easy to have a makefile assume /usr/share exists and forget to
create it before copying files to it.

-- 
Len Sorensen

