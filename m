Subject: Re: Failing self-test on wip/dovetail with Linux 5.4
References: <f31c01722c02983cbbf04196d63f1e93d5ca70d3.camel@siemens.com>
 <7cfe500af39e85fd93ae8e95b9cfd63c8ff4930b.camel@siemens.com>
 <1a89d6f1-f199-8187-9df8-14e5aa5998eb@siemens.com>
 <e124bb8b9cedb1682cce4f192e22dd9872bc9c48.camel@siemens.com>
 <f034ba57-39cc-9231-2f94-d94267f317e6@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a5d4eb12-e327-7242-833a-40ae13d24ccb@siemens.com>
Date: Thu, 11 Mar 2021 10:12:38 +0100
MIME-Version: 1.0
In-Reply-To: <f034ba57-39cc-9231-2f94-d94267f317e6@siemens.com>
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
To: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08.03.21 13:46, Jan Kiszka via Xenomai wrote:
> On 08.03.21 13:42, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
>> On Mon, 2021-03-08 at 11:42 +0100, Jan Kiszka wrote:
>>> On 04.03.21 19:33, florian.bezdeka--- via Xenomai wrote:
>>>> On Thu, 2021-03-04 at 14:18 +0000, florian.bezdeka--- via Xenomai
>>>> wrote:
>>>>> Hi,
>>>>>
>>>>> the attached kernel log was taken form a local qemu machine with
>>>>> Xenomai build from the wip/dovetail branch. There is a failing selftest
>>>>> (mixed read-lock/lock-write ABBA).
>>>>>
>>>>
>>>> Correction: I can reproduce that with `next` as well. So it's not
>>>> related to the wip/dovetail branch.
>>>>
>>>
>>> Situation still the same with the latest release?
>>
>> Which release? I tried to build the "testing" branch of xenomai-images
>> (which holds the COW patches) but that doesn't build at all, patches
>> can not be applied.
>>
> 
> Yeah, that's because they are applied to latest x86 I-pipe releases. You
> don't need that branch for that arch anymore.
> 
>> used cmdline:
>> kas-container build kas.yml:opt-linux-latest-5.4.yml:board-qemu-amd64.yml:opt-xenomai-next.yml
>>
>> Building and running the "next" branch of xenomai-images still reports
>> the same failing self-test.
> 
> Hmm, too bad...
> 
> Jan
> 

FWIW, I'm still not getting this one, but I face random SEGV of
applications while latency is running. I'm not seeing this with latest
4.19 so far. Seems like 5.4-x86 is not yet stable...

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

