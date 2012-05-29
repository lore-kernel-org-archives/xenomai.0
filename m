Message-ID: <4FC507DA.6070209@xenomai.org>
Date: Tue, 29 May 2012 19:31:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANzShzfFDnC6C_v4-Xv_dxaX70kgP1vYcRqc2kfYVAj-Qxn5+g@mail.gmail.com>
In-Reply-To: <CANzShzfFDnC6C_v4-Xv_dxaX70kgP1vYcRqc2kfYVAj-Qxn5+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Posix_skin_periodic_tasks
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Moustapha Bikienga <mbikienga@gmail.com>
Cc: xenomai@xenomai.org

On 05/29/2012 03:24 PM, Moustapha Bikienga wrote:
> Hi.
> 
> I want to write periodic tasks by using POSIX skin in userspace. My Xenomai
> version is 2.6
> Where can I see some examples ?

"cyclictest" contained in xenomai sources is an example of periodic
task, but it may not be easy to read. The portable way of doing this is
to use clock_nanosleep with the TIMER_ABSTIME flag, updating the struct
timespec argument by adding the fixed period.

The non portable way is to use pthread_make_periodic_np and pthread_wait_np

Documentation of the various services:
http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__posix__time.html#ga924d51d78cdcd9d7dee2613fb3a33cd1
http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__posix__thread.html#gafe8deaa3c89e0a07e59f0e58f9ec1473
http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__posix__thread.html#ga1f18e6e7dd5342463ca8546ef3a36c34

-- 
					    Gilles.

