Message-ID: <44F0BBB7.7030703@domain.hid>
Date: Sat, 26 Aug 2006 23:23:03 +0200
From: Steve Kreyer <steve.kreyer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: Timer problems?
References: <1903864415@domain.hid>
	<1154964748.4322.31.camel@domain.hid>	<44EF17E8.5040606@domain.hid>
	<slrneeuefr.v1d.Bernhard.Walle@domain.hid>
In-Reply-To: <slrneeuefr.v1d.Bernhard.Walle@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: steve.kreyer@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bernhard Walle <Bernhard.Walle@domain.hid>
Cc: xenomai@xenomai.org

Hi Bernhard, :)
Bernhard Walle wrote:
> Hello,
>
> first of all: you replied to a previous mail which results in a broken
> thread three in the mail client ... Pleaes create new mail for new
> requests.
> The example you've provided exits immediately here because you don't
> wait in the main() function.
>   
Yes, Iam aware of this, but in fact the waiting via pause or sleep in 
the Linux process (main function)
failed and results in a system lock up.
> I modified your example to work:
> http://pastie.caboo.se/10259
>   
The trick of calling rt_task_join instead of doing a pause is a nice 
idea, but it doesn't solve my problem fully(see below*).
>
> No problem here, for example I call sleep(2) in the RT thread and it
> work. 
It is not my concern to call a standard linux function in the RT task.
> Calling Linux functions in RT code should work in Xenomai,
> although it's not hard realtime safe any more because the thread gets
> switched to the Linux scheduler.
>   
*The reason of my request was to figure out why any of the standard 
linux functions
(e.g. pause, sleep,..., whether called from the linux or RT task) 
results in a system lock up and why the  functions rt_task_wait and
rt_task_sleep, for example, produce the error behaviour described in the 
first mail.

So I think of an timer issue, or a wrong xenomai configuration or 
something like this, but can't really
figure out the problem...
> Just for comparison:
> I'm running Xenomai 2.1 with Kernel 2.6.15.7 on Debian 3.1.
>   
Iam running Xenomai version 2.2 and Kernel 2.6.15 on a kanotix system.
>
> Regards,
>   Bernhard
>
>
>
>   
Thanks for your help and time.

Regards,
Steve

