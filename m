Message-ID: <558BA954.7060408@xenomai.org>
Date: Thu, 25 Jun 2015 09:10:12 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKC9m6dRcjd6zzDMj1uPaAeNB2F5zzAQpVUG7ZFaMwEBgtk1WA@mail.gmail.com>
In-Reply-To: <CAKC9m6dRcjd6zzDMj1uPaAeNB2F5zzAQpVUG7ZFaMwEBgtk1WA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Questions about __ipipe_pin_range_globally
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hongfei Cheng <hongfei@mperpetuo.com>, Xenomai Mailing List <xenomai@xenomai.org>

On 06/25/2015 02:12 AM, Hongfei Cheng wrote:
> While porting Xenomai 3 to an ARMv8 SoC, we're seeing peculiar errors,
> such as "level 1 translation fault", in the Linux domain when running
> a specific application. The same app runs fine when I-pipe is
> disabled.
> 
> One function, __ipipe_pin_range_globally, is of particular interest to
> us (mostly because I don't think I fully understand its purpose and
> impact).
> 
> Searching the mailing list archives, I see the following comment
> (http://www.xenomai.org/pipermail/xenomai/2014-September/031731.html)
> made by Gilles on Sep 22, 2014:
> "... ipipe_pin_range_globally probably has never been used with 3
> level page tables, which are enabled by LPAE ..."
> 
> The code change logs (in branch ipipe-3.14) show that, about 2 months
> later, on Nov 30, 2014, Philippe updated the code of
> __ipipe_pin_range_globally and pgd_holder, with a nice comment section
> (ccbd22da).
> 
> Our armv8 SoC uses 4KB page configuration and 3-level translation
> tables. I have the following questions:
> 1). Has anyone tested the latest __ipipe_pin_range_globally code
> against ARMv7 with LPAE enabled (and 3-level page tables)?

Yes, A15.

> 2). Is __ipipe_pin_range_globally mainly for the purpose of preventing
> "(minor) page faults" for applications running in primary/real-time
> domain?
> 

Correct.

-- 
Philippe.

