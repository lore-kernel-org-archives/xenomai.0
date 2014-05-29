Message-ID: <53875672.4030608@xenomai.org>
Date: Thu, 29 May 2014 17:46:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <53765654.8010509@ruggedcom.com>
In-Reply-To: <53765654.8010509@ruggedcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RT_HEAP physical address
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Makarand Pradhan <makarandpradhan@ruggedcom.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/16/2014 08:17 PM, Makarand Pradhan wrote:
> Hi All,
> 
> I am running on MPC8360(powerpc) linux 3.0, xenomai 2.6.3.
> 
> I am trying to get the physical address of a heap using rt_heap_inquire. 
> All the same, I'm getting a null pointer. Can you pl point out if I'm 
> doing something wrong?
> 
> Code:
> 
> #include <rtdk.h>
> #include <stdio.h>
> #include <sys/mman.h>
> #include <native/heap.h>
> #include <native/task.h>
> 
> void task1_func(void *arg)
> {
>          RT_HEAP heap;
>          RT_HEAP_INFO info;
> 
>          rt_printf("Running\n");
> 
>          int rc = rt_heap_create(&heap, "TEST", 1024, H_DMA);

H_SINGLE is missing here.

-- 
                                                                Gilles.

