Date: Mon, 29 May 2017 10:37:46 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170529103746.55f26d1d@md1em3qc>
In-Reply-To: <c67ebae3-251a-d265-62b5-2c3335ef27f0@xenomai.org>
References: <1a14fe35-fa00-c088-3838-b6e25ee5bff1@xenomai.org>
 <20170522111517.76526d57@md1em3qc>
 <c67ebae3-251a-d265-62b5-2c3335ef27f0@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 3.0.5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Am Mon, 22 May 2017 11:18:01 +0200
schrieb Philippe Gerum <rpm@xenomai.org>:

> On 05/22/2017 11:15 AM, Henning Schild wrote:
> > Am Sun, 21 May 2017 21:19:22 +0200
> > schrieb Philippe Gerum <rpm@xenomai.org>:
> >   
> >> Xenomai 3.0.5 is out. A few bug fixes, most notably in the Cobalt
> >> core, and several cleanups for better supporting different C
> >> libraries. This release also provides support for kernel series up
> >> to 4.9.x (included).
> >>
> >> http://xenomai.org/downloads/xenomai/stable/latest/xenomai-3.0.5.tar.bz2
> >>  
> > 
> > This is currently just a tag on no upstream branch. Please update
> > stable-3.0.x and probably master as well.
> >   
> 
> Master is not aimed at reflecting the latest stable, if any, it should
> reflect the tip of the development which is the -next branch; however
> this tracking is not followed. Actually the master branch should go
> away.

Ok, still the tag is detached from all branches and one would have to
pull with "--tags" to get it.

Henning


