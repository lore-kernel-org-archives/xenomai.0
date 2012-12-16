Message-ID: <50CDD690.8050802@xenomai.org>
Date: Sun, 16 Dec 2012 15:11:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50CB2610.6010905@gmail.com> <50CBA44C.5090402@xenomai.org>
	<50CC634B.3020307@xenomai.org> <50CDCF87.2010207@gmail.com>
In-Reply-To: <50CDCF87.2010207@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] How does the adeos and xenomai project stay
 synchronized with the linux kernel project?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: hauptmech <hauptmech@gmail.com>
Cc: xenomai@xenomai.org

On 12/16/2012 02:41 PM, hauptmech wrote:

> 
> I'm coming to the documentation with relatively fresh eyes. If you give 
> me a user on the wiki I'm happy to do a little gardening. Things like 
> the [getting started] page which is useful but not linked to anymore. 
> Perhaps a buffer page between the wiki and the git page with a little 
> description of the repos and how they fit into the development workflow 
> (where a link to denx could go).


The "getting started" page is unfinished (contains empty paragraphs),
and outdated (contains dead links and references to things like the
simulator which is currently not really usable) at the same time. I do
not believe we have the resources to maintain such a page up-to-date.

>From my point of view, what we need is:
- up to date manual pages of the binaries in xenomai distribution, in
the xenomai sources, we can start from the current manual pages, but
some of them are outdated and we should convert them to asciidoc so that
more people can work on them, and we can put the html versions on the
web site (with automatic update, as currently happens for the API
documentation and README.INSTALL/TROUBLESHOOTING)
- some thematic pages on the wiki such as:
. calibrating your system with xeno-test
. influence of the various Linux kernel options on latencies on at least
the arm and x86 platforms
- and hyperlinks, for instance at the end of README.INSTALL point to the
"calibrating your system" page, and in this page, have an hyperlink to
the xeno-test and latency test manual pages, in the page "porting the
I-pipe-core patch to a new ARM board", mention the tools that can be
used to debug the various issues, and have an hyperlink to their manual
page.
- a user guide, the "porting posix applications to xenomai" page, was my
attempt of a user-guide, but it has a very specialized goal, whereas
part of the information it contains is general to anyone writing posix
applications for xenomai, and evern applications in general.
- something we have talked about but has long gone forgotten, have some
kind of database of the latency results sortable by a mix of measurement
type, load type, kernel versions, configuration options, processors or SOCs.

I agree with you, we have some information on the wiki, but it seems
hard to find, seeing how people are asking again and again the same
questions about configuring an x86 kernel, which are answered and
hyperlinked in at least three pages on the web site.

So, if you feel like organizing things a bit better, I created a wiki
account for you.

-- 
                                                                Gilles.

