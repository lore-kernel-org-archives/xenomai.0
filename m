Message-ID: <5028416B.9020404@xenomai.org>
Date: Mon, 13 Aug 2012 01:51:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50260DCB.90401@xenomai.org> <502829B2.7000509@grinta.net>
	<502834AB.4000402@xenomai.org> <50283788.8040802@grinta.net>
In-Reply-To: <50283788.8040802@grinta.net>
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

On 08/13/2012 01:08 AM, Daniele Nicolodi wrote:

> On 13/08/2012 00:56, Gilles Chanteperdrix wrote:
>> Since my aim is to generate html, I am comparing the html versions of
>> the user documentations of the two projects, each made with its own tool:
>> http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html
>> http://www.methods.co.nz/asciidoc/userguide.html
>>
>> Maybe reStructuredText is good for python documentation, but apparently
>> not for generating good looking html (let alone the fact that the
>> document describing reStructuredText syntax is called "specification",
>> not "user guide").
> 
> I'm sure you know that how HTML looks like depends mostly on the applied
> CSS rather than on the HTML code.


Yes, that is what I meant by "out-of-the-box" experience. I already do
not have a lot of time to spend on documentation, but when I spend time
on documentation, I want to write documentation, not fight with markup
syntax and toolchain, and even less with CSS customization (which I am
unable to do anyway). asciidoc provides a good looking CSS, apparently,
reST does not.

 The Python documentation
> http://docs.python.org/ looks much better than the (oldish) docutils web
> pages. The document is called "specification" because it is indeed the
> specification. Other documents target the end user, the quickref for
> example: http://docutils.sourceforge.net/docs/user/rst/quickref.html


Yes, but the primer in its "What's Next" section says: "This primer
introduces the most common features of reStructuredText, but there are a
lot more to explore. The Quick reStructuredText user reference is a good
place to go next. For complete details, the reStructuredText Markup
Specification is the place to go". So, neither the primer nor the
quickref are complete documentations, and ultimately, the only complete
documentation is a specification, not a user guide.

So, on one side, we have one project with one clearly users-oriented
documentation, and on the other side, we have another project with three
documentations, two incomplete user documentations, and a complete
documentation, but which name seems to indicate that it is not user
oriented.

Maybe I react strangely, but I prefer the first solution.


> 
> However, this was not a criticism of the choice of using asciidoc, which
> may be better suited to the use case. I just wonted to provide my
> opinion on readability.


I did not take it as a criticism, and I had a look at ReST, but it does
not really look convincing. As for the readability, the syntax
comparison on wikipedia:
http://en.wikipedia.org/wiki/Lightweight_markup_language#Comparison_of_lightweight_markup_language_syntax

does not look to the advantage of ReST either.

*bold text*
_italic text_
Introduction
============
http://www.example.com[Link text]

vs

**bold text**
*italic text*
Section 1 Introduction
======================
`Link text <http://www.example.com/>`_
or
Linkname_
.. _Linkname: http://www.example.com

-- 
                                                                Gilles.

