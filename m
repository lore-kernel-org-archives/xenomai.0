Message-ID: <4A26FFE3.7070009@domain.hid>
Date: Thu, 04 Jun 2009 00:57:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <f253850f0906030943g2a2d4474p35213e712cadba8@domain.hid>
	<4A26B6E7.9060201@domain.hid>
In-Reply-To: <4A26B6E7.9060201@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] turn an rt_task back to linux user space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Pedro Queiros <pqueiros@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Pedro Queiros wrote:
>> Hi,
>> I would like to know if the is any way to turn a xenomai task, which
>> was shadowed from a linux thread with the rt_task_shadow(), back to
>> the linux user space (kill the rt_task and continue the linux thread
>> execution after that).
>> I tried the function rt_task_delete() but it ends the rt_task and
>> exits the linux thread without returning to Linux user space.
> 
> In theory, it would be possible, however it has not been implemented and
> is not an easy task, and is not in an urgent position on the todo list.
> So, in short, you will have to find another way (you can for instance,
> pthread_create a new thread from the real-time task context, right
> before it dies, the new thread doing the task you wanted to do after
> killing it).

You can also set the priority of the rt task to 0, this will give it a
lower priority than any other real-time task, and may achieve what you
are looking for.

-- 
					    Gilles.

