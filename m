Date: Tue, 21 Apr 2015 17:27:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150421152715.GV7109@hermes.click-hack.org>
References: <E1Yka0Q-00008c-Jh@sd-51317.xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Yka0Q-00008c-Jh@sd-51317.xenomai.org>
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : lib/cobalt: Rework minimum
 stack size enforcement
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
> +COBALT_IMPL(int, pthread_attr_setstack, (pthread_attr_t *attr, void *stackaddr,
> +					 size_t stacksize))
> +{
> +	if (stacksize < COBALT_STACKSIZE_MIN)
> +		return -EINVAL;
> +	return __STD(pthread_attr_setstack)(attr, stackaddr, stacksize);
> +}

As I said, there is no reason for Xenomai to enforce a task size
larger than PTHREAD_STACK_MIN. This breaks POSIX compliance, and is
useless.

-- 
					    Gilles.

