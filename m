Date: Tue, 12 Sep 2017 13:51:48 +0000
Message-ID: <20170912135148.Horde.cG39ygekOR05hM-nO07JcEH@office.mrmoco.com>
From: Paul Wilkinson <paul.w@mrmoco.com>
References: <20170907153622.Horde.hT_sRaGS6VmkuifQTO4pqBa@office.mrmoco.com>
 <2ceb59af-770f-d99f-1f6a-553a669d20b5@xenomai.org>
 <20170911121830.Horde.hdU-y9sijxk8OGHoWqdylfy@office.mrmoco.com>
 <d8eca49a-1491-0e42-064e-ccbe3c188949@xenomai.org>
 <20170911161756.Horde.5576SR9hJdNX3u6KppQElrb@office.mrmoco.com>
 <20170912132632.Horde.2n3kq1TB84KjAL7evP_5TA4@office.mrmoco.com>
In-Reply-To: <20170912132632.Horde.2n3kq1TB84KjAL7evP_5TA4@office.mrmoco.com>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Subject: Re: [Xenomai] Questions around porting app to Xenomai/Cobalt
 resulting in SIGABRT ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Quoting Paul Wilkinson <paul.w@mrmoco.com>:


>
> I changed PTHREAD_STACK_DEFAULT to ~8M and reintroduced std:thread  
> in one case
> where thread creation failed previously.
>
> The SIGABRT failure mode returns, gdb stack trace below.
>
> Stack frame 6 shows std:thread is using pthreads under the hood, but  
> the SIGABRT
> seems to imply that my increasing PTHREAD_STACK_DEFAULT hasn't had  
> any effect, I
> now doubt Xenomai Cobalt is wrapping the pthread calls and applying the new
> PTHREAD_STACK_DEFAULT to the std::thread calls.
>
> I'd appreciate any insight into when and when not calls such as  
> pthread* will be
> intercepted by Xenomai Cobalt.
>


I should add that the new PTHREAD_STACK_DEFAULT of ~8M that I introduced
to ./include/boilerplate/libc.h is reflected in the initial stacksize, as
returned by pthread_attr_getstacksize(), for the remaining threads created
using pthread_create().


Paul.



