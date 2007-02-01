Message-ID: <45C1EA10.9060109@domain.hid>
Date: Thu, 01 Feb 2007 14:24:32 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rt_task_create() hangs ?
References: <45B75FFB.6030205@domain.hid> <45C1E625.1010600@domain.hid>
In-Reply-To: <45C1E625.1010600@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Steven Scholz <steven.scholz@domain.hid>
Cc: xenomai@xenomai.org

Steven Scholz wrote:
> Hi all,
> 
> I wrote:
> 
> 
>>On our AT91RM9200 (adeos-ipipe-2.6.14-arm-1.5-04,
>>ipipe-2.6.14-at91-1.5-04.patch) a simple application (that just creates and
>>destroys two threads)
>>
>>	rt_task_create(&task_1,"task_1",0,50,0);
>>	rt_task_create(&task_2,"task_2",0,51,0);
>>	...
>>	rt_task_delete(&task_2);
>>	rt_task_delete(&task_1);
>>
>>runs fine when started for the first time. But when started again it hangs
>>in the rt_task_create() for the second task.
>>Funny enough it all runs fine when we first delete task1 and then task2 ...
>>
>>On an x86 (adeos-ipipe-2.6.19-i386-1.6-03) the application runs fine. Either
>>way.
>>
>>We noticed that on the AT91RM9200 we don't see the
>>
>>Xenomai: POSIX: destroyed thread c14a0320
>>
>>message. Not even when running (and stopping) cyclictest. I suspect that
>>this is leading to our problems.
> 
> 
> I now tested Gille's brand new adeos-ipipe-2.6.19-arm-1.6-01.patch. The
> above problems disapeared. I even do see a "Xenomai: POSIX: destroyed
> thread" now.
> 
> So is this a known bug of ipipe-1.5 vs ipipe-1.6?
> Or does anyone remember a bug like that?

I do not think there is such a known bug. There were some recent fixes
in the native skin, but as far as I remember they were for anonymous
objects. In any case, as Philippe already told you, it is hard to say
anything without seeing any code. As for the posix skin messages about
objects destruction, they only appear if an option is selected in the
kernel configuration. Are you sure this option was enabled when you did
not see the messages ?

-- 
                                                 Gilles Chanteperdrix

