MIME-Version: 1.0
In-Reply-To: <CAKbLDQM1-9pQezpmBoesR6uuZw=croeD559729EAMG0QxF59pA@mail.gmail.com>
References: <CAKbLDQM1-9pQezpmBoesR6uuZw=croeD559729EAMG0QxF59pA@mail.gmail.com>
From: Ashwin Narayan <ashwinnarayan1994@gmail.com>
Date: Sun, 16 Apr 2017 02:24:28 +0800
Message-ID: <CAKbLDQPKKb7NFHfDRt1f0+yRD605kJndkQYor7jGCsgJrZsA=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Very strange error with rtcanconfig.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Thu, Apr 13, 2017 at 8:26 PM, Ashwin Narayan
<ashwinnarayan1994@gmail.com> wrote:
> Hey all,
>
> I've been working with the PCM-3680I - a can bus module. I'm trying to
> set up a simple C program that can send and receive can bus messages
> but I'm getting a very strange error.
>
> In my code, when I call socket(), I always get -1 in response.
>
> If I call
>
> sudo LD_LIBRARY_PATH=/usr/xenomai/lib /usr/xenomai/sbin/rtcanconfig
> rtcan0 -b 1000000 -v start
>
> I get the expected response:
> mode: start (0x1)
> baudrate: 1000000
>
> Then I copied and pasted the rtcanconfig.c example from the
> documentation and compiled it and it gave me the error about sockets
> again
>
> sudo LD_LIBRARY_PATH=/usr/xenomai/lib ./rtcanconfig rtcan0 -b 1000000 -v start
> mode: start (0x1)
> Cannot open RTDM CAN socket. Maybe driver not loaded?
>
> I'm sure that the driver is loaded and the precompiled rtcanconfig
> seems to be working.
>
> Any idea what's going on here?
>
> Thanks,
> -Ashwin

So I got the code to work finally and figured out what was wrong -
after many iterations of recompiling the kernel with different
options. I feel like it's not very easy to figure this out from the
documentation alone: When you compile the program you need to add
--rtdm to the CFLAGS and LDFLAGS. For future reference, I'll leave my
makefile up for others to refer to.

SRC=rtcanconfig
TARGET=rtcanconfig

CFLAGS := $(shell xeno-config --alchemy --rtdm --cflags)
LDFLAGS := $(shell xeno-config --alchemy --rtdm --ldflags)
CC := $(shell xeno-config --cc)

$(TARGET): $(SRC).c
    $(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)

-Ashwin

