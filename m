Message-ID: <4FD2EB49.1030105@xenomai.org>
Date: Sat, 09 Jun 2012 08:20:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAGTNcBt+DrdbxnewSxFi3gJjnHKrgE_rB8OJaRvMQWe8uX8ORg@mail.gmail.com>
	<CAGTNcBsrjvd_bWx1YN=aeXgiC1B3o+Y_bsW732y=B0xnaqPkVw@mail.gmail.com>
In-Reply-To: <CAGTNcBsrjvd_bWx1YN=aeXgiC1B3o+Y_bsW732y=B0xnaqPkVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] I-pipe 2.6.38.8-x86-2.11-02 reports illicit call from
 domain Xenomai (on x86 32-bit)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Josh Bowman <jbowman@facts-inc.com>
Cc: xenomai@xenomai.org

On 06/09/2012 03:42 AM, Josh Bowman wrote:
> Hi,
> 
> Sorry about the horrible formatting on that. Hoping this is
> easier to read:
> 
> I'm trying to update our systems to use a new kernel and
> Xenomai 2.6.0, with ipipe 2.6.38.8-x86-2.11-02. (Previously,
> I've tested 2.5.6 with ipipe 2.6.37-x86-2.9.00; there was no
> ipipe log with that version.)
> 
> Everything seems to be running fine, but I get an error
> message and a call trace in the kernel logs. The message
> is "I-pipe: Detected illicit call from domain 'Xenomai'".
> This happens pretty much as soon as our first Xenomai
> tasks start running, and it doesn't appear to be hurting
> anything.
> 
> The tasks mentioned in the tracer log are both low-priority
> native-skin tasks that use Xenomai services to communicate
> with our realtime tasks, but also use Linux services.  The
> configClient task uses rt_mutex and condition variables to
> receive requests from another Xenomai task in the same
> process. Its job is to talk on a tcp socket with a java
> server. It expects to go into secondary mode when doing that,
>  and is careful not to hold the rt_mutex when blocking. (But
> I mention that, because I'm not sure if the ipipe message
> could be caused by a mistake of that sort in userspace.)
> 
> configClient sometimes also sends rt_queue messages to the
> loggingTask, which is also mentioned in the tracer log. (It
> looks like the loggingTask had recently received a message
> from somewhere, but I don't understand the trace well enough
> to say for certain whether that message came from the
> configClient.) When loggingTask receives a message, it will
> write() it to disk; again, it expects to go to secondary
> mode for that.
> 
> We're building Xenomai for 32-bit x86, with --enable-x86-sep
> and CFLAGS="-fno-omit-frame-pointer".
> 
> The trace follows.

Could you try disabling kgdb support in kernel configuration?

-- 
                                                                Gilles.

