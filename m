Message-ID: <52EAB8DF.5090803@xenomai.org>
Date: Thu, 30 Jan 2014 21:41:03 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <DUB112-W1296E6715891C2DFCE34EADF6AF0@phx.gbl>
In-Reply-To: <DUB112-W1296E6715891C2DFCE34EADF6AF0@phx.gbl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Using of Shared Memory
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andrea Saltari <david812@hotmail.it>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/30/2014 08:43 PM, Andrea Saltari wrote:
> Dear All,
> I didn't fully understand how to write on a shared memory.
> The example lead to create, bind and allocate a shared memory but it doesn't explain how to copy data on it.
> Do i need to use a simple C function  memcpy()? Doesn't it push out from primary mode??

The only case where a thread is switched to secondary mode when writing
to memory is when it gets a page fault, either because the memory is
mapped on the demand (as is the case for instance with the main thread
stack), or because of "copy-on-write" (which should only happen with
MAP_PRIVATE, not with MAP_SHARED), or on some platforms, notably ARM, on
first write.

To see if that is your case, use the PTHREAD_WARNSW bit with
pthread_set_mode_np or T_WARNSW with rt_task_set_mode, as is
demonstrated in the examples/native/sigdebug.c program, so as to receive
a signal if your task switches to secondary mode.

If that happens, you will probably need to write a byte on each page of
the shared memory, right after mapping it, so that the fault will not
happen for threads running in primary mode.

Regards.

-- 
                                                                Gilles.

