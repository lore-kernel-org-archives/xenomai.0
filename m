Message-ID: <5169E517.9060707@xenomai.org>
Date: Sun, 14 Apr 2013 01:07:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPpP=rPQa-Fa+1j7Lb11dUX8srkinCQQ2yS2gR5y9f9Pqf1jdg@mail.gmail.com>	<516998B7.9090901@xenomai.org>	<CAPpP=rOEjuy8w0x-_zRv_7vHDOmjU6n1Hi=jrE6UNEULL=zYcQ@mail.gmail.com>	<5169C63B.1070406@xenomai.org>	<CAPpP=rMOmOkd2Gwswu685zsPhxJDMj7GnRWA0yU+gRHmz=V2bw@mail.gmail.com>
	<5169E4AB.9030808@xenomai.org>
In-Reply-To: <5169E4AB.9030808@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [QUESTION] thread creation and hook function
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: alex alex <duch.alexandre@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 04/14/2013 01:05 AM, Gilles Chanteperdrix wrote:

> On 04/14/2013 12:41 AM, alex alex wrote:
> 
>> linux kernel : 3.2.21
>> xenomai version : 2.6.2.1
>> arch: x86
> 
>>
> 
>> In fact, I base on the cookie of the "rt_task_add_hook" function to
>> retrieve the descriptor address of the task which has been switched or
>> started.
>> And I guess that if the returned name is ROOT it's means that either the
>> task is switched to secondary mode or it's another linux task and if the
>> retuned name isn't ROOT it mean that it's a task in the xenomai scheduler.
> 
> 
> Yes, but as I told you ROOT does not necessarily means that a real-time
> thread is running in secondary mode.
> 
> Also, as I also told you, if you want why a thread switches to secondary
> mode, see examples/sigdebug.c
> 
> I do not intend to run your example and understand what it does. The way
> you try to understand what happens is too indirect and convoluted.
> 
> There are simple ways in the application itself, you do not need a
> kernel module and a switch hook.


The most exhaustive way being the I-pipe tracer:
http://www.xenomai.org/index.php/I-pipe:Tracer


-- 
                                                                Gilles.

