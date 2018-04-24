MIME-Version: 1.0
In-Reply-To: <CAOuPNLjfpsTq6UNxQbu2VOyt128ecX5jQJr8VrWuHWBH_x+tog@mail.gmail.com>
References: <CAOuPNLjfpsTq6UNxQbu2VOyt128ecX5jQJr8VrWuHWBH_x+tog@mail.gmail.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Tue, 24 Apr 2018 13:20:35 +0530
Message-ID: <CAOuPNLgKtc-Vw2njNGsn2VTp-A8_mmqN-vk1F5-wVb=nTi8jnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] overlapping and missing output with large data range
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Apr 23, 2018 at 3:20 PM, Pintu Kumar <pintu.ping@gmail.com> wrote:
> Hi All,
>
> I am facing one problem with Xenomai when I try to output some 2-3
> columns data on console, may be 1000 or 10000+ ranges.
>
> This is one sample output:
> {{{
> .....
> .....
> 1369 100.232 0.232
> 1370 100.247 0.247
> 1371 100.240 0.240
> 1372 100.2181987 100.491 0.491
> 1988 100.758 0.758
> 1989 100.794 0.794
> 1990 100.805 0.805
> .....
> .....
> }}}
>
> Here I am trying to measure some latency with my test program.
> Its a simple program where I create one thread, then sleep for 100us
> and measure latency.
> I do this for 1000 times, and print latency data for each round.
> I am using normal printf/rt_printf for printing the data on console.
> Finally I take all these data and plot a graphical view.
>
> In the above output, as you can see (in one big line):
> The next iteration data is overlapped.
> Also may rows are missing.
> I guess the correct output may be:
> 1372 100.218  ??.???
> ......
> 1987 100.491 0.491
>
> So, may data are missing.
>
> I need all the data to be appearing correctly, otherwise my graphical
> plotting data goes wrong.
>
> Is there anything I am do about it?
> Any ideas will be really appreciated....
>
> I already tried by storing the latency values in an array, and then
> printing it at the end of the task.
> But this also did not help much....
>

OK, I could resolve this issue.
What I did is, I stored all latency difference in a global array.
Then, instead of printing it inside the task, I am printing it at the
end of main function itself.
This way I could get all the latency output correctly.
But, I have to maintain a large array output...
If there is any better way please let me know...


Thanks


>
> Thanks,
> Pintu

