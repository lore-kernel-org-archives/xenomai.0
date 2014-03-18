Message-ID: <53286AAF.20708@xenomai.org>
Date: Tue, 18 Mar 2014 16:47:59 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtdSNQ1BHnqfOQjQcXHVAztzqkCu2qd60DOVwvtYJxcx+Q@mail.gmail.com>
 <531DD795.5050801@xenomai.org>
 <CAKKWdtd09OQTenTC6KcQP021VnmezUZHkj0J19DKAGLzEe3Fdw@mail.gmail.com>
 <CAKKWdtd5y4PF+oEhap-pxNckSTsWquBxj_Y5zG7ZByY+X5e_NA@mail.gmail.com>
In-Reply-To: <CAKKWdtd5y4PF+oEhap-pxNckSTsWquBxj_Y5zG7ZByY+X5e_NA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] a question about rt_mutex_acquire()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

On 03/18/2014 04:42 PM, ali hagigat wrote:
> On 3/11/14, ali hagigat <hagigatali@gmail.com> wrote:
>> On 3/10/14, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>>> On 03/10/2014 04:01 PM, ali hagigat wrote:
>>>> rt_mutex_acquire() creates a segmentation fault, why?
>>>
>>> Because rt_mutex_create failed? Otherwise we would see the message
>>> "success"?
>>>
>>> Is this a game? Or are you using Xenomai for a real project?
>>>
>>>
>>> --
>>> 					    Gilles.
>>>
>>
>> I am just testing Xenomai. If i comment rt_mutex_acquire() I see the
>> message, "success", and a real time mutex is created correctly.  by
>> uncommenting "rt_mutex_acquire()" there is a segmentation fault.
>>
>
> Why there is a segmentation fault?
>

Because rt_mutex_acquire() runs before rt_mutex_create(). Check your 
code to find out why.

-- 
Philippe.

