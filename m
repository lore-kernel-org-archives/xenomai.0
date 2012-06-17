Message-ID: <4FDDE3F5.3020606@xenomai.org>
Date: Sun, 17 Jun 2012 16:04:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtcYW8ci7Y=XG2KODyMikF3H0p-JKZeCgU7duPQc+xz9PQ@mail.gmail.com>
In-Reply-To: <CAKKWdtcYW8ci7Y=XG2KODyMikF3H0p-JKZeCgU7duPQc+xz9PQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] some questions about Xenomai documents
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai@xenomai.org

On 06/17/2012 02:04 PM, ali hagigat wrote:
> I have downloaded "xenomai-api.pdf". It mentions "kernel-based tasks"
> and "user-space context (conforming call)".

You do not need to download it, it is included in xenomai sources. Also
note that you have an html version which you may find easier to browse,
also available online here:
http://www.xenomai.org/documentation/xenomai-2.6/html/api/index.html

> 
> What does "kernel-based task" mean? It is like when i create a task in
> a kernel context (inside the kernel)?
> I heard "kernel thread" before, can it be different with a kernel task?

No it is the same thing.

> 
> Can i use rt_task_create() function in any place of the Linux kernel code?

Check rt_task_create documentation for an answer to this question. But
be warned: using rt_task_create in kernel context is deprecated and will
no longer be supported in xenomai 3.x.

> 
> What is the meaning of "user-space context" ? Is it different with
> "user-space task"?! What is  "conforming call"?

A conforming call is a system call (so, for user-space threads only)
which will be executed in xenomai domain for xenomai threads, and in
linux domain for plain linux threads.

> 
> I wonder if some lines can be added to clarify these expressions in
> the documentation.

Patches are always welcome. But note that reading the API documentation
alone is probably not sufficient. You should first read the documents
"Life with Adeos" and "Native API tour" for a general overview.

-- 
                                                                Gilles.

