Date: Tue, 23 May 2017 11:29:37 -0400
From: Jeff Melvile <jmelville@mitre.org>
In-Reply-To: <c67ebae3-251a-d265-62b5-2c3335ef27f0@xenomai.org>
Message-ID: <alpine.DEB.2.20.1705231109560.21096@af78237-pc.mitre.org>
References: <1a14fe35-fa00-c088-3838-b6e25ee5bff1@xenomai.org>
 <20170522111517.76526d57@md1em3qc>
 <c67ebae3-251a-d265-62b5-2c3335ef27f0@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
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



On Mon, 22 May 2017, Philippe Gerum wrote:

> On 05/22/2017 11:15 AM, Henning Schild wrote:
> > Am Sun, 21 May 2017 21:19:22 +0200
> > schrieb Philippe Gerum <rpm@xenomai.org>:
> > 
> >> Xenomai 3.0.5 is out. A few bug fixes, most notably in the Cobalt
> >> core, and several cleanups for better supporting different C
> >> libraries. This release also provides support for kernel series up to
> >> 4.9.x (included).
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
> this tracking is not followed. Actually the master branch should go away.
> 
> -- 
> Philippe.
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
> 

Philippe,

Can I ask a few clarifications about the release?

I noticed that there is an arm64 directory in the cobalt/arch directory of 
the tarball but it is empty. I assume this is a mistake and arm64 is not 
supported in 3.0.5. I see cobalt/arch/arm64 in the next branch.

You also mentioned that the release supports up to kernel series 4.9.x. 
There aren't any ipipe patches beyond 4.4.x in 
xenomai.org/downloads/ipipe. Is the ipipe-4.9.y branch generally stable 
for use with this release? Or was your statement meant to convey that 
3.0.5 will be compatible with an ipipe-4.9 patch when it is released?

Can you (or anyone else) provide a general update on arm64 status? I 
haven't seen anything for a few months. We're 
currently considering migrating from an arm, Xenomai 2.6.5 setup to an 
arm64, Xenomai 3 Cobalt configuration. We're happy to help with 
development to the extent we're able.

Thanks,
Jeff

