From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 25 Jun 2012 14:23:34 -0400
Message-ID: <20120625182334.GH32727@csclub.uwaterloo.ca>
References: <CAKKWdtczsEk=XA+7J5z-8N1AKMh223dr3tTkh2-prK1QPLb7SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKKWdtczsEk=XA+7J5z-8N1AKMh223dr3tTkh2-prK1QPLb7SQ@mail.gmail.com>
Subject: Re: [Xenomai] memory size
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai@xenomai.org

On Mon, Jun 25, 2012 at 06:51:53PM +0430, ali hagigat wrote:
> My computer has 3G bytes RAM. I have disabled "high memory", PAE and
> 64-bit memory and I/O resources for the Xenomai kernel and the memory
> size is nearly 900M (Why the memory size became smaller than 1G? By
> disabling those options the size should be still 3G!) :

Linux supports 900MB ram on x86, unless you have highmem support (which
supports up to 4GB), or PAE (which supports up to 64GB).

It has been that way for many many years.

-- 
Len Sorensen

