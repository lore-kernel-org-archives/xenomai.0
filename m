Message-ID: <4D79E28B.3090004@domain.hid>
Date: Fri, 11 Mar 2011 09:51:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D79DD32.4050307@domain.hid>
In-Reply-To: <4D79DD32.4050307@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_delete trouble
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: johann.obermayr@domain.hid
Cc: xenomai@xenomai.org

Johann Obermayr wrote:
> void task_waiter_do(void *data)
> {
>      rt_printf("task_waiter_do started\n");
>      while(task_waiter_flag == 0)
>          ; // rt_task_sleep( DELAYMS(1) );
>      rt_printf("task_waiter_do finished\n");
> }

What happens if you uncomment the rt_task_sleep here ?

Could you please give us some more information:
http://www.xenomai.org/index.php/Request_for_information

Do you have priority coupling enabled?

-- 
					    Gilles.

