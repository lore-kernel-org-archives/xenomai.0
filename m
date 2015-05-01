Message-ID: <5543AFEB.2070808@xenomai.org>
Date: Fri, 01 May 2015 18:55:07 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAMJ=MEceJGYZ+RQ4eW9vnvfM=iLNTUv7sN0ePij4aEbegdAM+w@mail.gmail.com>
 <5541FD72.3090806@xenomai.org>
 <CAMJ=MEcq-VE-QK021_RigRUVbbXOtKwL4G27bhtP=y+hX3eE6w@mail.gmail.com>
 <5542299B.30409@xenomai.org>
 <CAMJ=MEcC11C1Th6NjWMH6Ld3NthFvWpcSY+5tZAbk_akc6hS5g@mail.gmail.com>
In-Reply-To: <CAMJ=MEcC11C1Th6NjWMH6Ld3NthFvWpcSY+5tZAbk_akc6hS5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [xenomai-forge] Task blocked in t_delete
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>
Cc: "martin.bielik.sk" <martin.bielik.sk@gmail.com>, xenomai@xenomai.org

On 04/30/2015 03:55 PM, Ronny Meeus wrote:
> On Thu, Apr 30, 2015 at 3:09 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>> On 04/30/2015 02:39 PM, Ronny Meeus wrote:
>>> If I run the test I see:
>>>
>>> /tmp # ./task_delete
>>> Start of test
>>> Create and start main task:Create task M:
>>> Create task L:
>>> Start task M:
>>> Start task L:
>>> M: entry
>>> L: entry
>>> M: Dead loop starts
>>> Cleaning ..
>>> End of test
>>>
>>> Here is the piece of the code that goes wrong:
>>>
>>>   printf("Cleaning ..\r\n");
>>>   /* Remove tasks */
>>>   t_delete(L_id);
>>>   /* Followed code is not executed because t_delete is somehow blocked */
>>>   printf("Removed L task id = 0x%lx\r\n", L_id);
>>>   t_delete(M_id);
>>>   printf("Removed M task id = 0x%lx\r\n", M_id);
>>> }
>>>
>>> Since the trace "Removed L task id..." is not generated, my assumption
>>> it that the t_delete(L_id) blocks.
>>>
>>>
>>
>> Could you attach GDB to the hung process, then dump a backtrace for all
>> the remaining threads?
>>
>> --
>> Philippe.
> 
> Philippe
> 
> I have put a breakpoint in main @ line 62:
> 
> 57        printf("Create and start main task:");
> 58        t_create("MaIn",10, 16000, 16000,0,&tid);
> 59        ret = t_start(tid, 0, main_task, NULL);
> 60        if (0 != ret) {printf("Failed %lu\r\n",ret);return -1;}
> 61        sleep(10);
> 62        t_delete(tid);
> 63        printf("End of test\n\r");
> 64        return 0;
> 
> and I generated a backtrace for all threads, see below.
> It looks like the "MaIn" task is wating on a semaphore.

[snip]

This is a priority inversion issue caused by the handshake mechanism
between the caller of t_delete() and the killed task finalizer. I
eventually reproduced it after I figured out that pinning all tasks on
the same CPU was required to trigger such bug. This patch should help:

http://git.xenomai.org/xenomai-3.git/commit/?h=next&id=8431d7149405235fb0aebb53ed32a537ad968c7e

-- 
Philippe.

