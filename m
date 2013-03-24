Message-ID: <514F2A42.3080302@xenomai.org>
Date: Sun, 24 Mar 2013 17:30:58 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1364092805.60885.YahooMailNeo@web161402.mail.bf1.yahoo.com>
In-Reply-To: <1364092805.60885.YahooMailNeo@web161402.mail.bf1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] native task status
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Tom Z <tomz30@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/24/2013 03:40 AM, Tom Z wrote:
> Hi,
>
> I create a rt_task in user space program by rt_task_create(), and in a kernel module I use use rt_task_inquire to get rt_task_info of this task during execution. I notice that rt_task_info:status of this task is 0x300180 during its execution, and if I call rt_task_suspend on it, the status is 0x300181. So where is the task status value defined? I examined nucleus/thread.h, and it seems there are numbers like 0x300180 or 0x300181.
>
>

This status is a bitmask. XNSUSP from include/nucleus/thread.h is set 
when the task is forcibly suspended.

> Thanks,
> Tom
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Philippe.

