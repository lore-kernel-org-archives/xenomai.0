References: <024cb4c6850d4e8fa626c8f43b66feb4@advaoptical.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <8f91fded-ea03-3cc0-b300-813332989405@xenomai.org>
Date: Mon, 2 Apr 2018 16:19:06 +0200
MIME-Version: 1.0
In-Reply-To: <024cb4c6850d4e8fa626c8f43b66feb4@advaoptical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Unrecoverable FP Unavailable Exception 801
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 04/02/2018 02:56 PM, Sagi Maimon wrote:
> Hi all,
> I am working with: Powerpc e300 SOC.
> I am using: xenomai-2.6.4 version

The key information is: which I-pipe version.

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

Reading the discussion you mentioned, it says that the bug(s) mentioned
have been fixed in 2.6.2.1, so this is unlikely to apply to 2.6.4.

> I have built a Linux application that causes many "alignment exceptions", but I don't get any Unrecoverable FP Unavailable Exceptions.
> 
> Does anyone familiar with this error?

The e300 core may also issue alignment exceptions for misaligned
single/multiple integer stores, or dcbz insn to write-through or
cache-inhibited memory.

> Have this problem fixed in recent xenomai/ipipe versions?

No fix related to this since ages.

> Where can I find a list of fixes made in any xenomai/ipipe version?
> 

Only in the git commit logs for the related I-pipe and Xenomai source trees.

-- 
Philippe.

