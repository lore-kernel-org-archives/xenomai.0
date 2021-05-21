Subject: Re: "cobalt/vfile: seq_file seek index must progress"
References: <f31cf9eb-1bbe-f4ea-cf7e-ba10f3969236@siemens.com>
 <8735ugdv8n.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <635bdb45-09b0-b1c0-424e-c0a474ac170f@siemens.com>
Date: Fri, 21 May 2021 16:39:46 +0200
MIME-Version: 1.0
In-Reply-To: <8735ugdv8n.fsf@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 21.05.21 16:20, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> Hi Philippe,
>>
>> https://source.denx.de/Xenomai/xenomai/-/commit/dd9a5ee0ed6f734f40d3733f9fff23394c8647bd
>>
>> Bug fix unrelated to dovetail? There is no description, so I cannot
>> easily asses this.
>>
> 
> Yeah, not good. The idea is that the offset field we receive from the
> kernel must progress in order for the loop to stop properly,
> independently from our own tracking of the end-of-list condition.
> 
> AFAIR, this was very easily reproducible by running a test app creating
> a few tenths of threads (10-20 would suffice) which would exit shortly
> after, while running a cat loop on /proc/xenomai/sched/next. At some
> point, the cat loop would cause the vfile handler to crash.
> 

OK, so this is an important independent bug fix.

It's not yet in next. Maybe you could sent it along with the reasoning
as patch to the list. Would then also pick it into stable.

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

