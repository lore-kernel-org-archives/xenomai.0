Subject: Re: Could nomal linux threads and xenomai threads run together in the
 same process?
References: <CAAvDm6bhWJ_j67eJ9p9d1Efj6kTDdCV6TrVE90Z6Y=OPZxQxjQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3f8a90fd-4c3f-7d75-7669-2c43603f5e77@siemens.com>
Date: Mon, 18 May 2020 11:22:58 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6bhWJ_j67eJ9p9d1Efj6kTDdCV6TrVE90Z6Y=OPZxQxjQ@mail.gmail.com>
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

On 18.05.20 11:16, 孙世龙 via Xenomai wrote:
> Hi,
> As per the documentation
> (https://research.idi.ntnu.no/multicore/_media/
> linux_xenomai_hard_real-time_en_read-only_.pdf  *page number:11*),
> it give me the sense that *nomal linux threads *which are not normal
> xenomai thread whose scheduling policy is SCHED_OTHER and *xenomai threads*
> could
> run together *in the same process*? Is that really the case?
> 
> Thank you for your attention to this matter.
> Look forward to hearing from you.
> 

Yes, that works fine. However, if your ordinary Linux thread should 
access a Xenomai API that may block (on RT resources), it has to be at 
least wrapped with Xenomai shadow thread. But that happens automatically 
if you are using the POSIX interface and build the application with the 
options xeno-config reports.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

