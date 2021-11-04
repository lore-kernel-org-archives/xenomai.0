MIME-Version: 1.0
References: <CA+K1mPGLQ5-B-qrTasdwc_G38cr6T78V0Nip3bEkdD89761ukA@mail.gmail.com>
 <9a0553a5-aa37-a089-54e8-45a59ebf1095@siemens.com>
 <CA+K1mPE4d9qQ2-tT+rDGBR4v__vzrXu2736+JFADco8a6Y7xLQ@mail.gmail.com>
 <87ba187f-5e89-a0f3-10f6-fc14eb5efe21@siemens.com>
 <93290885-9113-dd98-b1df-550604fc6fff@siemens.com>
 <03214e1aeb2ad8c681e63a01fd6051ec3c309aec.camel@siemens.com>
In-Reply-To: <03214e1aeb2ad8c681e63a01fd6051ec3c309aec.camel@siemens.com>
From: C Smith <csmithquestions@gmail.com>
Date: Wed, 3 Nov 2021 23:49:42 -0700
Message-ID: <CA+K1mPGzCcaxm4qT4vF5kkk2yc5c8mTxq1mJ1Wp6UW6H2ftmuw@mail.gmail.com>
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
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>

I was able to make the CAN transmit work successfully from my 32 bit
compile of rtcansend.c, by adding rtdm_get_iovec() to the code. I'll submit
a patch once both transmit  and receive are working, but I'm still having
trouble receiving data in the rtcanrecv app. I added rtdm_get_iovec() to
rtcan_raw_recvmsg() so that may ultimately work but the driver is already
giving up during the bind. I get this error:

[root@pc can]# /usr/xenomai/bin/rtcanrecv rtcan0 -v
interface rtcan0
s=3, ifr_name=rtcan0
bind: Invalid argument
Cleaning up...

Here's the ioctl with extra printk()s, which executes during the bind:

int rtcan_raw_ioctl(struct rtdm_fd *fd,unsigned int request, void *arg)
{
    int ret = 0;

    switch (request) {
    COMPAT_CASE(_RTIOC_BIND): {
struct _rtdm_setsockaddr_args *setaddr, setaddr_buf;
struct sockaddr_can *sockaddr, sockaddr_buf;

if (rtdm_fd_is_user(fd)) {
   /* Copy argument structure from userspace */
printk("rtcan_raw.c, 421: rtcan_raw_ioctl\n");

if (rtdm_safe_copy_from_user(fd, &setaddr_buf, arg,
   sizeof(struct _rtdm_setsockaddr_args)))
return -EFAULT;

   setaddr = &setaddr_buf;
printk("rtcan_raw.c, 427: rtcan_raw_ioctl\n");
printk("rtcan_raw.c, 428: setaddr->addrlen: %d\n", setaddr->addrlen);

   /* Check size */
   if (setaddr->addrlen != sizeof(struct sockaddr_can))
return -EINVAL;

The resultant print statements in dmesg :
[27177.480980] rtcan_raw.c, 421: rtcan_raw_ioctl
[27177.480987] rtcan_raw.c, 427: rtcan_raw_ioctl
[27177.480994] rtcan_raw.c, 428: setaddr->addrlen: -6084360

Do you have any idea why addrlen is corrupt ?
Thanks, -C Smith

On Wed, Nov 3, 2021 at 4:09 AM Bezdeka, Florian <florian.bezdeka@siemens.com>
wrote:

> On Wed, 2021-11-03 at 11:46 +0100, Jan Kiszka via Xenomai wrote:
> > On 03.11.21 07:59, Jan Kiszka wrote:
> > > On 02.11.21 23:57, C Smith via Xenomai wrote:
> > > > I added some printf/printk to rtcansend.c as well as rtcan_raw.c:
> > > >
> > > > rtcan_raw.c:
> > > >     /* Check size of buffer */
> > > >     if (iov->iov_len != sizeof(can_frame_t)) {
> > > >             printk("rtcan_raw.c, 850: sizeof(can_frame_t): %ld\n",
> > > >                    sizeof(can_frame_t));
> > > >                 printk("rtcan_raw.c, 852: iov->iov_len: %ld\n",
> > > > iov->iov_len);
> > > >             return -EMSGSIZE;
> > > >     }
> > > >
> > > > when running rtcansend (32-bit compile, which fails with EMSGSIZE):
> > > >         [root@pc can]# /usr/xenomai/bin/rtcansend rtcan0 -s 0xde
> 0xad
> > > >         sizeof(can_frame_t): 16
> > > >         send: Message too long
> > > >
> > > >         [root@pc can]# dmesg
> > > >         [11275.197125] rtcan_raw.c, 850: sizeof(can_frame_t): 16
> > > >         [11275.197133] rtcan_raw.c, 852: iov->iov_len: 34494267600
> > > >
> > > > when running rtcansend (64-bit compile, sends out can msg OK):
> > > >         [root@pc can]# /usr/xenomai/bin/rtcansend rtcan0 -s 0xde
> 0xad
> > > >         sizeof(can_frame_t): 16
> > > >
> > > >         [root@pc can]# dmesg
> > > >         [12476.571032] rtcan_raw.c, 850: sizeof(can_frame_t): 16
> > > >         [12476.571040] rtcan_raw.c, 852: iov->iov_len: 16
> > > >
> > > > It looks like the struct user_msghdr *msg passed into
> rtcan_raw_sendmsg()
> > > > is corrupt.
> > > > I'm using Xenomai 3.1, with kernel 4.19.989 x86_64
> > > > -C Smith
> > >
> > > OK, my guess was wrong. Let me see where we corrupt this.
> > >
> > > Brings https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/21
> into
> > > memory...
> > >
> >
> > Found it: We are lacking use of rtdm_get_iovec in rtcan - in contrast to
> > RTnet (see e.g. rt_packet_sendmsg). Would you feel like looking into
> > such a change?
>
> Just a note: rtcan_raw_sendmsg() and rtcan_raw_recvmsg() are both
> affected. Both should be using rtdm_get_iovec().
>
> >
> > Jan
> >
>
>
