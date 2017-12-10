MIME-Version: 1.0
From: Andreas Glatz <andi.glatz@gmail.com>
Date: Sun, 10 Dec 2017 22:29:33 +0000
Message-ID: <CAKJ14NeeDy6iiJdxpktbdub_TV7OVL=o=O7QNqg7z463KJzf5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] xenomai 3.0.3 POSIX rtnet API
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jacklee11@foxmail.com

>>
>>  ? My Xenomai version is 3.0.3 and I use the POSIX API with the
>> following build options.
>>
>>
>> XENO_CONFIG := /usr/xenomai/bin/xeno-config
>> CFLAGS := $(shell $(XENO_CONFIG) --vxworks --cflags)
>> LDFLAGS := $(shell $(XENO_CONFIG) --vxworks --ldflags)
>> CC := $(shell $(XENO_CONFIG) --cc)
>
> You say you're using the POSIX API, but these compiler options have
> the --vxworks switch... so something's not right....

Sorry, saw your other post with the correct syntax too late.

>
>>
>>  ? What APIs can I use for RTnet?
>>
>>  ? The Link below uses alchemy APIs?
>>
>> http://xenomai.org/rtnet-programming/
>>
>
> Basically, RTnet API calls can be derived from the equivalent POSIX
> API calls by sticking rt_dev_ in front of the original POSIX API call

I was wrong there as well. If you compile your POSIX application under
Xenomai 3, the linker wrapper script sticks __wrap_ in front of
standard POSIX symbols (e.g. socket() -> __wrap_socket()).

Assuming you have a compiled & installed xenomai3, a POSIX
application, such as a UDP server [1], can then be compiled with:

`${STAGING_DIR}/usr/xenomai/bin/xeno-config --cc --posix --cflags
--ldflags` -o server server.c

After configuring & bringing up rteth0 with an IP address I can run
this UDP server on my ARM i.MX6 board (wandboard):

root@arm:/home/debian# env LD_LIBRARY_PATH=/usr/xenomai/lib/ ./server
Waiting for data...Received packet from 192.168.3.108:47039
Data: huhu

I also see UDP packets going back and forth between the UDP server and
client with e.g. wireshark.

A.

[1] http://www.binarytides.com/programming-udp-sockets-c-linux/

