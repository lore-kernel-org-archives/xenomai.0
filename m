MIME-Version: 1.0
References: <201903280941144857760@aliyun.com>
 <774387327.12429321.1553754576488@mail.yahoo.com>
In-Reply-To: <774387327.12429321.1553754576488@mail.yahoo.com>
From: Bart Vissers <bvissers@e2mtechnologies.eu>
Date: Thu, 28 Mar 2019 10:34:45 +0100
Message-ID: <CAB+DZ3kLgm-jLWrYJ=MBOq_19XMA+MzqrTD0JatDD30kmnbZTA@mail.gmail.com>
Subject: Re: latency test
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Alec Ari <neotheuser@ymail.com>
Cc: "demon.han@aliyun.com" <demon.han@aliyun.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

I've done some testing with the X-window suggestions at:
https://gitlab.denx.de/Xenomai/xenomai/wikis/Troubleshooting#the_latency_test_shows_high_latencies

My results on an Intel PC with Xenomai 3.0.7, Linux 4.9, Debian 9.7 with
xfce4, worst-case latencies:
- Using Intel driver: 39.8 us
- Using fbdev, 34.8 us
- Setting Option "NoAccel", both with Intel and fbdev driver: 22.6 us
- No GUI:  6.3 us

So setting "NoAccel" helps in my case, but I'm also looking forward to
further improve it.

Bart

On Thu, 28 Mar 2019 at 07:29, Alec Ari via Xenomai <xenomai@xenomai.org>
wrote:

> Firefox bumps latency up too, I wonder if the Xenomai pros have any advice
> on this. Good question! It'd be nice to do video editing and 4K encoding
> while doing real-time processes too.
>
>
> Alec
>
>
