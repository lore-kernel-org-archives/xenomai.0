Date: Thu, 28 May 2015 15:23:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150528132358.GB27570@hermes.click-hack.org>
References: <d0dc8c289d0b45fafbb6b39b839b468bd53f256f.1430395105.git.henning.schild@siemens.com>
 <2640138.cV33tOjW7h@indiana>
 <20150527235131.GZ27570@hermes.click-hack.org>
 <2068804.pkeAgNJKLc@soho>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2068804.pkeAgNJKLc@soho>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] debian: remove xeno-config from
 libxenomai-dev package
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai@xenomai.org

On Thu, May 28, 2015 at 03:09:26PM +0200, Leopold Palomo-Avellaneda wrote:
> El Dijous, 28 de maig de 2015, a les 01:51:31, Gilles Chanteperdrix va 
> escriure:
> [...]
> 
> dropped all your complains to debian. I must read and answer more careful and 
> I don't know if the xenomai list is the proper audience.
>  
>  
> > > > Just to add something more to the subject: I do not think being the
> > > > debian maintainer of the Xenomai package is a hard task. I mean come
> > > > on, it is just basically a Makefile shorter than some other
> > > > Makefiles in the project. But this requires staying in touch with
> > > > the Debian project to know what the "good practices" are, what
> > > > practices have become deprecated and what new debian helper could
> > > > make the packaging even simpler, things I do not care to do. In any
> > > > case, this should be a good reason not to botch the task. A botched
> > > > hard task is easier to understand than a botched easy task.
> > > 
> > > Just to inform, because i have been in silence all this thread that some
> > > weeks ago (maybe two month) I contacted with the debian maintainer of
> > > xenomai. I offered my help because I was interested in maintain the
> > > package. We finally will work together, and the debian directory will be
> > > hosted in collab-maint git, in alioth, a git server of debian.
> > > 
> > > Said that, because time constraints of the last weeks, I'm just in the
> > > beginning of review all the packaging of xenomai. I will begin with 2.6.4
> > > and after that, I will jump to 3.0 when you released an official one. So,
> > > don't try to find anything there, because I have nothing done. I will try
> > > to inform the list about my progress.
> > > 
> > > Anyway, the idea is to drop your debian directory and put a new one,
> > > trying to use the "good practices" and the updated debhelper tools. I
> > > will try to keep the package in a good shape, sync with the upstream last
> > > versions, at least in unstable. If I could, some backport (because I used
> > > it) could be possible.
> > So, you want to reiterate the previous maintainer mistakes, and
> > continue to maintain the Xenomai Debian packaging outside of the
> > Xenomai project. See my last point for why this is a bad idea.
> 
> It's your opinion. I don't agree with you. Anyway, let me begin, try to find 
> some kind of confluence that fits debian requirements and upstream 
> requirements. Please, try to begin from zero, the past is in the past (Queen 
> Elsa dixit :-))

My opinion is backed by concrete evidence. You just have to look at
the current contents of the Debian project debian/rules for Xenomai
project that install hook for the kernel-package package that have
stopped working for something like 5 debian releases, that to do so
uses the "prepare-patch.sh" script which has been a pain to maintain
and has thus becomes useless for 5 debian releases, that passes
option to the configure script which have been removed for many
releases and cause configure to emit a warning. And at the accepted
patches sent by users (notably the one that "fixes" powerpc SPE) to
see that keeping it out of sight of the upstream project was a bad
idea. Really.

-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 811 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150528/85229005/attachment.sig>
