Date: Wed, 6 Jan 2021 08:04:14 +0800
From: Fino Meng <fino.meng@linux.intel.com>
Subject: Re: Is it possible to implement a real-time API to read the files on
 the disk?
Message-ID: <20210106000413.GA28404@linux.intel.com>
References: <CAAvDm6au1h8Mqwk5Dqevduk9iMJ8crvzb4pOhhZhO85EgRVCQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAvDm6au1h8Mqwk5Dqevduk9iMJ8crvzb4pOhhZhO85EgRVCQg@mail.gmail.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?5a2Z5LiW6b6Z?= sunshilong <sunshilong369@gmail.com>
Cc: xenomai@xenomai.org

On Mon, Jan 04, 2021 at 07:58:53PM +0800, 孙世龙 sunshilong via Xenomai wrote:
> Is it possible to implement a real-time API to read the files on the disk?
> 
> As far as I know, there is no such an interface now, but is it
> possible to achieve this goal?
> 
> I would be grateful to have some help with this question.
> 
> Best Regards
> Sunshilong
>

my first thinking, disks are heavily shared resources in a general OS, if
realtime API occupy it for a long time, non-realtime thread all have to
wait.

read a file is too much slow compare a realtime thread's latency/jitter
scope (< 20us)

depends on your use case, maybe possible to add a raw disk, only used by
the time critical code?

BR/fino 

