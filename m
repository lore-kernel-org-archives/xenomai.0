Message-ID: <54FF0D75.9070904@siemens.com>
Date: Tue, 10 Mar 2015 16:27:49 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <E1YOpt4-0000oo-4D@sd-51317.xenomai.org>
 <54E765A4.20909@xenomai.org> <54E76A59.4060000@siemens.com>
 <54E7917F.101@xenomai.org>
In-Reply-To: <54E7917F.101@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/posix/syscall:
 Exclude sc_cobalt_get_current from debug warnings
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

Am 2015-02-20 um 20:56 schrieb Philippe Gerum:
> On 02/20/2015 06:09 PM, Jan Kiszka wrote:
>> On 2015-02-20 17:49, Philippe Gerum wrote:
>>> On 02/20/2015 04:53 PM, git repository hosting wrote:
>>>> Module: xenomai-jki
>>>> Branch: for-forge
>>>> Commit: fc2d70475f4f86da30e68a569e7641982f4dd8e1
>>>> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=fc2d70475f4f86da30e68a569e7641982f4dd8e1
>>>>
>>>> Author: Jan Kiszka <jan.kiszka@siemens.com>
>>>> Date:   Fri Feb 20 16:50:15 2015 +0100
>>>>
>>>> cobalt/posix/syscall: Exclude sc_cobalt_get_current from debug warnings
>>>>
>>>> This syscall is used for probing the context, thus may be triggered by
>>>> non-RT threads as well which we should not report as potential error.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>
>>> This would mean that sc_cobalt_get_current is considered valid from any
>>> process, including those which did not issue sc_cobalt_bind in the first
>>> place.
>>>
>>> Do we depend on this today, or are we granting an extended access with
>>> this patch?
>>
>> This is just to silence a warning you get, e.g., with the smokey fork test.
>>
>> I don't think it should be illegal to call such a service, even prior to
>> binding to the interface. It is already robust against it, isn't it?
>>
> 
> Illegal maybe not, but definitely unexpected. I mean that this is a
> Cobalt service, so I would expect the userland code not to issue any
> Cobalt syscall until the initial binding took place.
> 
> The fork sequence seems to depart from this assumption due to some code
> running on behalf of the atfork handlers in libcobalt, right?

[ah, was me who forgot to follow up]

Right. The path that triggers the issue is along
cobalt_print_init_atfork -> cleanup_buffer -> assert_nrt.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

