From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Tue, 17 May 2016 09:00:56 -0400
Message-ID: <20160517130056.GM3264@csclub.uwaterloo.ca>
References: <84fc0b75032a447285250327e4e843fb@advaoptical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84fc0b75032a447285250327e4e843fb@advaoptical.com>
Subject: Re: [Xenomai] understanding /proc/xenomai/stat
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

On Tue, May 17, 2016 at 12:43:04PM +0000, Sagi Maimon wrote:
> Hi all,
> Can someone explain the fileds in /proc/xenomai/stat?
> 
> To be more specific, I get this output :
>   0  0      0          16722526   0     00500080   70.2  ROOT/0
>   1  0      0          1          0     00500080   99.9  ROOT/1
>   0  0      0          9248781    0     00000082    6.7  rtnet-stack
>   [.....]
>   0  2190   1          8280188    1     00300186   10.0  PtpHandlerTask
>   [.....]
> 
> I can see that my xenomai code occupies about 30% CPU, the Linux occupies about 4%
> 
> What is the connection between xenomai and linux? Does it means that my code total CPU usage is 34%?

Since ROOT got 170.1 out of 200, then xenomai did use 29.9.  You would
have to ask linux how much of the 170.1 it actually used and how much
was idle.  Xenomai doesn't look at the scheduler in linux for you.

Now if linux says it was idle 50% of the time, then your total would be
30 for xenomai, and 50% of 170 linux, so 85 for linux, leaving 85 idle.

I am pretty sure that is how it works out.

-- 
Len Sorensen

