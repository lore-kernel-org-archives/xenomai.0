Message-ID: <50283788.8040802@grinta.net>
Date: Mon, 13 Aug 2012 01:08:56 +0200
From: Daniele Nicolodi <daniele@grinta.net>
MIME-Version: 1.0
References: <50260DCB.90401@xenomai.org> <502829B2.7000509@grinta.net>
	<502834AB.4000402@xenomai.org>
In-Reply-To: <502834AB.4000402@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Using asciidoc for README.INSTALL
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

On 13/08/2012 00:56, Gilles Chanteperdrix wrote:
> Since my aim is to generate html, I am comparing the html versions of
> the user documentations of the two projects, each made with its own tool:
> http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html
> http://www.methods.co.nz/asciidoc/userguide.html
> 
> Maybe reStructuredText is good for python documentation, but apparently
> not for generating good looking html (let alone the fact that the
> document describing reStructuredText syntax is called "specification",
> not "user guide").

I'm sure you know that how HTML looks like depends mostly on the applied
CSS rather than on the HTML code. The Python documentation
http://docs.python.org/ looks much better than the (oldish) docutils web
pages. The document is called "specification" because it is indeed the
specification. Other documents target the end user, the quickref for
example: http://docutils.sourceforge.net/docs/user/rst/quickref.html

However, this was not a criticism of the choice of using asciidoc, which
may be better suited to the use case. I just wonted to provide my
opinion on readability.

Cheers,
Daniele


