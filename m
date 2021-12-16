Subject: Re: common clocks RTDM/user-RT
References: <CA+K1mPHJgjwb7NOM2xL62bmuwGix7LEYoa3Ars8ig9Kr9K1AfQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fbdf51a7-80f4-ad4d-7120-e3d0f1422e58@siemens.com>
Date: Thu, 16 Dec 2021 09:56:23 +0100
MIME-Version: 1.0
In-Reply-To: <CA+K1mPHJgjwb7NOM2xL62bmuwGix7LEYoa3Ars8ig9Kr9K1AfQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
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

On 16.12.21 08:37, C Smith via Xenomai wrote:
> I'm porting a real time userspace (Cobalt) app from Xenomai 2.6 to
> Xeno 3.1 (on x86). The goal is to see how much time has passed since
> the last char was received from the 16550A serial driver.

Why not moving to 3.2.x directly?

> 
> In Xenomai 2, my RT userspace app was able via ioctl to read the
> timestamp the 16550A serial driver provides
> (rx_event.rxpend_timestamp) and compare it to a timestamp from
> rt_timer_read() in the userspace app.
> 
> In Xenomai 3 however, this comparison is no longer valid. They are
> both nanosecond timers but can't be directly compared because the RTDM
> timer has a large offset compared to rt_timer_read().
> 
> Is there a way of accessing the RTDM timer and getting a timestamp
> from within my realtime userspace app which would match the serial
> driver's timestamp?

The RTDM timestamps are based on Xenomai's (or Linux's - with 5.10+)
CLOCK_REALTIME when using rtdm_clock_read() while Alchemy uses an own
clock, based on CLOCK_MONOTONIC. To compare driver timestamps against
user timestamps, take the latter via libcobalt's
__RT(clock_gettime(CLOCK_REALTIME)).

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

