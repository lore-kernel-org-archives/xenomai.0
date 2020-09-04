Subject: Re: What are the per-cpu host timers used for?
References: <CAAvDm6Ze+LAuXFUvQkwiWPtmCiEVQJQ2aASirAJy+JRhKprcdg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <beb979d4-02a4-840e-d504-f2fdd8df82b1@siemens.com>
Date: Fri, 4 Sep 2020 12:44:15 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6Ze+LAuXFUvQkwiWPtmCiEVQJQ2aASirAJy+JRhKprcdg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
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
To: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>, xenomai <xenomai@xenomai.org>

On 04.09.20 10:00, 孙世龙 sunshilong via Xenomai wrote:
> Hi, list
> 
> There are several host timers that could be seen through the virtual
> file named as /proc/xenomai/timer/coreclk,i.e:
> 
> ~ # cat /proc/xenomai/timer/coreclk
> CPU  SCHED/SHOT       TIMEOUT     INTERVAL    NAME
> 0    239162/150321         3ms467us    -           [host-timer/0]
> 1    33839/31631            10ms657us   -           [host-timer/1]
> 2    22189/19355            60us        -                 [host-timer/2]
> 3    45244/41172            90us        -                 [host-timer/3]
> 
> 
> What are the per-cpu host timers used for?

They inject timers set by Linux against the virtual clockevent device.
That device is provided by I-pipe as replacement for the "stolen"
physical one.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

