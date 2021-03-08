Subject: Re: Failing self-test on wip/dovetail with Linux 5.4
References: <f31c01722c02983cbbf04196d63f1e93d5ca70d3.camel@siemens.com>
 <7cfe500af39e85fd93ae8e95b9cfd63c8ff4930b.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1a89d6f1-f199-8187-9df8-14e5aa5998eb@siemens.com>
Date: Mon, 8 Mar 2021 11:42:12 +0100
MIME-Version: 1.0
In-Reply-To: <7cfe500af39e85fd93ae8e95b9cfd63c8ff4930b.camel@siemens.com>
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
To: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04.03.21 19:33, florian.bezdeka--- via Xenomai wrote:
> On Thu, 2021-03-04 at 14:18 +0000, florian.bezdeka--- via Xenomai
> wrote:
>> Hi,
>>
>> the attached kernel log was taken form a local qemu machine with
>> Xenomai build from the wip/dovetail branch. There is a failing selftest
>> (mixed read-lock/lock-write ABBA).
>>
> 
> Correction: I can reproduce that with `next` as well. So it's not
> related to the wip/dovetail branch. 
> 

Situation still the same with the latest release?

Jan

>> I guess it's OK for now (as this branch is work in progress). Pushing
>> it out to the list just in case nobody noticed so far and we should
>> have a look before moving forward.
>>
>> Best regards,
>> Florian
>>
>>
>> -- 
>> Siemens AG, T RDA IOT
>> Corporate Competence Center Embedded Linux
>> -------------- next part --------------
>> A non-text attachment was scrubbed...
>> Name: dmesg.log
>> Type: text/x-log
>> Size: 89883 bytes
>> Desc: dmesg.log
>> URL: <http://xenomai.org/pipermail/xenomai/attachments/20210304/558b48aa/attachment.bin
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

