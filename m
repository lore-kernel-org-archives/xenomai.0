Message-ID: <516998B7.9090901@xenomai.org>
Date: Sat, 13 Apr 2013 19:41:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPpP=rPQa-Fa+1j7Lb11dUX8srkinCQQ2yS2gR5y9f9Pqf1jdg@mail.gmail.com>
In-Reply-To: <CAPpP=rPQa-Fa+1j7Lb11dUX8srkinCQQ2yS2gR5y9f9Pqf1jdg@mail.gmail.com>
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

On 04/13/2013 06:58 PM, alex alex wrote:

> Hi all,
> 
> I made a simple debugging program with the hook native functions and I
> see something
> I do not understand...
> 
> This program create 1 thread who loads the CPU for some time.
> 
> case 1 - Looking at the kernel log, we can see that the task is created in the
> primary mode then immediatly switch to the secondary (it's the root linux
> task who loads the cpu).
> 
> I made 2 others tests:
> case 2 - When I release the context with a rt sleep function, we see that the
> task remains in the primary mode during the CPU load.
> 
> case 3 - I try to use "pthread_set_mode_np(0, PTHREAD_PRIMARY)" to force
> the task to remain in primary mode but I see that it's still the root task
> who loads the cpu.
> 
> I would appreciate if someone could clear my head about this behavior.


Well, to explain the behaviour, we would have to understand the
behaviour. Could you add comment in the code to explain what you do not
understand?

-- 
                                                                Gilles.

