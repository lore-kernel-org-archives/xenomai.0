Date: Fri, 1 Jul 2016 16:44:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160701144424.GQ18662@hermes.click-hack.org>
References: <3137778ca215b6db6061de83fa64dcae@smile.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3137778ca215b6db6061de83fa64dcae@smile.fr>
Subject: Re: [Xenomai] RTnet - List corruption when creating packet socket
 two consecutive times
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Geoffrey BONNEVILLE <geoffrey.bonneville@smile.fr>
Cc: xenomai@xenomai.org

On Fri, Jul 01, 2016 at 04:31:58PM +0200, Geoffrey BONNEVILLE wrote:
>  
> 
> Hi, 
> 
> Tested with Xenomai 3.0.2 (Cobalt) on a 4.1 kernel. Both on a
> 32-bits ARM and a 32 bits x86 platform. 

I guess the important question is: what driver do you use? Maybe the
fact that the driver uses DMA makes a difference. 

-- 
					    Gilles.
https://click-hack.org

