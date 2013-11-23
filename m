Message-ID: <5290FF8C.6050102@xenomai.org>
Date: Sat, 23 Nov 2013 20:18:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtdkR9QieGJ53owbkWD6fjO8ATep8BMMD7g1C2y3anWknQ@mail.gmail.com>
In-Reply-To: <CAKKWdtdkR9QieGJ53owbkWD6fjO8ATep8BMMD7g1C2y3anWknQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] some questions: domains and user/kernel code
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

On 11/23/2013 03:26 PM, ali hagigat wrote:
> I wonder if any one can answer the following questions:
> 
> 1) Some native functions like rt_cond_bind(), make a task switch to
> primary mode. If i have a regular linux task (not a xenomai task!) and
> i use the above function, will it become a Xenomai task which is
> running in the primary mode?

See rt_cond_bind() documentation:
http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__cond.html#ga74f22144e9e407980ba89bf11f01c277

> 
> 2) If i define a heap in user sapce, can a kernel-space code bind to
> that heap to read its data?

See rt_heaps documentation:
http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__native__heap.html

-- 
                                                                Gilles.

