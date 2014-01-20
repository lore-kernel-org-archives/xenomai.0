Message-ID: <52DCE706.6070100@xenomai.org>
Date: Mon, 20 Jan 2014 10:06:14 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtc=J2y-ycDASTjSJesA1S+nfJYRt2zyKj9Spzh1m=H_Fg@mail.gmail.com>
In-Reply-To: <CAKKWdtc=J2y-ycDASTjSJesA1S+nfJYRt2zyKj9Spzh1m=H_Fg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] a test for rt_task_bin()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>, xenomai <xenomai@xenomai.org>

On 01/20/2014 08:38 AM, ali hagigat wrote:
> xenomai-2.6.3
> linux-3.5.7
>
> The output seems incorrect

Your code is incorrect. You should pass the routine a pointer to valid 
memory where it can write the task handle back, not any random 
uninitialized pointer.

void task2_body(void *cookie){
- RT_TASK *newtask1;
+ RT_TASK newtask1;
RT_TASK_INFO info1;
int i;

- i = rt_task_bind(newtask1,"xtask1", TM_INFINITE);
+ i = rt_task_bind(&newtask1,"xtask1", TM_INFINITE);

> -------------- next part --------------
> ./examp9
> rt_task_bind() return value = -14
> ret val = -EFAULT
> task name is = xtask2
>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: examp9.c
> Type: text/x-csrc
> Size: 1159 bytes
> Desc: not available
> URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140120/28381566/attachment.c>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Philippe.

