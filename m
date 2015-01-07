Date: Wed, 7 Jan 2015 11:12:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150107101233.GC31996@hermes.click-hack.org>
References: <CA+C+_XQi7Nji4Ecq2VH4KfVxRdtWouE4=APu4bhfo8Yk4dZ-Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+C+_XQi7Nji4Ecq2VH4KfVxRdtWouE4=APu4bhfo8Yk4dZ-Zg@mail.gmail.com>
Subject: Re: [Xenomai] Resource utilization
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathew Benson <mathew.benson@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Jan 06, 2015 at 10:20:04AM -0600, Mathew Benson wrote:
> First, I'd like to thank all contributors for Xenomai.  I'm an embedded
> software engineer accustomed to working with the more expensive closed
> RTOSs.  So far, I'm really happy with Xenomai.
> 
> Second, is there a mechanism to monitor resource utilization from user
> space?  My application used to measure CPU idle time by busy waiting and
> counting in a low priority thread.  Not the best solution, but usually very
> portable.  However, the nucleus detects the Linux kernel is getting starved
> and flags it as a failure.

You will get the same information with /proc/xenomai/stat


>  I could move this thread to secondary mode, but
> I would rather use a native API if one exists.

That would be another information (the first information is xenomai
load, the second information is the total load). For this
information, your approach is the only available.

> 
> Similar to the previous question, what other metrics are
> available?

other metrics?

-- 
					    Gilles.

