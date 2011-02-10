Message-ID: <4D540EC9.8060009@domain.hid>
Date: Thu, 10 Feb 2011 17:14:01 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7679056.61297351216093.JavaMail.SYSTEM@pc-msalvini>
In-Reply-To: <7679056.61297351216093.JavaMail.SYSTEM@pc-msalvini>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problems with rt_task_create and rt_task_join
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mauro Salvini <mauro.salvini@domain.hid>
Cc: xenomai@xenomai.org

Mauro Salvini wrote:
> Hello to all, finally I found a bug into my code which is not related
> with join functions. Now all works fine. Thank you for support (and
> tolerate) me!
> 
> I have one just one last question (another!) to you: I create a
> pthread with joinable attribute, and then I transform it in a
> realtime ask with rt_task_shadow().
> When I join this task I must call
> pthread_join(), because rt_task_join() generates a segmentation fault
> (in the point where latter function internally calls pthread_join()).
>  Is this behaviour correct?

Well, looking at the code, this should not happen. The question is: how
do you ensure, in the code that calls rt_task_join, that the thread
being created had the time to call rt_task_shadow? In other words, are
you sure that you are not passing rt_task_join an uninitialized RT_TASK?

So, as usual, we are missing a simple standalone test showing the issue
you have.

-- 
					    Gilles.

