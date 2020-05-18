Subject: Re: When would a real time process be able to resume running again
 after it have called rt_task_sleep?
References: <CAAvDm6Yzkph-2ecSBV_MFaYFOgO4v1gAmZi7gs-UJiLZCw3bsQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3d67731c-d13e-a546-14b9-3ba34b21cf4f@siemens.com>
Date: Mon, 18 May 2020 10:58:22 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6Yzkph-2ecSBV_MFaYFOgO4v1gAmZi7gs-UJiLZCw3bsQ@mail.gmail.com>
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

On 14.05.20 07:37, 孙世龙 via Xenomai wrote:
> Hi,
>       I wonder that when a *real time process* would be able to resume
> running again after it have called rt_task_sleep.
> 
>      Assuming that many *real time processes* with higher priority are
> running in parallel，I think the process(which have called rt_task_sleep)
> have to wait for available cpu resources *even if its sleep duration has *
> *expired*. So, the real duaration may be longer then the setting value.
> Am i right?

Yes, normal scheduling rules apply. Which one exactly depends on the 
configured scheduling policies and parameters. There can be many in a 
complex system. Nothing Xeonmai-specific, though.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

