Message-ID: <535A4E5F.9060109@xenomai.org>
Date: Fri, 25 Apr 2014 14:00:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <531A29CC.4040201@xenomai.org> <533FF394.1020405@xenomai.org>
 <535A3B92.5070206@siemens.com>
In-Reply-To: <535A3B92.5070206@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM rework (2)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 04/25/2014 12:40 PM, Jan Kiszka wrote:
> On 2014-04-05 14:14, Gilles Chanteperdrix wrote:
>> On 03/07/2014 09:19 PM, Gilles Chanteperdrix wrote:
>>>
>>> Hi,
>>>
>>> here comes a second attempt at introducing a file descriptor support for
>>> other purposes than RTDM drivers.
>>>
>>> This time, the file descriptors are called rtdm_fd and are part of the
>>> RTDM API, but can be used by the POSIX personality. The actual RB-tree
>>> where they are stored is part of the xnsys_ppd structure, as this way it
>>> can be used by one of the RTDM and POSIX personalities, even if the
>>> current process is not bound to the other personality.
>>>
>>> I have posted the patches to the timerbench, switchtest, rtdm, xddp,
>>> iddp and bufp drivers to allow seeing the API changes.
>>
>> Hi Jan,
>>
>> ping?
>>
>> I have a pile of code needing to be rebased on these patches, I would
>> very much like to get all this merged before it bitrots too much.
> 
> Finally looking into them now. Do you happen to have them in git
> somewhere? Or what was the revision they once applied to?

Branch for-forge-rtdm-rework in xenomai-gch.git.


-- 
                                                                Gilles.

