Message-ID: <52657C7A.3050000@xenomai.org>
Date: Mon, 21 Oct 2013 21:11:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtd22t=83-aTgGJX9F_yqFtqX6GtDoxUcWqfQ3Z295ToHQ@mail.gmail.com>
In-Reply-To: <CAKKWdtd22t=83-aTgGJX9F_yqFtqX6GtDoxUcWqfQ3Z295ToHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] where is the kernel code for rt_printf()?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On 10/21/2013 04:05 PM, ali hagigat wrote:
> i wonder if anybody can tell me where would be the source code of the
> fuction, rt_printf(), inside the kernel?  Is it the same as
> rt_printk()?

There is no rt_printk function.

rt_printf is implemented using the "write()" syscall as kernel-space
support, it simply transmits message to a non real-time thread which
uses printf.

-- 
                                                                Gilles.

