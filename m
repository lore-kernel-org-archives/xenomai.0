From: Markus Valtin <valtin@control.tu-berlin.de>
Date: Thu, 23 Aug 2012 17:14:59 +0200
Message-ID: <7437244.DT43npnmL9@valtin-rt>
In-Reply-To: <50352C12.2020307@xenomai.org>
References: <2211797.6MhXv49D68@valtin-rt> <5035228B.1050905@xenomai.org>
	<50352C12.2020307@xenomai.org>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Am Mittwoch, 22. August 2012, 20:59:30 schrieb Gilles Chanteperdrix:
> On 08/22/2012 08:18 PM, Gilles Chanteperdrix wrote:

Thank you for your answer.
> > Googling a bit shows that other projects are using scicos with Xenomai:
> > http://www.scilab-linux.com/
We like to use an open source solution, but I will have a look at it.

> > http://rtss.sourceforge.net
They the Xenomai Code Generator from Evidentce from my first post.

I was hoping for some feedback from users of this solution and maybe even some 
comments from users/developers about recent developments (Port to Xenomia 
2.6.1 / Scilab 5 support ...)

> > You may want to reintegrate an RTAI skin to Xenomai, but in that case,
> > please find someone to maintain it.
I was more looking for an easy transition path towards Xenomia / Preempt  
Linux.

> > It makes probably more sense to simply change the tools to generate
> > xenomai native skin calls instead of RTAI calls.
> > 
> > Also if the tools are able to generate code for Linux, chances are that
> > it is even possible to use the generated code to run with Xenomai posix
> > skin.
> 
> And if the code runs in kernel-space, it should use the RTDM skin.

This is the intention.

Like I said, I am looking for people how use Scilab and Xenomia together to 
get there opinion on where to start.

Sincerely 
 Markus

