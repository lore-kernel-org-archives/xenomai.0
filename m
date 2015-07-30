References: <55B91E8E.9010304@xenomai.org>
 <1152732986.5695318.1438266535029.JavaMail.yahoo@mail.yahoo.com>
 <599721336.5747532.1438268882358.JavaMail.yahoo@mail.yahoo.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55BA4C76.7010907@xenomai.org>
Date: Thu, 30 Jul 2015 18:10:30 +0200
MIME-Version: 1.0
In-Reply-To: <599721336.5747532.1438268882358.JavaMail.yahoo@mail.yahoo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai-3.0-rc5 : binding named semaphores from
 external process
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frederik Bayart <frederik_bayart@yahoo.co.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/30/2015 05:08 PM, Frederik Bayart wrote:
>> On Thursday, 30 July 2015, 16:28, Frederik Bayart <frederik_bayart@yahoo.co.uk> wrote:
>>> On 07/29/2015 08:27 PM, Philippe Gerum wrote:
>>>>
>>>> Please merge the commit on top of -rc6 I mentioned this morning, which
>>>> fixes the spurious wake up:
>>>>
>>>> http://git.xenomai.org/xenomai-3.git/commit/?h=next&id=081cbb8b150f30a019245dfb0e2f0b92cc7f2dfd
>>>>
>>>
>>> Actually, I did not mention it, that's why we don't seem to be on the
>>> same page, sorry for this. We should resume the discussion from the
>>> situation obtained with this commit on top of -rc6.
>>
>> I have build a new rc6 kernel & libraries with the new kernel/cobalt/posix/sem.c
>> The rt_sem_p problem is now solved, the first process is not interrupted anymore.
>>
>> I still doesn't see the fuse file system like you do.  I'm looking to other problems (select/connect/send/recv on UNIX domain sockets) so I hope that this is not the cause.
>>
>> I found already that 'select' on  socket(PF_UNIX, SOCK_STREAM, 0)  causes Interrupted system call (errno 4).
>> If I replace 'select' with '__real_select' the problem seems to be solved, and the select timeout works.
>> But the select doesn't seem to react on connect. I'm looking at the problem.
> 
> 
> I just notice that the flood of Interrupted system calls is only cause when build with trank. When build with alchemy, Interrupted system call just happens once.

libtrank is just an overlay on top of libalchemy, only consisting of
fairly simple wrappers. I would suspect a difference in the flags passed
to xeno-config instead.

-- 
Philippe.

