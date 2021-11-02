Subject: Re: rtcansend 32-bit
References: <CA+K1mPGLQ5-B-qrTasdwc_G38cr6T78V0Nip3bEkdD89761ukA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9a0553a5-aa37-a089-54e8-45a59ebf1095@siemens.com>
Date: Tue, 2 Nov 2021 20:11:26 +0100
MIME-Version: 1.0
In-Reply-To: <CA+K1mPGLQ5-B-qrTasdwc_G38cr6T78V0Nip3bEkdD89761ukA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: C Smith <csmithquestions@gmail.com>, Xenomai List <xenomai@xenomai.org>

On 02.11.21 19:57, C Smith via Xenomai wrote:
> I ran into a problem wherein my real-time Xenomai 32-bit app
> fails on the socket operations of the 64-bit CAN driver.
> My real-time userspace app is Cobalt x86, compiled -m32.
> 
> When I try the Xenomai rtcansend.c sample app compiled 32-bit, I get the
> same error :
> 
> [root@pc can]# /usr/xenomai/bin/rtcansend rtcan0 --verbose
> --identifier=0x123 0xde 0xad
> send: Message too long
> 
> Looking at rtcansend.c. The call to sendto is failing and returns 'Message
> too long' here:
> ret = sendto(s, (void *)&frame, sizeof(can_frame_t), 0,
> (struct sockaddr *)&to_addr, sizeof(to_addr));
> 
> Here is how I configured Xenomai for 32-bit when I built it:
> ./configure --host=i686-linux CFLAGS="-m32 -D_FILE_OFFSET_BITS=64"
> LDFLAGS=-m32 host_alias=i686-linux
> 
> But note that if I compile both Xenomai and rtcansend.c 64-bit, everything
> works fine.
> 
> So how can 32-bit Xeno apps use the 64-bit CAN driver ?
> 

We possibly have compat ABI issue here: The Xenomai core can handle
32-bit calls of sendto (sendmsg internally) into 64-bit kernel, but
maybe there is something beyond that interpreted by the CAN driver that
is not aware of 32 vs. 64 bit userland.

I suspect sizeof(can_frame_t) varies, though I don't see why yet. Could
you debug that, instrument kernel/drivers/can/rtcan_raw.c as well as the
userspace code?

The other reason for EMSGSIZE would be msg_iovlen != 1, but that would
mean we have an issue in the generic compat sendmsg code, and that is
less likely.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

