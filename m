Message-ID: <514EF503.9080305@xenomai.org>
Date: Sun, 24 Mar 2013 13:43:47 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1364092805.60885.YahooMailNeo@web161402.mail.bf1.yahoo.com>
In-Reply-To: <1364092805.60885.YahooMailNeo@web161402.mail.bf1.yahoo.com>
Content-Type: text/plain; charset=UTF-8
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
> I create a rt_task in user space program by rt_task_create(), and in
> a kernel module I use use rt_task_inquire to get rt_task_info of this
> task during execution. I notice that rt_task_info:status of this task
> is 0x300180 during its execution, and if I call rt_task_suspend on
> it, the status is 0x300181. So where is the task status value
> defined? I examined nucleus/thread.h, and it seems there are numbers
> like 0x300180 or 0x300181.


Hi,

please configure your mail client to wrap lines.

The function rt_task_inquire is documented in xenomai doxygen
documentation, available here:
http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__task.html#ga53bad6acf5496f8008e594954507dce8

And on your disk after running "make install". From there you should be
able to find the rtask_info::status field documentation.

Regards.


-- 
                                                                Gilles.

