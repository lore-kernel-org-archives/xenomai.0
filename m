Date: Fri, 17 Oct 2014 20:23:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141017182309.GL30661@sisyphus.hd.free.fr>
References: <793728679.16223225.1413557251226.JavaMail.zimbra@eleves.ec-nantes.fr>
 <173837943.16227992.1413557978674.JavaMail.zimbra@eleves.ec-nantes.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173837943.16227992.1413557978674.JavaMail.zimbra@eleves.ec-nantes.fr>
Subject: Re: [Xenomai] Regarding the patch for Raspberry pi linux 3.14.y
 Kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Harsha Sathyanarayana <harsha.sathyanarayana@eleves.ec-nantes.fr>
Cc: xenomai@xenomai.org

On Fri, Oct 17, 2014 at 04:59:38PM +0200, Harsha Sathyanarayana wrote:
> Hello Guys I wanted to compile the linux raspberry pi 3.14.y
> kernel with xenomai, I would like to know which one is the right
> appropriate patch, 

Support for Raspberry is not integrated in the mainline Adeos I-pipe
patch, because the I-pipe patch only exists for mainline kernel. It
exists as a supplementary patch for some versions of Raspberry
specific kernels you will find out by reading
ksrc/arch/arm/patches/README in xenomai sources.

> Since Raspberry pi is quite common, it it
> possible to release it along with the Raspberry PI release

I do not really understand what you mean by that. But if there exist
a Raspberry Pi SDK release, it is certainly not maintained by the
Xenomai project, so I do not see what talking about what this
release should contain makes on the Xenomai mailing list. And if you
mean that we should wait for such release to release Xenomai, then
the answer is no, we are not going to do that, we support several
SOC, from several architecture, and we are not going to synchronize
with every SOC-specific distribution du jour for every SOC.

But if you want to be able to download the latest version of
Xenomai, apply it on the latest ARM kernel supported by this
version, and have it working with the Raspberry Pi, then you should
work to get enough of the Raspberry Pi support merged into the
mainline kernel for it to be usable in your project, then submit
patches to the Xenomai mailing list to add support for Raspberry Pi
to the mainline I-pipe patch. Once a SOC is supported by the
mainline I-pipe patch, it is ported to next versions. As long as it
only exists as a separate patch for a SOC-specific fork, we depend
on others to generate and test new versions of that patch.

-- 
					    Gilles.

