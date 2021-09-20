References: <003a01d7a10d$9268d6b0$b73a8410$@ecler.com>
 <87sfyk7pwl.fsf@xenomai.org> <001701d7a241$8f019ae0$ad04d0a0$@ecler.com>
 <87mtor6mi7.fsf@xenomai.org> <000001d7a816$334d9bb0$99e8d310$@ecler.com>
 <000e01d7a875$15c08ee0$4141aca0$@ecler.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Using oob GPIO on RPi4B and evl_poll
In-reply-to: <000e01d7a875$15c08ee0$4141aca0$@ecler.com>
Date: Mon, 20 Sep 2021 08:57:51 +0200
Message-ID: <87ee9j20pc.fsf@xenomai.org>
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
To: j.villena@ecler.com
Cc: xenomai@xenomai.org


j.villena--- via Xenomai <xenomai@xenomai.org> writes:

> Sorry Philippe, I have found another evl_poll related issue, similar to the
> previous one. This time, a system crash happens when waiting in evl_poll for
> more than 3 file descriptors.
>
> This is a simple program to force the wrong behavior:
> https://www.dropbox.com/s/bq7lng7dgvknypv/evl_poll_test2.c?dl=0
>
> It's very similar to the other sent previously, but not using any GPIO
> related functionality. The only objects which file descriptors are used in
> evl_poll are evl_flags. The program works as expected using a value of
> kFlagsCount < 4. From 4 upwards the kernel freezes.
>
> The kernel console output using kFlagsCount > 3 is:
>

<snip>

Once again your test program made a difference by illustrating the issue
clearly, thanks for this. The bug was related to the previous one, same
root cause which I eventually fixed for good with [1].

libevl r27 is out [2] with one test case more covering this (poll-many).

[1] https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/ccfed6556c7adf47a8e61febb681735f3b2710bc
[2] https://source.denx.de/Xenomai/xenomai4/libevl/-/tree/r27

-- 
Philippe.

