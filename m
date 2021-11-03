Subject: Re: rtcansend 32-bit
From: Jan Kiszka <jan.kiszka@siemens.com>
References: <CA+K1mPGLQ5-B-qrTasdwc_G38cr6T78V0Nip3bEkdD89761ukA@mail.gmail.com>
 <9a0553a5-aa37-a089-54e8-45a59ebf1095@siemens.com>
 <CA+K1mPE4d9qQ2-tT+rDGBR4v__vzrXu2736+JFADco8a6Y7xLQ@mail.gmail.com>
 <87ba187f-5e89-a0f3-10f6-fc14eb5efe21@siemens.com>
Message-ID: <93290885-9113-dd98-b1df-550604fc6fff@siemens.com>
Date: Wed, 3 Nov 2021 11:46:47 +0100
MIME-Version: 1.0
In-Reply-To: <87ba187f-5e89-a0f3-10f6-fc14eb5efe21@siemens.com>
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

On 03.11.21 07:59, Jan Kiszka wrote:
> On 02.11.21 23:57, C Smith via Xenomai wrote:
>> I added some printf/printk to rtcansend.c as well as rtcan_raw.c:
>>
>> rtcan_raw.c:
>>     /* Check size of buffer */
>>     if (iov->iov_len != sizeof(can_frame_t)) {
>>             printk("rtcan_raw.c, 850: sizeof(can_frame_t): %ld\n",
>>                    sizeof(can_frame_t));
>>                 printk("rtcan_raw.c, 852: iov->iov_len: %ld\n",
>> iov->iov_len);
>>             return -EMSGSIZE;
>>     }
>>
>> when running rtcansend (32-bit compile, which fails with EMSGSIZE):
>>         [root@pc can]# /usr/xenomai/bin/rtcansend rtcan0 -s 0xde 0xad
>>         sizeof(can_frame_t): 16
>>         send: Message too long
>>
>>         [root@pc can]# dmesg
>>         [11275.197125] rtcan_raw.c, 850: sizeof(can_frame_t): 16
>>         [11275.197133] rtcan_raw.c, 852: iov->iov_len: 34494267600
>>
>> when running rtcansend (64-bit compile, sends out can msg OK):
>>         [root@pc can]# /usr/xenomai/bin/rtcansend rtcan0 -s 0xde 0xad
>>         sizeof(can_frame_t): 16
>>
>>         [root@pc can]# dmesg
>>         [12476.571032] rtcan_raw.c, 850: sizeof(can_frame_t): 16
>>         [12476.571040] rtcan_raw.c, 852: iov->iov_len: 16
>>
>> It looks like the struct user_msghdr *msg passed into rtcan_raw_sendmsg()
>> is corrupt.
>> I'm using Xenomai 3.1, with kernel 4.19.989 x86_64
>> -C Smith
> 
> OK, my guess was wrong. Let me see where we corrupt this.
> 
> Brings https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/21 into
> memory...
> 

Found it: We are lacking use of rtdm_get_iovec in rtcan - in contrast to
RTnet (see e.g. rt_packet_sendmsg). Would you feel like looking into
such a change?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

