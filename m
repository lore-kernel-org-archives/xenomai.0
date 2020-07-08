Subject: Re: Doubts in RTDM Driver-reg
References: <CAJCHRmGZaeqaf6GGVQSxBRL9j6LyVumHLf+ZJpDShy1sqpuaww@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <a87d1d99-a246-c9ed-e291-02f7a13b5fb6@web.de>
Date: Wed, 8 Jul 2020 19:13:53 +0200
MIME-Version: 1.0
In-Reply-To: <CAJCHRmGZaeqaf6GGVQSxBRL9j6LyVumHLf+ZJpDShy1sqpuaww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lakshmi Dhanaraj <lakshmi.d@teclever.com>, xenomai@xenomai.org

On 03.07.20 15:23, Lakshmi Dhanaraj via Xenomai wrote:
> Hi,
>
> I have a Reflective Memory 5565 hardware driver which is compiled in
> xenomai-3.0.5(Linux-4.9.38+Ubuntu 18.04.1) & api functions are compiled
> with xeno-config flags.
>
> The api functions are communicated with the rfm2g driver using ioctl
> calls.Now my doubt is the driver calls are forwarded to xenomai kernel o=
r
> generic kernel.Is there any necessity to recompile my driver with RTDM
> wrapper for real-time access.
>

Porting a driver to RTDM involves more than recompiling. You need to
design the driver for the RT execution environment. Study the existing
drivers as well as the RTDM API to get an impression.

Jan

