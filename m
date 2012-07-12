Message-ID: <4FFE1841.1070409@xenomai.org>
Date: Thu, 12 Jul 2012 02:20:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4FFC89CA.70809@xenomai.org> <4FFDA171.3010201@nta-inc.net>
	<4FFDAF59.9010000@xenomai.org>
	<20120711174844.GG19565@csclub.uwaterloo.ca>
In-Reply-To: <20120711174844.GG19565@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Debian packaging bug in Xenomai v2.6.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On 07/11/2012 07:48 PM, Lennart Sorensen wrote:
> On Wed, Jul 11, 2012 at 06:52:41PM +0200, Gilles Chanteperdrix wrote:
>> Well, maybe we should, from time to time, import the changes which are
>> done by the debian maintainers. Or forget the debian directory
>> altogether, as there is one correctly maintained by the debian
>> maintainer. I do not really know what to think of this as I do not use
>> the debian packaging. As a user of debian packaging, what do you think?
> 
> Perhaps it is a question of occationally testing that 'make install'
> with DESTDIR set to some /tmp/ place that doesn't exist actually works.
> Very easy to have a makefile assume /usr/share exists and forget to
> create it before copying files to it.

We run "make distcheck" as part of what is done when releasing xenomai,
so, the sort of error you mention should not exist. In particular, since
we use the autotools, these things are being taken care of automatically.

The problem is that we use to have files in the /usr/share/xenomai
directory, the debian files were written with this assumption, we now no
longer install any file in /usr/share/xenomai, and we did not change the
debian files, simply because nobody tested the debian package
generation, or more accurately someone did but forgot to report the bug.

-- 
                                                                Gilles.

