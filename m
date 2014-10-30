Date: Thu, 30 Oct 2014 10:16:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141030091631.GD11210@sisyphus.hd.free.fr>
References: <5451FFA4.5030805@ma-info.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5451FFA4.5030805@ma-info.de>
Subject: Re: [Xenomai] i-Pipi patch 3.14
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frede Florian <florian.frede@ma-info.de>
Cc: xenomai@xenomai.org

On Thu, Oct 30, 2014 at 10:06:44AM +0100, Frede Florian wrote:
> Hello,
> 
> I tried to patch the Kernel 3.14.22 and there is two new lines in
> the file fs/exec.c
> 
> tsk->mm->vmacache_seqnum = 0;
> vmacache_flush(tsk);
> 
> I am not sure if the line from the iPipe patch should placed before
> or after this lines...
> 
> +    ipipe_mm_switch_unprotect(flags);

We do not have enough information to understand what you
are talking about. Show us the conflict as obtained with git merge
or with patch --merge to give us more information.

-- 
					    Gilles.

