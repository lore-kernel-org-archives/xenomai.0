Message-ID: <498C50CC.6060307@domain.hid>
Date: Fri, 06 Feb 2009 16:01:32 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <3FA3B82E3C8A4CAABABE6EBABF2FA4B5@domain.hid>
	<498C4DB1.3010206@domain.hid>
In-Reply-To: <498C4DB1.3010206@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How to check task activation ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Sebastien DI MERCURIO wrote:
>> Hello,
>>  
>> Is there a way to get task scheduling log in xenomai ? Something like a
>> log in /proc/xenomai, telling which task was activated at which time,
>> and then which other task was activated .... would be fine?
>>
> 
> No. You can do it yourself using the task callouts in kernel space (namely
> TSWITCH). If you are running on top of the VxWorks skin, then the taskHookLib is
> available from kernel space. If you are running on top of the native API,
> rt_task_add_hook() is an equivalent. The idea would be to create a small module
> using the native API in kernel space as well, that registers a TSWITCH scheduler
> hook. The hook routine would emit a record via a message pipe (RT_PIPE) for each
> event, which a plain Linux process would collect by reading on the user-space
> end of the pipe.
> 
> Note: this will obviously cause overhead.
> 
> The other option is to either use LTTng or the I-pipe tracer, but you would
> collect a lot of data, aside of the TSWITCH events. YMMV.
> 
>> Other point: is there some kind of monitoring tool (a bit like windriver
>> Windview) working on xenomai ?
> 
> No.

LTTV from the LTTng project can serve as such, though the Xenomai events
are not graphically visualized. It's unclear if we will ever see this
for LTTV as there is now activity towards an Eclipse plugin for LTTng
which will probably be the better place for extensions.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

