From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 2 Oct 2014 10:41:19 -0400
Message-ID: <20141002144119.GN4435@csclub.uwaterloo.ca>
References: <DUB121-W77031E5D3C1CE7CEB386981B90@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DUB121-W77031E5D3C1CE7CEB386981B90@phx.gbl>
Subject: Re: [Xenomai] Xenomai on Cortex R (or Rreal Time) family
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: mobin Motallebizadeh <mobin.seven@live.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Oct 02, 2014 at 02:28:33PM +0000, mobin Motallebizadeh wrote:
> can I build xenomai for armv7-r architecture? 
> I can't see this mentioned anywhere (surprisingly!)
> Is it same as other MMU-less archs(nios II ,e.g.)?
> thanks in advance 		 	   		  

Cortex-R (armv7-r) is MMU-less, so it would have to run a kernel with
no mmu enabled (which linux does support for arm as far as I recall).

I see xenomai works with blackfin which is MMU-less.  Not sure if anyone
has used xenomai with arm without an mmu, but at least in theory it
could be done then.

-- 
Len Sorensen

