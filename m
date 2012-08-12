Message-ID: <502834AB.4000402@xenomai.org>
Date: Mon, 13 Aug 2012 00:56:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50260DCB.90401@xenomai.org> <502829B2.7000509@grinta.net>
In-Reply-To: <502829B2.7000509@grinta.net>
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
To: Daniele Nicolodi <daniele@grinta.net>
Cc: xenomai@xenomai.org

On 08/13/2012 12:09 AM, Daniele Nicolodi wrote:

> On 11/08/2012 09:46, Gilles Chanteperdrix wrote:
>> So, maybe we could use an asciidoc version.
> 
>> pros:
>> - nice online html version
>> - online one source file to maintain
>> cons:
>> - need to learn asciidoc syntax to maintain the doc
>> - a slightly less readable plain text version
> 
> For what it is worth, I find reStructuredText [1] much more readable in
> its "raw" format that asciidoc. reStructuredText is the nowadays
> standard for Python documentation.
> 
> [1] http://docutils.sourceforge.net/rst.html


And asciidoc is the standard for git documentation.

Since my aim is to generate html, I am comparing the html versions of
the user documentations of the two projects, each made with its own tool:
http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html
http://www.methods.co.nz/asciidoc/userguide.html

Maybe reStructuredText is good for python documentation, but apparently
not for generating good looking html (let alone the fact that the
document describing reStructuredText syntax is called "specification",
not "user guide"). From what I have tried, there is nothing special to
be done with asciidoc to have a nice output, the "out-of-the-box"
experience is very good.

And there is a docbook to asciidoc translator:
https://github.com/oreillymedia/docbook2asciidoc

Which may interest us as we also have some docbook code, which may be
interesting to convert to asciidoc.


-- 
                                                                Gilles.

