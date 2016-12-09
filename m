References: <145af902-fa69-f34a-754b-01badc8d7041@smile.fr>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <7025074b-0a3e-b831-5bfd-5bbd7d589eb9@xenomai.org>
Date: Fri, 9 Dec 2016 10:55:26 +0100
MIME-Version: 1.0
In-Reply-To: <145af902-fa69-f34a-754b-01badc8d7041@smile.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [XENOMAI] TIP_HEAD bit during Xenomai initialisation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Julien Stephan <julien.stephan@smile.fr>, xenomai@xenomai.org

On 12/08/2016 11:33 AM, Julien Stephan wrote:
> Hello,
> 
> We are trying to port xenomai to a new architecture.
> So far, we have ported the ipipe patch, the xenomai kernel and the
> xenomai librairies, though we are not 100% sure everything is working
> properly.
> 
> We are porting xenomai 3 ( Cobalt v3.0.3 (Groovy Cosmic Halo)  ) with a
> linux kernel 3.18. For now, we are able to boot linux correctly, with
> xenomai correctly registered:
> ~ # dmesg | grep -i xenomai
> [Xenomai] scheduling class idle registered.
> [Xenomai] scheduling class rt registered.
> I-pipe: head domain Xenomai registered.
> [Xenomai] Cobalt v3.0.3 (Groovy Cosmic Halo)
> 
> So far so good.
> 
> Now, I tried to run a very basic hello world program that has no
> real-time properties. We compile it using the example makefile given
> here (https://xenomai.org/building-applications-with-xenomai-3-x/) so
> that even if the application is not a real time application, the Xenomai
> services are initialized.
> 
> At run time, we get the following error:
> 0"000.000| BUG in low_init(): [main] Cobalt core not enabled in kernel
> 
> This bug appears in the low_init function in lib/cobalt/init.c after the
> XENOMAI_SYSBIND call.
> By stepping into the syscall handler with gdb, I noticed that TIP_HEAD
> bit of thread_info was not set and then we just go to the slow_path,
> then root_syscall  path  (see ARM ipipe patch for assembly labels)  and
> finally end up into the traditional linux handler that return -ENOSYS as
> the syscall number of XENOMAI_SYSBIND is greater than the linux kernel
> syscall limit.
> 
> So my question is: during initialization of the xenomai services, the
> TIP_HEAD bit should be set or not?
> 

No, it can't be set at this point. TIP_HEAD tags a thread which
currently runs in primary mode (i.e. at head of the pipeline), so it has
to be a Cobalt thread.

Since cobalt_sys_bind is issued to bind the current process to the
Cobalt core for the first time, the current thread (i.e. main()) can't
be a Cobalt thread yet, so it won't bear TIP_HEAD.

-- 
Philippe.

