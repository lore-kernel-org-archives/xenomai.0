Message-ID: <4DA6E5FB.1050204@domain.hid>
Date: Thu, 14 Apr 2011 14:18:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTi=fp61zxZyg=gGt4moNNw_hLa8_og@domain.hid>
In-Reply-To: <BANLkTi=fp61zxZyg=gGt4moNNw_hLa8_og@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] avoiding page faults
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jwamsc@domain.hid>
Cc: xenomai@xenomai.org

Jeff Weber wrote:
> I wish to avoid unwanted transitions of POSIX pthreads to secondary mode due
> to page faults.
> 
> Does calling
> mlockall(MCL_CURRENT | MCL_FUTURE)
> 
> lock pages when the memory is allocated, or referenced?
> 
> From reviewing Xenomai, Linux RT_PREEMPT, and RTAI code, it appears the
> answer is that memory is locked when the page is "referenced" (not
> allocated), and that referencing by write is preferred over referencing by
> read.  xeno_fault_stack() appears to pre-fault a subset of the stack when
> turning the calling thread into a Xenomai thread.
> 
> If true, then I should allocate my own stack for each pthread created in my
> program, and write every page ahead of time, then
> call pthread_attr_setstack() prior to thread creation.  I should also write
> every page of every dynamically allocated memory object.
> 
> Please help me verify if this understanding is correct.

mlockall(MCL_CURRENT) locks all the memory currently mapped.
mlockall(MCL_FUTURE) will lock all the memory when it is allocated/mapped.

The only thing which remains allocated on demand is the main thread
stack. This explains why we use xeno_fault_stack(), which faults a
"reasonable" amount of stack, in order to get the kernel to allocate and
map memory.

-- 
					    Gilles.

