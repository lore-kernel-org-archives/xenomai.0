Message-ID: <44509C68.8020808@domain.hid>
Date: Thu, 27 Apr 2006 12:26:48 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_task_slice() Behaviour
References: <5B122FD931231D408AC32630D1B1F7290AF754C6@domain.hid>
In-Reply-To: <5B122FD931231D408AC32630D1B1F7290AF754C6@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Thomas, Brieuc (GE Healthcare)" <Brieuc.Thomas@domain.hid>
Cc: xenomai@xenomai.org

Thomas, Brieuc (GE Healthcare) wrote:
> Hello,
> 
>  
> 
> I read everywhere than Xenomai scheduler supports round-robin policies, 
> but I don't find any explanation or example about how to manage it.
> 
> I used a Native API, my configuration is: 
> status=periodic:setup=202:tickval=1000000:..
> 
> And I would like to have a RR behaviour with a time slice to 10ms, and 
> the only function than I found to do that is "rt_task_slice(&task, 10)" 
> : but there is no behaviour change.
> 
> I tried to use xnpod_activate_rr, but I can't include pod.h without any 
> errors. I think it's a stupid question but what I forget to do?
> 
>  
> 

rt_task_set_mode(0,T_RRB,NULL) from the task that wants to undergo the 
RR scheduling, after having called rt_task_slice to setup the time credit.

-- 

Philippe.

