Message-ID: <4FE595D7.2080006@xenomai.org>
Date: Sat, 23 Jun 2012 12:09:27 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdte32SZLW-RT=8PLXJfWYqN3ErG_W1oywjCmHVgU27Uzbg@mail.gmail.com>
In-Reply-To: <CAKKWdte32SZLW-RT=8PLXJfWYqN3ErG_W1oywjCmHVgU27Uzbg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] some questions about the architecture of Xenomai
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

On 06/23/2012 11:46 AM, ali hagigat wrote:
> 1) Does (ADEOS and) Xenomai project changes and extends the Linux
> kernel sys_call_table?

Strictly speaking, no. They extend the syscall namespace  by interposing 
on the linux syscall mechanism, without altering the original table.

> 2) Considering i have used a VxWorks API function, will it be
> translated to a new Linux kernel system call?

Syscalls will be routed to the emulators through the nucleus.

> If no,  why there are some emulators and interfaces for VxWorks, pSOS
> and so on inside kernel?

Because in 2.x they implement the VxWorks, pSOS services and so on in 
kernel space. With the upcoming 3.x, these emulators are purely 
user-space based.

> 3) Does all the real time services and API functions will be
> translated to the nucleus API calls at last?
>

Yes, for most part.


> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Philippe.

