Message-ID: <4CD57571.3090006@domain.hid>
Date: Sat, 06 Nov 2010 16:34:09 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTimpz6=DWjrKLRoG6O5XGotgQX6FTZR+U2b54awU@mail.gmail.com>	<4CD55D61.7050208@domain.hid>
	<AANLkTimhUUYDkHh6wJ_zL8dLJgCi+7F8kOXrA63LzTO9@domain.hid>
In-Reply-To: <AANLkTimhUUYDkHh6wJ_zL8dLJgCi+7F8kOXrA63LzTO9@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] detect mode switches to primary mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Pastor Sampedro <pastorsa@domain.hid>
Cc: xenomai@xenomai.org

Peter Pastor Sampedro wrote:
> Hey Gilles,
> 
> Thanks for your prompt response !
> 
>> If you have a borderline thread sharing memory with a primary-mode only
>> thread, you are supposed to protect the accesses to the shared memory
>> with a mutex, then the borderline thread will automatically switch to
>> primary mode when it acquires the mutex. When it gets out of this
>> critical section and it calls a function which requires running in
>> secondary mode, then it will switch automatically to secondary mode.
> 
> That is exactly what I am doing. However, since I am linking my
> program against the posix skin, I may call some posix function in the
> non-real-time part of the boarder line thread which cause my thread to
> switch back to primary mode... which is exactly what I don't want it
> to do.
> 
> Anyways, thanks for letting me know that there is no clean way to see
> when/where mode switches from secondary to primary modes happen.

Posix function calls which cause this thread to switch to primary mode
require this to work correctly. So, you can not call them and hope to
remain in secondary mode. As explained here:
http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Compilation_flags.

Linking the application to Xenomai posix skin is not sufficient to have
this application use Xenomai services. The --wrap mechanism does this.
So, if you want to be sure to use Linux service instead of Xenomai
service, you should use the __real prefix.

In short, I do not understand what you are trying to do.

What about sending a small piece of code to explain it?
-- 
                                                                Gilles.

