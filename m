Subject: Re: Must I provide both rt function and nrt function for the ops of
 rtdm driver ?
References: <CAAvDm6ZqF-KdCS1Fz9MrXb7b16Otega46S=PH6CaJU3wcZt21Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <77317a01-a801-ff9b-68de-b1d4525a8329@siemens.com>
Date: Thu, 16 Apr 2020 10:52:07 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6ZqF-KdCS1Fz9MrXb7b16Otega46S=PH6CaJU3wcZt21Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>, xenomai <xenomai@xenomai.org>

On 16.04.20 09:49, 孙世龙 via Xenomai wrote:
> Hi,
>          Must I provide both rt function and nrt function for the ops of
> rtdm driver ?
>          Must I implement the rt read and nrt read operation if i need
> provide read operation for my rtdm driver?What I have to consider?
>          I have searched all over the source code of xenomai-v3.1.I find
> that most rtdm driver have both rt_ioctl and nrt_ioctl  ,but none
> nrt_read\nrt_write function is implemented except the driver named analogy.
> 

A driver need not implement both handlers. If it leaves one 
unimplemented (NULL), the RTDM core will switch the caller to the mode 
where there is an implementation.

Normally, an RTDM driver has no use in provided a non-RT-only version of 
its read/write handlers. Therefore it only provides the _rt variant.

The situation is different for ioctls, though, because there can be many 
subservices (IOCTL codes) behind that single handler. Some of those may 
be used for initialization and require to call plain Linux function 
(like vmalloc). Therefore, they implement both handlers and decide 
whether to take a specific IOCTL code after dispatching - or direct it 
to the "other side" by returning -ENOSYS. That should be described in 
the RTDM section of our documentation.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

