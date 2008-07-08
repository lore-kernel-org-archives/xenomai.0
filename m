Message-ID: <4873C578.4030107@domain.hid>
Date: Tue, 08 Jul 2008 21:52:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4873C2EE.5050400@domain.hid>
In-Reply-To: <4873C2EE.5050400@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_timer_read() value
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Antoine Nourry <nourry@domain.hid>
Cc: xenomai@xenomai.org

Antoine Nourry wrote:
>> rt_timer_read value should never be decreasing, except maybe from time
>> to time when an overflow takes place. A decreasing clock would really be
>> something unatural to work with. Overflow may take place more often if you
>> cast the return value of rt_timer_read to 32 bits: it is a 64 bits
>> value, and I would not expect it to overflow before years of uptime.
>> So, there is probably something wrong with your program. Have you
>> included native/timer.h ? Do you store the result of rt_timer_read in a
>> 64 bits variable ?
> yes and no, the worst is that i was focused on the trivial periodic 
> example where time is casted to long type. I think i had tried with long 
> double, which type do you typically use for this value ?

RTIME, documented as the return type of rt_timer_read.

>> The only function which you can call without breaking real-time are
>> those documented as such in Xenomai native skin (or posix skin, for that
>> matter) documentation. Everything else needs careful inspection.
>> Everything that uses Linux system calls, such as for instance, functions
>> accessing non real-time drivers such as a keyboard driver, will break
>> real-time. The only functions that have a chance not to break real-time
>> are those which do not use system calls (and do not call functions which
>> use system calls), the function "sin" comes to my mind as an example of
>> such a function.
> Another thing, as timer is running in parallel to every tasks, would it 
> be possible to measure time elapsed from the moment picture appears
> to the keypress event ? If i can't be sure to benefit from very low 
> latency during all this period, can i rely on this ns-scale timer to 
> inform me on how much time elapsed in each functions, in order to deduct 
> it from my raw reaction time ? I have another time reaction program but 
> its time pace is too high for high accuracy...
> How would you resolve this problem and is real-time really the answer ?

Since the two actions you want to time are non real-time, you should
probably better use linux services, such as gettimeofday.

-- 


					    Gilles.

