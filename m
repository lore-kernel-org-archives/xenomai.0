Message-ID: <4EFF2B04.1000209@domain.hid>
Date: Sat, 31 Dec 2011 16:32:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BLU166-W39C682E7E76684CC152F0C4930@domain.hid>
In-Reply-To: <BLU166-W39C682E7E76684CC152F0C4930@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] user and kernel space
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan-Erik Lange <jan0385@domain.hid>
Cc: xenomai@xenomai.org

On 12/31/2011 12:18 PM, Jan-Erik Lange wrote:
> 
> Hello,
> 
> I have a question concerning user space and kernel space. I'm dealing
> with the native API and I read, that this API provides the same
> funtkions for both kernel and user space.
> 
> When looking at the sourcecode of buffer.h for example, there I find
> a section called public interface. When looking at the function
> rt_buffer_create(); for example, how does the Implementation von this
> function in userspace differs to the implementation for this function
> kernel space? Or is it the same implementation for user and kernel
> space.

For most services such as buffer services, user functions emit system
calls which implementation in kernel-space use the corresponding kernel
service.

There are some exceptions such as mutexes implementation where we try
hard to avoid system calls and so provide both a user-space
implementation and a kernel-space implementation.

Another exception is the __xn_rdtsc() function, which relies on most
platforms on the same mechanism in user and kernel-space to access the
machine high resolution counter, and so has an identical implementation.


-- 
                                                                Gilles.

