Message-ID: <45476F15.6050706@domain.hid>
Date: Tue, 31 Oct 2006 16:43:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Maximum number of realtime tasks
References: <DD39B5C3F4963040ADC9768BE7E430CB0144D632@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB0144D632@domain.hid>
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
> 
>>Setting the stack size with pthread_attr_setstacksize seems to allow
>>a stack greater than the limit fixed by ulimit, but I do not think it
>>is wise to rely on such a behaviour.  
> 
> 
> If one wants to have always the same stack size for every thread than
> ulimit -s would be probably the way to go. But often in Realtime
> applications it is the preferred way of setting  the stack size
> individually, so one doesn't waste too much memory. A mixture of both
> seems to be tempting: setting a general stack size and individually
> change it. So why not rely on this ? Which part in the system actually
> creates the stack for a Xenomai task and how is the interaction between
> Linux and Xenomai to derive the general system wide stack limit to a
> Xenomai task ?

The way I understand ulimit (or the setrlimit syscall), it should be
used to set a maximum limit, so the fact that pthread_attr_setstacksize
allow to bypass this limit may be a bug that may be corrected one day.
So, I repeat, I would not rely on this behaviour.

> 
> Is there a way to find out, which thread has which stack size ?

Each thread stack is set up as a mapping in /proc/pid/maps, so if you
know one address on each stack, you may find out which thread has
which stack. Ok, it is not easy, but I know no other way.

-- 
                                                  Gilles Chanteperdrix

