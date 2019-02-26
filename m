Subject: Re: [PATCH 04/18] drivers/ipc: bufp: fix read-write, write-write
 preemption cases
References: <20190204105647.5034-1-rpm@xenomai.org>
 <20190204105647.5034-5-rpm@xenomai.org>
 <65e6852d-df81-258e-3d1b-804009f44570@siemens.com>
 <b6c4e80e-bf05-7fb9-c27a-b191d341f232@xenomai.org>
 <bdd13d46-aefe-7e74-0f46-235fb52bd660@siemens.com>
 <5004d0f0-ebb4-e83d-5252-957be3945370@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d0c39c8b-fd2c-77de-7265-f658be2d0e69@siemens.com>
Date: Tue, 26 Feb 2019 08:10:37 +0100
MIME-Version: 1.0
In-Reply-To: <5004d0f0-ebb4-e83d-5252-957be3945370@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 26.02.19 08:03, Philippe Gerum via Xenomai wrote:
> On 2/25/19 7:17 PM, Jan Kiszka wrote:
>> On 05.02.19 12:20, Philippe Gerum via Xenomai wrote:
>>> On 2/4/19 7:55 PM, Jan Kiszka wrote:
>>>>> -             * Release the lock while copying the data to
>>>>> -             * keep latency low.
>>>>> +             * We have to drop the lock while reading in
>>>>> +             * data, but we can't rollback on bad read
>>>>> +             * from user because some other thread might
>>>>> +             * have populated the memory ahead of our
>>>>> +             * write slot already: bluntly clear the
>>>>> +             * unavailable bytes on copy error.
>>>>>                  */
>>>>>                 cobalt_atomic_leave(s);
>>>>> -            ret = xnbufd_copy_to_kmem(rsk->bufmem + wroff, bufd, n);
>>>>> -            if (ret < 0)
>>>>> -                return ret;
>>>>> +            xret = xnbufd_copy_to_kmem(rsk->bufmem + wroff, bufd, n);
>>>>>                 cobalt_atomic_enter(s);
>>>>> -            /*
>>>>> -             * In case we were preempted while copying the
>>>>> -             * message, we have to write the whole thing
>>>>> -             * again.
>>>>> -             */
>>>>> -            if (rsk->wrtoken != wrtoken) {
>>>>> -                xnbufd_reset(bufd);
>>>>> -                goto redo;
>>>>> +            if (xret < 0) {
>>>>> +                memset(rsk->bufmem + wroff + n - xret, 0, xret);
>>>>
>>>> This looks fishy, to the compiler and also to me.
>>>>
>>> Oh, well. Paste&copy blunder, the fix originates from a distinct
>>> co-kernel implementation. I'll resubmit.
>>>
>>
>> Did I get that update already? I don't think so.
>>
> 
> You may want to check my local dev. tree. I generally don't send every
> trivial change to a reviewed patch to the mailing list, but I'm
> certainly maintaining a branch for you to pick from there:
> 
> https://lab.xenomai.org/xenomai-rpm.git/commit/?h=for-upstream/next&id=99dc7076ee757c2c82ffa6c58930388974808c09
> 

Please always use the mailing list or configure auto-submission on push for your 
outgoing branch. I'm not polling personal trees, I'm not bypassing our process. 
This would also be unfair towards others who are asked to send their v2, v3 etc. 
here.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

