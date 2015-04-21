Date: Tue, 21 Apr 2015 17:30:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150421153042.GW7109@hermes.click-hack.org>
References: <E1Yka0Q-00008T-J2@sd-51317.xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Yka0Q-00008T-J2@sd-51317.xenomai.org>
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : lib/cobalt: Introduce and
 use COBALT_STACKSIZE_DEFAULT/MIN
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: xenomai-git@xenomai.org

On Tue, Apr 21, 2015 at 05:22:34PM +0200, git repository hosting wrote:
> +#define COBALT_STACKSIZE_MIN		(PTHREAD_STACK_MIN * 2)
> +#define COBALT_STACKSIZE_DEFAULT	(PTHREAD_STACK_MIN * 4)

This looks like a bad idea to me, I preferred __WORDSIZE * 1024.
Some architectures (I think ppc64 or ia64 had that) have
sufficiently large values of PTHREAD_STACK_MIN, so there is no
reason to set a larger default in that case. On the other hand, if
PTHREAD_STACK_MIN causes printf to fail with a stack overflow, we
want a larger default stack size, because the average user will not
expect printf to cause a stack overflow.

-- 
					    Gilles.

