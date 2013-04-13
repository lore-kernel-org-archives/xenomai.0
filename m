Message-ID: <5169C63B.1070406@xenomai.org>
Date: Sat, 13 Apr 2013 22:55:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPpP=rPQa-Fa+1j7Lb11dUX8srkinCQQ2yS2gR5y9f9Pqf1jdg@mail.gmail.com>	<516998B7.9090901@xenomai.org>
	<CAPpP=rOEjuy8w0x-_zRv_7vHDOmjU6n1Hi=jrE6UNEULL=zYcQ@mail.gmail.com>
In-Reply-To: <CAPpP=rOEjuy8w0x-_zRv_7vHDOmjU6n1Hi=jrE6UNEULL=zYcQ@mail.gmail.com>
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

On 04/13/2013 08:20 PM, alex alex wrote:

> I hope this is more clear like this.


We definitely do not have information. As usual, we do not know what
version of Xenomai you are using, on what platform, how your kernel is
configured.

/*
 * When case 1 is activated we see (with the dmesg command) :
 *
[  796.318290] HOOK: 107212ns - NAME "ROOT/0"
[  796.321501] HOOK: 3322158ns - NAME "hook"        <- task creation
(primary mode)
[  796.321512] HOOK: 3335024ns - NAME "ROOT/0"      <- immediate switch
in secondary mode and do cpu load (why this switch?)

1- a switch from "hook" to "ROOT" thread does not necessarily mean a
switch to secondary mode. It also happens if "hook" suspends, of if ROOT
preempts hook.
2- a switch to "hook" does not necessarily mean that the task startup is
done, if you have a look at the thread startup code, you will see that
has several steps, switching back and forth between the creator task and
the created task.
3- if it is indeed a switch to secondary mode, you can have a look at
examples/sigdebug.c to see how to find the reason for a secondary mode
switch.


[  796.526870] HOOK: 208957565ns - NAME "ROOT/0"
[  796.526927] HOOK: 209017235ns - NAME "ROOT/0"
[  797.525640] HOOK: 1209016502ns - NAME "hook"     <- the task is deleted
[  797.525642] HOOK: 1209020993ns - NAME "ROOT/0"
 *
 * case 2 : with the sleep function
 *
 1093.722850] HOOK: 109993ns - NAME "ROOT/0"
[ 1093.726044] HOOK: 3307528ns - NAME "hook"        <- task creation
(primary mode)
[ 1093.726056] HOOK: 3321275ns - NAME "ROOT/0"
[ 1093.931404] HOOK: 3350018ns - NAME "ROOT/0"
[ 1093.931405] HOOK: 3351297ns - NAME "hook"        <- after the sleep.
The sleep seems to force the task to remain in primary mode during the
cpu load.

I do not think nanosleep(0) suspends the calling task.


[ 1093.931406] HOOK: 208932507ns - NAME "ROOT/0"
[ 1093.931469] HOOK: 209001818ns - NAME "ROOT/0"
[ 1094.930182] HOOK: 1209000982ns - NAME "hook"     <- the task is deleted
[ 1094.930184] HOOK: 1209005156ns - NAME "ROOT/0"
 *
 * case 3 : with the pthread_set_mode_np
 *
[ 1455.427711] HOOK: 123409ns - NAME "ROOT/0"
[ 1455.430896] HOOK: 3311532ns - NAME "hook"      <- task creation
(primary mode)
[ 1455.430908] HOOK: 3325521ns - NAME "ROOT/0"    <- immediate switch in
secondary mode and do cpu load while pthread_set_mode_np
should force the task to remain in primary mode?

Again, how do you see this a switch to secondary mode? The three
sequences look the same to me, I do not see how do you get all these
interpretations.

[ 1455.636262] HOOK: 208942671ns - NAME "ROOT/0"
[ 1455.636331] HOOK: 209015748ns - NAME "ROOT/0"
[ 1456.635043] HOOK: 1209014877ns - NAME "hook"   <- the task is deleted
[ 1456.635045] HOOK: 1209019259ns - NAME "ROOT/0"



-- 
                                                                Gilles.

