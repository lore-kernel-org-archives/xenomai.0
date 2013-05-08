Message-ID: <518ABA3D.5070106@xenomai.org>
Date: Wed, 08 May 2013 22:49:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPpP=rOMJi4u7sm9+a79aJ2GhhtJY7B5QD0+tVxsN7KoFMqxCw@mail.gmail.com>	<518A5F0C.50403@xenomai.org>
	<CAPpP=rNt32NFsF5LhJybpcBRfm33za8kP2tQj+t4Vs9-hkH48w@mail.gmail.com>
In-Reply-To: <CAPpP=rNt32NFsF5LhJybpcBRfm33za8kP2tQj+t4Vs9-hkH48w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Posix] I/O multiplexing with select
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

On 05/08/2013 10:34 PM, alex alex wrote:

>> You do not want to work around the problem, you want to fix it. There
>> is probably some bit missing somewhere to get the thread control block
>> destroyed when a detached thread dies.
> 
> Yes, one variable was not freed...
> 
>> Yes, I have already done that, and tried and describe it in the
>> following text:
>>
>> http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#I.2FO_>multiplexing_with_select<http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#I.2FO_multiplexing_with_select>
>>
>> The posix binding for Xenomai real-time pipes has been created in the
>> mean-time: it is the xddp sockets.
> 
> If I well understand, your reimplemented select calls a function that
> communicates with a thread dealing with linux files descriptors through the
> XDDP protocol.


No, I used select() in a thread running in primary mode, and
__real_select() in a thread running with the SCHED_OTHER policy, so most
of the time in secondary mode. Every time __real_select returned an
event for a plain Linux file descriptor which was relevant for the
thread running in primary mode, a message was sent to it through a posix
message queue, which descriptor was included in the set of file
descriptors passed to the select() call.

The XDDP socket would be used the other way around: to wake up the
thread blocked in __real_select and inform it of some event detected by
the thread running in primary mode, but I never had to implement that.

I never tried to hide this behaviour behind a higher level "select", as
I wanted the thread calling the select() service to stay in primary
mode, and processing some events on linux file descriptors required
services to be run in secondary mode, so, the two loops had to be kept
separate, and I believe in fact it is always the case.

-- 
                                                                Gilles.

