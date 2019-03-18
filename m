Subject: Re: [PATCH v3] travis: add basic CI support
References: <20190311143722.21320-1-roman.stratiienko@globallogic.com>
 <20190311143722.21320-2-roman.stratiienko@globallogic.com>
 <ef22da7e-46f1-710c-53a6-4467f88b0db3@siemens.com>
 <326c8b6c-9978-13d7-f637-2841f8adcb31@siemens.com>
 <CAODwZ7uOkXMj0HN+P=_BxFireDqsdsr1dbSo8c5p5FKrPL-fLQ@mail.gmail.com>
 <07be847f-3ac0-b54f-fd3a-40ee7a827bc0@siemens.com>
 <2e814509-3d89-efd4-476c-fdcefc989b16@siemens.com>
 <CAODwZ7u6sRRVmE76-iP0rjp6+WSpaGwCsRaumuZAaq1yaDzMaQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3589e4da-293c-1765-cb3e-fc38f6aa8e94@siemens.com>
Date: Mon, 18 Mar 2019 17:51:36 +0100
MIME-Version: 1.0
In-Reply-To: <CAODwZ7u6sRRVmE76-iP0rjp6+WSpaGwCsRaumuZAaq1yaDzMaQ@mail.gmail.com>
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
To: Roman Stratiienko <roman.stratiienko@globallogic.com>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 18.03.19 17:47, Roman Stratiienko wrote:
> 
> 
> On Mon, Mar 18, 2019 at 5:39 PM Jan Kiszka <jan.kiszka@siemens.com 
> <mailto:jan.kiszka@siemens.com>> wrote:
> 
>     On 18.03.19 15:24, Jan Kiszka wrote:
>      > On 18.03.19 15:21, Roman Stratiienko wrote:
>      >> Hello Jan,
>      >>
>      >> Build failure is caused by "cobalt: Add sched-quota tracepoints".
>      >> I had to revert it to continue with testing
>      >>
>      >
>      > Ah, that's a good trace.  We might be missing some include... One minute...
>      >
> 
>     All green now with v2 of my tracepoint patch.
> 
>     So we can move forward: Any updates on the fixes for newer kernels?
> 
> 
> 
> Currently not. I started to make clean port of ipipe-noarch onto 4.19, so I hope 
> to open it for review soon.

So, I will wait for updates then, ok?

Regarding the port on 4.19: Please sync with Philippe, he plans something as 
well. It would be good if you two could work together so that you, Roman, know 
what you, Philippe, would like to have to the target branches.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

