References: <9BA84827B30CBE4996725F98F7DC9123654093C7@SMExchange01.siebmeyer.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <8d9d1cba-0bbb-abf7-2826-9d724ddc4ee1@xenomai.org>
Date: Tue, 9 May 2017 14:52:03 +0200
MIME-Version: 1.0
In-Reply-To: <9BA84827B30CBE4996725F98F7DC9123654093C7@SMExchange01.siebmeyer.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] delete a suspend rt_task xeno2<>xeno3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?H=c3=a4nel-Baas=2c_Alexander?= <alexander.haenel-baas@sieb-meyer.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/09/2017 01:53 PM, Hänel-Baas, Alexander wrote:
> Hi,
> i'm porting our application from Xeno2 (linux 3.14) to Xeno3(Linux 4.4).
> 
> Under Xeno3:
> When I delete a suspend task, the suspend task will begin to run.
> Under Xeno2 :
> The suspend task is deleted successfully, without that the suspend thread will begin to run.
>  
> Example
> rt_thread
>    for(;;){
>        rt_task_suspend(NULL);
>       printf("in loop\n");
>    }
> main:
> rt_task_spawn()
> . other stuff
> rt_task_delete()
> 
> So, in Xenomai 2 i have never seen the string "in loop" when we delete the task, but under Xenomai 3
> after the rt_task_delete() call, i get many "in loop" messages.
> 
> I notice the return value from rt_task_suspend is "operation not permitted", because i
> have delete successful the task descriptor with rt_task_delete(). 
> Right?
> Or is there a mistake in my Xenomai installation?
> 
> When this point is different to xenomai2 comes here my problem:
> This was only a test example. 
> In the real application the rt_task_suspend() call came from another task, and not directly from rt_thread loop self.
> And so rt_task_suspend() is called at the right time, return "successfully" and the rt_thrad stops fine. 
> Now, when we  want shut down the application we calling rt_task_delete(), and then the rt_thread begins to run
> and we can't delete it. 
> 
> What can I do to delete a suspend rt_task without the task will running in the loop, because the task descriptor was going invalid from delete() call?
> 
> 

Please provide a short and complete test code illustrating the issue,
and what you want to achieve.

-- 
Philippe.

