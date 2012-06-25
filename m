Message-ID: <4FE8D54F.7060805@xenomai.org>
Date: Mon, 25 Jun 2012 23:17:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtczsEk=XA+7J5z-8N1AKMh223dr3tTkh2-prK1QPLb7SQ@mail.gmail.com>
	<20120625182334.GH32727@csclub.uwaterloo.ca>
In-Reply-To: <20120625182334.GH32727@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] memory size
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On 06/25/2012 08:23 PM, Lennart Sorensen wrote:
> On Mon, Jun 25, 2012 at 06:51:53PM +0430, ali hagigat wrote:
>> My computer has 3G bytes RAM. I have disabled "high memory", PAE and
>> 64-bit memory and I/O resources for the Xenomai kernel and the memory
>> size is nearly 900M (Why the memory size became smaller than 1G? By
>> disabling those options the size should be still 3G!) :
> 
> Linux supports 900MB ram on x86, unless you have highmem support (which
> supports up to 4GB), or PAE (which supports up to 64GB).
> 
> It has been that way for many many years.
> 

Not exactly, you can increase the kernel-space memory, by decreasing the
user-space applications address space, using CONFIG_VMSPLIT_2G or even
CONFIG_VMSPLIT_1G.

But if your machine is a 64 bits machine, you should probably simply
compile a 64 bits kernel.

But anyway, people elsewhere, know better than we do. See for instance:
http://linux-mm.org/HighMemory

-- 
                                                                Gilles.

