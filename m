Message-ID: <50D024DD.3060509@xenomai.org>
Date: Tue, 18 Dec 2012 09:10:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50CB2610.6010905@gmail.com> <50CBA44C.5090402@xenomai.org>
	<50CC634B.3020307@xenomai.org> <50CDCF87.2010207@gmail.com>
	<50CDD690.8050802@xenomai.org> <50CE60FA.90502@gmail.com>
In-Reply-To: <50CE60FA.90502@gmail.com>
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

On 12/17/2012 01:02 AM, hauptmech wrote:

> On 12/16/2012 03:11 PM, Gilles Chanteperdrix wrote:
>> On 12/16/2012 02:41 PM, hauptmech wrote:
>>
>>> I'm coming to the documentation with relatively fresh eyes. If you give
>>> me a user on the wiki I'm happy to do a little gardening. Things like
>>> the [getting started] page which is useful but not linked to anymore.
>>> Perhaps a buffer page between the wiki and the git page with a little
>>> description of the repos and how they fit into the development workflow
>>> (where a link to denx could go).
>>
>> The "getting started" page is unfinished (contains empty paragraphs),
>> and outdated (contains dead links and references to things like the
>> simulator which is currently not really usable) at the same time. I do
>> not believe we have the resources to maintain such a page up-to-date.
> Do you mind if your list of documentation wants goes into the wiki (at 
> the taskmarket I guess)?
> 
>>
>>  From my point of view, what we need is:
>> - up to date manual pages of the binaries in xenomai distribution, in
>> the xenomai sources, we can start from the current manual pages, but
>> some of them are outdated and we should convert them to asciidoc so that
>> more people can work on them, and we can put the html versions on the
>> web site (with automatic update, as currently happens for the API
>> documentation and README.INSTALL/TROUBLESHOOTING)
> Do the asciidoc man page sources go in doc/asciidoc or doc/man?
> 
> I'm a bit shaky with automake/Makefile scripts, if someone can shim 
> Makefile.am with the code to call 'a2x -f manpage $SOURCEFILE' in the 
> right location then I don't mind converting them. An example...


I have just pushed the changes to do that. I integrated the clocktest
example. To add the new foo.man manual page, you have to:
- remove the corresponding references to foo.man in configure.in
- add a foo.adoc file in the doc/man directory
- add foo to the HTML_DOCS variable (to generate the html version of the
manual page) in doc/man/Makefile.am
- add foo.adoc to the EXTRA_DIST variable in doc/man/Makefile.am
- run scripts/bootstrap

Then you should be able to run make in the build directory.

-- 
                                                                Gilles.

