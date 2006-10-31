Message-ID: <45473968.2070906@domain.hid>
Date: Tue, 31 Oct 2006 12:54:16 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Maximum number of realtime tasks
References: <DD39B5C3F4963040ADC9768BE7E430CB0144D60E@is-hdq-exchange.marel.net>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB0144D60E@is-hdq-exchange.marel.net>
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
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

Daniel Schnell wrote:
> Gilles Chanteperdrix wrote:
> 
>>Pay attention to the stack size of the user-space tasks: the default
>>of 8 Megabytes will exhaust your RAM rapidly. So, you should either :
>>- set the default stack size with ulimit;
>>- or set the the stack size of the created threads, but in this case
>>the main thread will have an 8 Megabytes stack. 
>>
>>In order to set the stack size of a thread, use
>>pthread_attr_setstacksize if using the POSIX skin or the stksize
>>parameter of rt_task_create if using the native skin.  
> 
> 
> If I set the stacksize generally via ulimit -s and additionally via the
> pthread_attr_setstacksize() how is the precedence of one of these calls
> over the other ? Does pthread_attr_setstacksize

Setting the stack size with pthread_attr_setstacksize seems to allow a
stack greater than the limit fixed by ulimit, but I do not think it is
wise to rely on such a behaviour.

-- 
                                                  Gilles Chanteperdrix

