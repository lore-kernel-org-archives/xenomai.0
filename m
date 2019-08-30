Subject: Re: [PATCH v4 1/2] cobalt: switch hand over status to -EADV for
 non-RTDM fd
References: <20190830160314.29441-1-rpm@xenomai.org>
 <636b4952-c260-5300-7be8-d57273526cd0@siemens.com>
 <cc7d2ce7-db9f-a384-b092-bc522e80f661@xenomai.org>
 <5eb2c28f-02b3-6c6d-c00a-ae096281c3a7@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <841daa12-af82-488e-a1c2-32c9d19e189a@siemens.com>
Date: Fri, 30 Aug 2019 19:51:55 +0200
MIME-Version: 1.0
In-Reply-To: <5eb2c28f-02b3-6c6d-c00a-ae096281c3a7@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 30.08.19 19:36, Philippe Gerum wrote:
> On 8/30/19 7:13 PM, Philippe Gerum via Xenomai wrote:
>> On 8/30/19 6:58 PM, Jan Kiszka wrote:
>>> On 30.08.19 18:03, Philippe Gerum wrote:
>>>> Having the RTDM core return -EBADF to indicate that it does not manage
>>>> a file descriptor is a problem, as several drivers also raise this
>>>> error to notify userland about an aborted wait due to a connection
>>>> being dismantled (e.g. RTnet). In this case, libcobalt ends up
>>>> forwarding the aborted request to the glibc, which is wrong.
>>>>
>>>> Switch from -EBADF to -EADV to notify userland that RTDM does not
>>>> manage a file descriptor, which cannot conflict with any sensible
>>>> error code the Cobalt core or any RTDM driver may return.
> 
> <snip>
> 
>>>
>>> I'm seeing a few more suspicious occurrences of EBADF in the core:
>>>
>>> kernel/cobalt/posix/io.c:191:   return -EBADF;
>>> kernel/cobalt/posix/io.c:289:                   return -EBADF;
>>> kernel/cobalt/posix/syscall32.c:742:                    return -EBADF;
>>
>> We still want to receive -EBADF on wrong fildes appearing in select()
>> descriptors.
> 
> FWIW, the rationale for this change is that forwarding a request to
> glibc iff the first fd found in a set is a regular one is really fragile
> and actually never worked properly: what if there is a mixed set of
> rtdm/regular fds, with the first one belonging to RTDM?
> 
> So people should make sure to call libcobalt's version of select() if
> they want to monitor RTDM fds, __STD(select()) otherwise. Relying on a
> silent fallback from libcobalt to glibc solely based on fairly weak
> heuristics is not helping anyone in the end.
> 

Indeed. Do we have a good place for documenting this?

Thanks for clarifying - merged to next now.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

