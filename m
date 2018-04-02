Date: Mon, 2 Apr 2018 11:23:04 -0400
Message-ID: <20180402152304.5q6pt5a74j52ylpl@csclub.uwaterloo.ca>
References: <024cb4c6850d4e8fa626c8f43b66feb4@advaoptical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <024cb4c6850d4e8fa626c8f43b66feb4@advaoptical.com>
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: [Xenomai] Unrecoverable FP Unavailable Exception 801
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sagi Maimon <SMaimon@advaoptical.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Apr 02, 2018 at 12:56:39PM +0000, Sagi Maimon wrote:
> Hi all,
> I am working with: Powerpc e300 SOC.
> I am using: xenomai-2.6.4 version
> 
> I am experiencing this exception on my Linux :
> Unrecoverable FP Unavailable Exception 801 at c0003858
> Oops: Unrecoverable FP Unavailable Exception, sig: 6 [#1]
> 
> This happens during "alignment exception" (600)
> 
> I found this link:
> https://www.mail-archive.com/search?l=xenomai@xenomai.org&q=subject:%22Re%5C%3A+%5C%5BXenomai%5C%5D+FPU+problems+in+Xenomai+2.4.x%22&o=newest&f=1
> 
> As I understand heavy use of FPU by Linux application with the xenomai can Couse this problem.
> I have built a Linux application that causes many "alignment exceptions", but I don't get any Unrecoverable FP Unavailable Exceptions.
> 
> Does anyone familiar with this error?
> Have this problem fixed in recent xenomai/ipipe versions?
> Where can I find a list of fixes made in any xenomai/ipipe version?

As far as I recall (it has been a few years), the powerpc does not allow
unalligned 64 bit floating point accesses.  So your data better be
aligned properly.

-- 
Len Sorensen

