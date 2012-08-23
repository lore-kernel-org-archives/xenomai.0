From: Markus Valtin <valtin@control.tu-berlin.de>
Date: Thu, 23 Aug 2012 17:22:11 +0200
Message-ID: <2001851.iuaMCWmikV@valtin-rt>
In-Reply-To: <5035490A.60902@xenomai.org>
References: <2211797.6MhXv49D68@valtin-rt> <5035228B.1050905@xenomai.org>
	<5035490A.60902@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Xenomai] Scicos/Xcos Code Generation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

Am Mittwoch, 22. August 2012, 23:03:06 schrieb Philippe Gerum:
> On 08/22/2012 08:18 PM, Gilles Chanteperdrix wrote:
> > On 08/22/2012 06:28 PM, Markus Valtin wrote:

> > You may want to reintegrate an RTAI skin to Xenomai, but in that case,
> > please find someone to maintain it.
> 
> The RTAI skin was removed not only because nobody wanted to maintain it,
> which was by itself a showstopper, but first and foremost because it was
> lacking user-space support and nobody in sight having any interest in
> developing such support, compared to rebasing the code over the native
> Xenomai API, or moving to POSIX. So this basically meant that we had no
> upgrade path to the Xenomai 3 architecture for it.
> 
> So, I would complete the sentence this way: bottom line for considering
> any reintegration into Xenomai, would be to find someone to develop from
> scratch and maintain on the __long term__ a sane implementation of a
> LXRT-looking API.

I was not looking for a way to get the RTAI skin back.
I just want to use the tools we have with Xenomia, as easy as possible.

So this is more a post for "user" part of the mailing list.


Sincerely 
 Markus

