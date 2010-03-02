Message-ID: <4B8D535A.10209@domain.hid>
Date: Tue, 02 Mar 2010 19:05:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B8D0EEA.3090409@domain.hid> <4B8D10C5.9050108@domain.hid>
	<4B8D156F.7000604@domain.hid>
In-Reply-To: <4B8D156F.7000604@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Which process synchronization primitive?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

Daniele Nicolodi wrote:
> Gilles Chanteperdrix wrote:
>>> I think message queues can work well but I'm not sure they are the best
>>> choice when I do not have to communicate any message. Would be
>>> semaphores best suited to my needs?
>> You can use process-shared mutexes or semaphores.
> 
> There is somewhere a comparison of the overhead of the different
> solutions? Do I need to do my own benchmarks? Is the API the only
> difference?

Mutexes have the lowest overhead, since they can be handled in
user-space starting with the 2.5 branch.

Differences betwenn mutexes and semaphores are the same with Xenomai
than with any other known API: mutexes are binary semaphores with a
notion of ownership.

> 
>> But there is something
>> which must be said clearly: compiling or not with Xenomai support is all
>> or nothing. Either you build all the applications with Xenomai posix
>> support or none of them. There is no way you can synchronize a real-time
>> thread with a non real-time thread without loosing determinism.
> 
> I understood this reading the documentation (and it is fairly
> intuitive). I would like to use the posix skin to be able to compile my
> application also on an host without xenomai support (and of course give
> up the real time capability).
> 
>> And
>> beware of the kind of priority inversions which would result from
>> calling a Linux system call while holding a mutex shared with real-time
>> processes, as explained here:
>>
>> http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Chasing_the_unwanted_mode_switches.
> 
> I was just reading this.
> 
> Thanks! Cheers,


-- 
					    Gilles.

