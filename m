Message-ID: <52BFE8BA.9060308@xenomai.org>
Date: Sun, 29 Dec 2013 10:17:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtdP_fvvMwzC8YpZriL6mC_QbwRkmjzpPYVB8Ue8yBFt5Q@mail.gmail.com>
In-Reply-To: <CAKKWdtdP_fvvMwzC8YpZriL6mC_QbwRkmjzpPYVB8Ue8yBFt5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kernel panic for rt_task_add_hook
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

On 12/29/2013 09:15 AM, ali hagigat wrote:
> I am using a 32 bit Fedora 13, linux kernel 3.5.7 and xenomai-2.6.3.
> Please do the followings:
> 
> 1) insmod ./kerneltask2.ko
> 2) rmmod kerneltask2
> 
> The first time is OK. The second time the computer freezes and i have
> a kernel panic and carsh dump every time.

You have to call rt_task_remove_hook in the module cleanup function.
Otherwise the hook remains registered with a module address no longer valid.


-- 
                                                                Gilles.

