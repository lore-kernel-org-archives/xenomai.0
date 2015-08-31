Date: Mon, 31 Aug 2015 09:08:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150831070849.GD9120@hermes.click-hack.org>
References: <20150831063738.GC9120@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150831063738.GC9120@hermes.click-hack.org>
Subject: Re: [Xenomai] Mirroring xenomai.org
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

On Mon, Aug 31, 2015 at 08:37:38AM +0200, Gilles Chanteperdrix wrote:
> Hi,
> 
> according to xenomai.org server statistics, some xenomai users are
> mirroring xenomai.org git repositories. In order to make things
> easy, grokmirror is now set up on xenomai.org.

Unfortunately, this broke http/https checkout for ipipe* gits. The
reason is that the "alternate" file in the ipipe gits contains the
absolute path to the kernel.org repositories, which does not work
for http/https checkouts. I will need to spend more time fixing
this. In the mean time, I revert the ipipe* gits to their former
contents, without references.

-- 
					    Gilles.
https://click-hack.org

