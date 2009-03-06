Message-ID: <49B1522F.4060202@domain.hid>
Date: Fri, 06 Mar 2009 17:41:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <27822339.1236353250536.JavaMail.ngmail@domain.hid>	
	<49B14276.20100@domain.hid>
	<cbe23c50903060826i7f8b4a41s9aed051eea249c28@domain.hid>
In-Reply-To: <cbe23c50903060826i7f8b4a41s9aed051eea249c28@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and OpenMP
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Noulard <eric.noulard@domain.hid>
Cc: xenomai@xenomai.org, "M. Koehrer" <mathias_koehrer@domain.hid>

Eric Noulard wrote:
> 2009/3/6 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>> M. Koehrer wrote:
>>> Hi everybody,
>>>
>>> is it possible to use OpenMP with Xenomai Realtime threads? I have a
>>> Intel QuadCore CPU running. Currently I use the native skin to create
>>> multiple threads to run on multiple CPU cores. That works perfectly.
>>> However for some computations, a more local parallel computation
>>> could be great. And OpenMP provides exactly the right thing here. My
>>> question is now: Is it possible to use OpenMP with Xenomai real time
>>> tasks? How can I define the worker threads of OpenMP to be real time
>>> threads? What about the priority of these threads?
>> I do not know what OpenMP is,
> 
> OpenMP is a proposed standard for shared-memory parallel programming:
> http://openmp.org.
> 
> The idea is to indicate to the OpenMP-aware compiler which part
> of your code may be parallelized with #pragma omp <something>
> those pragma should be ignored by non OpenMP-aware compiler
> making the parallelized code more portable.
> 
> GCC 4.2 and up support OpenMP pragma if you use the
> -fopenmp
> command line switch.
> 
>> but if it uses the posix API, the first
>> step to make it work with Xenomai is to try and compile it with xenomai
>> posix skin. Then, all threads created by this openmp compiled for
>> xenomai posix skin will be real-time threads, and the priority of these
>> threads will be the one chosen by the pthread_att_setschedparam or
>> pthread_setschedparam services.
> 
> The OpenMP parallel model concerning threads is a so-called
> fork/join model. The compiler insert the code that
> creates the threads (and eventually join them)
> at appropriate places for you.
> The work is then distributed to those "worker" threads.
> The code use to handle those mechanism is NOT under user control,
> user only insert OpenMP pragmas.
> 
> In GCC there is a supporting library "libgomp" used:
> http://gcc.gnu.org/viewcvs/trunk/libgomp/
> 
> the lib seems to be using pthread, but this as to be checked carefully.
> Thus I would bet that somewhere in libgomp you'll find the pthread_xxxx
> calls corresponding to the OpenMP handled threads.
> 
> I think in order to make the OpenMP thread Xenomai one's you'll have
> to find WHERE (in the libgomp code) they are created and may
> WHEN they are launched, in order to be sure the libgomp created
> threand will be Xenomai tasks.
> 
> The solution used by other compiler to support OpenMP may be different,
> so the Xenomai+OpenMP support may be different  for other compiler.

if the libgomp uses posix, recompiling it for xenomai posix skin should
be enough.

-- 
                                                 Gilles.

