MIME-Version: 1.0
References: <CA+K1mPGLQ5-B-qrTasdwc_G38cr6T78V0Nip3bEkdD89761ukA@mail.gmail.com>
 <9a0553a5-aa37-a089-54e8-45a59ebf1095@siemens.com>
In-Reply-To: <9a0553a5-aa37-a089-54e8-45a59ebf1095@siemens.com>
From: C Smith <csmithquestions@gmail.com>
Date: Tue, 2 Nov 2021 15:57:13 -0700
Message-ID: <CA+K1mPE4d9qQ2-tT+rDGBR4v__vzrXu2736+JFADco8a6Y7xLQ@mail.gmail.com>
Subject: Re: rtcansend 32-bit
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

I added some printf/printk to rtcansend.c as well as rtcan_raw.c:

rtcan_raw.c:
    /* Check size of buffer */
    if (iov->iov_len != sizeof(can_frame_t)) {
            printk("rtcan_raw.c, 850: sizeof(can_frame_t): %ld\n",
                   sizeof(can_frame_t));
                printk("rtcan_raw.c, 852: iov->iov_len: %ld\n",
iov->iov_len);
            return -EMSGSIZE;
    }

when running rtcansend (32-bit compile, which fails with EMSGSIZE):
        [root@pc can]# /usr/xenomai/bin/rtcansend rtcan0 -s 0xde 0xad
        sizeof(can_frame_t): 16
        send: Message too long

        [root@pc can]# dmesg
        [11275.197125] rtcan_raw.c, 850: sizeof(can_frame_t): 16
        [11275.197133] rtcan_raw.c, 852: iov->iov_len: 34494267600

when running rtcansend (64-bit compile, sends out can msg OK):
        [root@pc can]# /usr/xenomai/bin/rtcansend rtcan0 -s 0xde 0xad
        sizeof(can_frame_t): 16

        [root@pc can]# dmesg
        [12476.571032] rtcan_raw.c, 850: sizeof(can_frame_t): 16
        [12476.571040] rtcan_raw.c, 852: iov->iov_len: 16

It looks like the struct user_msghdr *msg passed into rtcan_raw_sendmsg()
is corrupt.
I'm using Xenomai 3.1, with kernel 4.19.989 x86_64
-C Smith

On Tue, Nov 2, 2021 at 12:11 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 02.11.21 19:57, C Smith via Xenomai wrote:
> > I ran into a problem wherein my real-time Xenomai 32-bit app
> > fails on the socket operations of the 64-bit CAN driver.
> > My real-time userspace app is Cobalt x86, compiled -m32.
> >
> > When I try the Xenomai rtcansend.c sample app compiled 32-bit, I get the
> > same error :
> >
> > [root@pc can]# /usr/xenomai/bin/rtcansend rtcan0 --verbose
> > --identifier=0x123 0xde 0xad
> > send: Message too long
> >
> > Looking at rtcansend.c. The call to sendto is failing and returns
> 'Message
> > too long' here:
> > ret = sendto(s, (void *)&frame, sizeof(can_frame_t), 0,
> > (struct sockaddr *)&to_addr, sizeof(to_addr));
> >
> > Here is how I configured Xenomai for 32-bit when I built it:
> > ./configure --host=i686-linux CFLAGS="-m32 -D_FILE_OFFSET_BITS=64"
> > LDFLAGS=-m32 host_alias=i686-linux
> >
> > But note that if I compile both Xenomai and rtcansend.c 64-bit,
> everything
> > works fine.
> >
> > So how can 32-bit Xeno apps use the 64-bit CAN driver ?
> >
>
> We possibly have compat ABI issue here: The Xenomai core can handle
> 32-bit calls of sendto (sendmsg internally) into 64-bit kernel, but
> maybe there is something beyond that interpreted by the CAN driver that
> is not aware of 32 vs. 64 bit userland.
>
> I suspect sizeof(can_frame_t) varies, though I don't see why yet. Could
> you debug that, instrument kernel/drivers/can/rtcan_raw.c as well as the
> userspace code?
>
> The other reason for EMSGSIZE would be msg_iovlen != 1, but that would
> mean we have an issue in the generic compat sendmsg code, and that is
> less likely.
>
> Jan
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux
>
