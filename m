Date: Fri, 11 Dec 2015 15:09:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151211140927.GB24775@hermes.click-hack.org>
References: <2004286.fnOG18ZY9A@soho>
 <20151211132012.GA24775@hermes.click-hack.org>
 <5073889.mxMKChqctc@soho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5073889.mxMKChqctc@soho>
Subject: Re: [Xenomai] Porting a library to Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: Xenomai list <xenomai@xenomai.org>

On Fri, Dec 11, 2015 at 03:03:55PM +0100, Leopold Palomo-Avellaneda wrote:
> El Divendres, 11 de desembre de 2015, a les 14:20:12, Gilles Chanteperdrix va 
> escriure:
> > On Fri, Dec 11, 2015 at 01:44:01PM +0100, Leopold Palomo-Avellaneda wrote:
> > > Hi,
> > > 
> > > I'm working to make a library to work with Xenomai. It's a library that
> > > has a thread and open a socket to communicate with an external device via
> > > network.
> > > 
> > > I have read the guide "Porting a Linux application to Xenomai dual kernel
> > > [1]" but still I have some doubts in some details. So, here my topics
> > > without any importance order:
> > > 
> > > - What is the recommended way to obtain the link, flags, etc information
> > > to
> > > build an application that use Xenomai? xeno-config, pkg-config, some build
> > > macros to find the information, ...
> > 
> > Quoting the document you say you have read:
> 
> :-)
> 
> > "Compilation flags
> > 
> > To ease that task, the xeno-config script, installed when compiling
> > Xenomai user-space support, is able to give you these flags. (...)
> > Beware: this way of obtaining the compilation flags is recommended,
> > if for anything because it will make using a different release of
> > Xenomai easier: the flags may change between two different releases."
> 
> ok, but this solution implies that xeno-config must be available. In any case 
> as CMake user, following your indications the Macros should use xeno-config. 
> For what I have seen in the net, not all the people use that.

We can not force people to use the recommended solution. This is
implied in the word "recommended".

> 
> > > - I would like to have a code that could be used with an Standard POSIX or
> > > a Xenomai. I thought that protecting my code with some #ifdef __XENO__ I
> > > could choose which part is specific to Xenomai and which no. However, I'm
> > > a bit confused, because then, I don't understand what is the utility of
> > > the wrap script. Please, could you elaborate a bit more this part,
> > > especially focused in an application the could use an standard network
> > > interface or rtnet version.
> > 
> > Quoting the documentation again: "Use of Linux original services
> > 
> 
> [....]
> 
> 
> No Gilles, that's the point that I don't understand. Maybe it could be a 
> language problem. 

If you do not understand the text. Read the example.

> > 
> > > - In the document, there's a section about the mlockall option. So, may I
> > > understand that from xenomai <= 2.6.3 it's not needed that I call the
> > > mlockall function?
> > 
> > Quoting the documentation again: "
> > Starting with version 2.6.3, as part of their initialization,
> > Xenomai libraries systematically call mlockall to commit and lock
> > the whole application memory.
> 
> Ok, so why it's use it in your example:
> 
> http://www.xenomai.org/documentation/xenomai-2.6/html/api/trivial-periodic_8c-example.html
> 
> May I understand that that line is not needed?

It is not needed indeed.

-- 
					    Gilles.
https://click-hack.org

