Message-ID: <516BC4DF.3030302@xenomai.org>
Date: Mon, 15 Apr 2013 11:14:07 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAPpP=rPQa-Fa+1j7Lb11dUX8srkinCQQ2yS2gR5y9f9Pqf1jdg@mail.gmail.com>
	<516998B7.9090901@xenomai.org>
	<CAPpP=rOEjuy8w0x-_zRv_7vHDOmjU6n1Hi=jrE6UNEULL=zYcQ@mail.gmail.com>
	<5169C63B.1070406@xenomai.org>
	<CAPpP=rMOmOkd2Gwswu685zsPhxJDMj7GnRWA0yU+gRHmz=V2bw@mail.gmail.com>
	<5169EC2C.4000101@xenomai.org>
	<CAPpP=rNCBdcussSRzHN_Vpjj0afWZRGKRqPXxh7ps2-_GP7nBQ@mail.gmail.com>
In-Reply-To: <CAPpP=rNCBdcussSRzHN_Vpjj0afWZRGKRqPXxh7ps2-_GP7nBQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 04/15/2013 10:47 AM, alex alex wrote:
>> There are simple ways in the application itself, you do not need a
>> kernel module and a switch hook.
>
> The reason I use a switch hook is to retrieve informations about context
> switches to produce a Gantt chart of the sechuleur. But maybe hook
> functions are
> not suitable for this?


Yes, they are, but you should have introduced you mail topic mentioning 
your goal first. The ipipe tracer won't help you in this case.

You should be able to achieve this goal by interposing on the three 
hooks, possibly sending the collected data through a message pipe or 
XDDP socket to a userland app for post-processing.

Hints, for Xenomai 2.6 (-forge works differently):

- scheduler hooks are executed with core lock held, interrupts off: do 
not spend too much time there, or the timings would be affected too much.

- in the SWITCH hook, the following code would tell you whether you are 
looking at a regular linux thread, at a relaxed shadow thread, or at a 
Xenomai thread running in real-time mode, either in userland or kernel 
space:

struct xnthread *me, *t;

me = xnpod_current_thread(); /* this is fine, we are nklock-ed, irqs off */

if (xnthread_test_state(me, XNROOT)) {
	t = xnshadow_thread(current);
	if (t) {
		/* current is shadowed, t is Xenomai's mate, relaxed */
	} else {
		/* current is a regular linux task, no Xenomai shadow */
	}
} else if (xnthread_test_state(me, XNSHADOW)) {
	/* me is a user-space shadow in real-time mode. */
} else {
	/* me is a kernel-based Xenomai thread (always real-time). */
}

-- 
Philippe.

