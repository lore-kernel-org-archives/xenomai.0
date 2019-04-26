From: Steven Seeger <steven.seeger@flightsystems.net>
Subject: Re: __ipipe_root_sync
Date: Fri, 26 Apr 2019 14:15:29 -0400
Message-ID: <1853262.hL6BM7Cr2a@omoikane>
In-Reply-To: <e4e117ae-9db6-4570-8159-d6cbe4765fe8@xenomai.org>
References: <2053542.YF2tJfiQcj@omoikane>
 <e4e117ae-9db6-4570-8159-d6cbe4765fe8@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Friday, April 26, 2019 2:11:30 PM EDT Philippe Gerum wrote:
> 
> However, __ipipe_root_sync() is 100% redundant with sync_root_irqs(),
> which we need in the generic pipelined syscall handling callable from C.
> So the situation is a bit silly ATM. Let's rename sync_root_irqs() to
> __ipipe_root_sync() in -noarch, and drop any arch-local equivalent.

I fully agree with this. I can issue a second patch for 110 once it's done in 
noarch, but there's no real reason to hurry on this.

I can confirm that the 4.14.110 patch I just pushed for powerpc (for all the 
thousands of you working with PPC) that the use of __ipipe_root_sync and 
sync_root_irqs is equivalent with ARM.

Steven




