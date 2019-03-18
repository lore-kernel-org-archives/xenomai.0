Subject: Re: [PATCH v3] travis: add basic CI support
From: Jan Kiszka <jan.kiszka@siemens.com>
References: <20190311143722.21320-1-roman.stratiienko@globallogic.com>
 <20190311143722.21320-2-roman.stratiienko@globallogic.com>
 <ef22da7e-46f1-710c-53a6-4467f88b0db3@siemens.com>
 <326c8b6c-9978-13d7-f637-2841f8adcb31@siemens.com>
 <CAODwZ7uOkXMj0HN+P=_BxFireDqsdsr1dbSo8c5p5FKrPL-fLQ@mail.gmail.com>
 <07be847f-3ac0-b54f-fd3a-40ee7a827bc0@siemens.com>
Message-ID: <2e814509-3d89-efd4-476c-fdcefc989b16@siemens.com>
Date: Mon, 18 Mar 2019 16:39:22 +0100
MIME-Version: 1.0
In-Reply-To: <07be847f-3ac0-b54f-fd3a-40ee7a827bc0@siemens.com>
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
To: Roman Stratiienko <roman.stratiienko@globallogic.com>
Cc: xenomai@xenomai.org

On 18.03.19 15:24, Jan Kiszka wrote:
> On 18.03.19 15:21, Roman Stratiienko wrote:
>> Hello Jan,
>>
>> Build failure is caused by "cobalt: Add sched-quota tracepoints".
>> I had to revert it to continue with testing
>>
> 
> Ah, that's a good trace.  We might be missing some include... One minute...
> 

All green now with v2 of my tracepoint patch.

So we can move forward: Any updates on the fixes for newer kernels?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

