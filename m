Subject: Re: Moving inband work off stack - remaing cases
References: <f5a5c0eb-444d-2af3-b493-ec0c9b9ee428@siemens.com>
 <875yykbeij.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <effb1137-46da-2125-f309-aaf3fa5ea478@siemens.com>
Date: Fri, 11 Jun 2021 18:19:00 +0200
MIME-Version: 1.0
In-Reply-To: <875yykbeij.fsf@xenomai.org>
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

On 11.06.21 17:35, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> Hi Philippe,
>>
>> I'm trying to understand the reasoning for moving inband work struct for
>> the remaining cases of the triggering stack.
>>
>> To my understanding, this is not needed for xnthread_map (to be
>> privatized soon, so only for the in-tree case) because the caller
>> providing the struct waits for the completion which will be triggered
>> via the inband handler.
>>
> 
> Correct.
> 
>> Looking at xnthread_relax(), the same should apply to post_wakeup -
>> provided it is inlined into xnthread_relax - because, again, we won't
>> leave that function before the signal was sent, thus the work consumed.
>>
> 
> Correct.
> 
>> Am I missing something?
>>
> 
> Nope.
> 

Perfect.

I'm finalizing the patches to merge dovetail completely into next. With
your unicore-SMP fix, we should even get a green test pipeline soon.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

