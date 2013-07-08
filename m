Message-ID: <51DAC0A9.1010709@xenomai.org>
Date: Mon, 08 Jul 2013 15:37:45 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CE260BFE-CB8F-45DC-A46D-8CFE585069EC@mah.priv.at>
In-Reply-To: <CE260BFE-CB8F-45DC-A46D-8CFE585069EC@mah.priv.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] q on rt_task_self() and mode switching
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/08/2013 03:23 PM, Michael Haberler wrote:
> if a userland RT thread gets modeswitched, the SIGXCPU handler obviously still executes in the RT domain,


Nope. All regular signal handlers are executed in the linux domain. 
Xenomai 2.x does not provide real-time signal handlers fired from 
primary mode.

  at least rt_task_self() returns a valid task descriptor - fine.
>
> If a kernel RT thread misses the release point, it seems the thread is immediately switched to linux scheduling

With Xenomai 2.x, there is no migration to secondary mode for a 
kernel(-only) RT thread.

  - or at least rt_task_self() returns NULL in this scenario:
>
> int result =  rt_task_wait_period(&overruns);
>      switch (result) {
>
>      case -ETIMEDOUT: // release point was missed
> 	task = rt_task_self(); // this returns NULL
>
>
> not a big thing - I just would like to get at the thread name for error message purposes; any way to do this?
>

Certainly, but which context does the code above run? On top of some 
ioctl()?

> - Michael
>
>
>
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Philippe.

