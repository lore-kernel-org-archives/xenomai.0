References: <CAG40PBoYx81YT02qB2mvz5jKU9Uzh4U8n57+KGpvRfioS2nmoQ@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: uapi/evl/net/sched.h overwriting /uapi/evl/sched.h during meson
 install
Date: Thu, 24 Feb 2022 18:41:30 +0100
In-reply-to: <CAG40PBoYx81YT02qB2mvz5jKU9Uzh4U8n57+KGpvRfioS2nmoQ@mail.gmail.com>
Message-ID: <87czjcf9c4.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Pettit <vendors@dysim.com>
Cc: xenomai@xenomai.org


Greg Pettit via Xenomai <xenomai@xenomai.org> writes:

> I am setting up evl on a rpi4b using the following tags:
> linux-evl: v5.10.89-evl1-rebase
> libevl: r30
>
> During the install it appears that /uabi/evl/sched.h is getting overwritten
> by /uapi/evl/net/sched.h
> From meson install:
> ...
> Installing /home/pi/build/include/uapi/evl/sched.h to
> /usr/local/include/uapi/evl
> ...
> and then later in the install process...
> ...
> Installing /home/pi/build/include/uapi/evl/net/sched.h to
> /usr/local/include/uapi/evl
>

Yup. Should be fixed in master by now.

> Is this expected behavior or am I doing something wrong?

Nope, I messed up during the transition to meson.

> Also, thanks for
> all the development efforts!  This is my first venture back into real time
> linux since RTAI-3.4.
>

Welcome back.

Thanks for the heads up.

-- 
Philippe.

