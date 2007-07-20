Message-ID: <46A10CE9.7090603@domain.hid>
Date: Fri, 20 Jul 2007 15:28:41 -0400
From: Vincent Levesque <vleves@domain.hid>
MIME-Version: 1.0
References: <760425846A1BC44B8BD24361EF2E3451A69749@domain.hid>	<1184746976.6562.62.camel@domain.hid>	<760425846A1BC44B8BD24361EF2E3451010D9A3F@square.bfh.ch>	<1184755654.13258.17.camel@domain.hid>
	<469FD346.4060402@domain.hid> <46A06886.5000703@domain.hid>
In-Reply-To: <46A06886.5000703@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Writing from user space direct to
 IO	Ports	without mode switches
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hi Jan,
> Hope that helped to clarify the situation. Now please let us know which
> sentence(s) from the doc may have misled your understanding of the mode
> switching feature. Maybe we have to rephrase them.
>   
I wasn't referring to any part of the docs in particular. If I remember 
correctly, I came across rt_task_set_mode(...) in the API documentation 
and naively assumed that a task could be set to secondary mode when it 
is expected to frequently trigger mode switches (e.g. data logging, 
graphical user interface). Perhaps a short note could be added to the 
function's description to the affect that the T_PRIMARY bit should be 
modified manually only in exceptional cases. Or maybe I'm the only one 
who got confused!

In any case, thank you for these clarifications!

Vincent Levesque
vleves@domain.hid



