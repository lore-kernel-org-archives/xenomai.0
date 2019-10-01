Subject: Re: rt_task_create returns EEXIST on restart a task
References: <trinity-6d62c670-77a5-4657-bd6f-23e37c37af06-1569911626962@3c-app-webde-bap28>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <73e6846e-8095-6655-57ff-97ef29343b78@siemens.com>
Date: Tue, 1 Oct 2019 08:42:07 +0200
MIME-Version: 1.0
In-Reply-To: <trinity-6d62c670-77a5-4657-bd6f-23e37c37af06-1569911626962@3c-app-webde-bap28>
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
To: Sascha-Carsten Wedler <FXMaveric@web.de>, xenomai@xenomai.org

On 01.10.19 08:33, Sascha-Carsten Wedler via Xenomai wrote:
>     Hello,
> 
>     I have a task, which I create in this way:
> 
>     string _name = "Task1";
>     rt_task_create(&RT_TaskHandle, _name.c_str(), 0, _Prio,0);
>     ....
>     later i stop the task
>     rt_task_delete(&RT_TaskHandle);
>     (returns zero)
> 
>     if I try to restart the task using
>     rt_task_create(&RT_TaskHandle, _name.c_str(), 0, _Prio,0);
>     it returns -EEXIST.
> 
>     rt_task_start will work anyway for this task and restart it anyway....
> 
>     So I assume that the name is still registered. It is a normal bevahiour
>     that the name will not be de-registered and
>     i cannot use the same name to reschedule the task?
> 
>     Or have i a  missunderstanding in general?
> 

Conceptually, this should work.

Which version are you on, which variant (cobalt, mercurial)?  Does a memset on 
RT_TaskHandle after the delete change the picture? Or do you need to use a 
different name for the task?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

