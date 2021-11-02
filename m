MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Tue, 2 Nov 2021 11:57:32 -0700
Message-ID: <CA+K1mPGLQ5-B-qrTasdwc_G38cr6T78V0Nip3bEkdD89761ukA@mail.gmail.com>
Subject: rtcansend 32-bit
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai List <xenomai@xenomai.org>

I ran into a problem wherein my real-time Xenomai 32-bit app
fails on the socket operations of the 64-bit CAN driver.
My real-time userspace app is Cobalt x86, compiled -m32.

When I try the Xenomai rtcansend.c sample app compiled 32-bit, I get the
same error :

[root@pc can]# /usr/xenomai/bin/rtcansend rtcan0 --verbose
--identifier=0x123 0xde 0xad
send: Message too long

Looking at rtcansend.c. The call to sendto is failing and returns 'Message
too long' here:
ret = sendto(s, (void *)&frame, sizeof(can_frame_t), 0,
(struct sockaddr *)&to_addr, sizeof(to_addr));

Here is how I configured Xenomai for 32-bit when I built it:
./configure --host=i686-linux CFLAGS="-m32 -D_FILE_OFFSET_BITS=64"
LDFLAGS=-m32 host_alias=i686-linux

But note that if I compile both Xenomai and rtcansend.c 64-bit, everything
works fine.

So how can 32-bit Xeno apps use the 64-bit CAN driver ?

thanks,
-C Smith
