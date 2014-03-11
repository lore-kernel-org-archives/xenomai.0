MIME-Version: 1.0
In-Reply-To: <531DD795.5050801@xenomai.org>
References: <CAKKWdtdSNQ1BHnqfOQjQcXHVAztzqkCu2qd60DOVwvtYJxcx+Q@mail.gmail.com>
 <531DD795.5050801@xenomai.org>
Date: Tue, 11 Mar 2014 15:53:35 +0330
Message-ID: <CAKKWdtd09OQTenTC6KcQP021VnmezUZHkj0J19DKAGLzEe3Fdw@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] a question about rt_mutex_acquire()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

On 3/10/14, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> On 03/10/2014 04:01 PM, ali hagigat wrote:
>> rt_mutex_acquire() creates a segmentation fault, why?
>
> Because rt_mutex_create failed? Otherwise we would see the message
> "success"?
>
> Is this a game? Or are you using Xenomai for a real project?
>
>
> --
> 					    Gilles.
>

I am just testing Xenomai. If i comment rt_mutex_acquire() I see the
message, "success", and a real time mutex is created correctly.  by
uncommenting "rt_mutex_acquire()" there is a segmentation fault.

