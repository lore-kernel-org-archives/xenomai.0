Message-ID: <4522849E.7070409@domain.hid>
Date: Tue, 03 Oct 2006 10:41:18 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] POSIX skin and dynamic libs
References: <J6JVAS$C4CF17214301337F8F99C4C608155EE6@domain.hid>
In-Reply-To: <J6JVAS$C4CF17214301337F8F99C4C608155EE6@domain.hid>
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
To: xenomai-help <xenomai@xenomai.org>

gilles.chanteperdrix wrote:
>> I have a main program that dynamically loads shared library
>> modules using dlopen().  I would like to create a shared
>> library module that is able to spawn a Xenomai RT thread.
>>  This seems  like it should be possible, but I get the
>> following error when loading the module:
>>
>> IOError: /usr/xenomai/lib/libpthread_rt.so.0: undefined symbol:
>> __real_pthread_getschedparam
> 
> The wrapper for __real_pthread_getschedparam is missing in
> src/skins/posix/wrappers.c, try adding it.

That works.  Thanks, again!

-Jeff


