Message-ID: <4649A485.5010102@domain.hid>
Date: Tue, 15 May 2007 14:16:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <DD39B5C3F4963040ADC9768BE7E430CB01EB2004@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB01EB2004@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] memcpy performance on Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

Daniel Schnell wrote:
> Hi,
>  
>  
> I am testing the memcpy() performance of Xenomai on my board in
> comparision to the memcpy() performance of native linux and I get
> significant differences.
> 
> Attached find a program which compiles on native linux simply with
> (-lrt).
> It gives me the following output:
> 
> =======
> bash-2.05b# ./memcpy_perf
> Test (10000) memcpy of sizes (1024) ....
> 10000 memcpy. Time per memcpy: 1567 [nsec] (653 MB/sec)
>  finished.
> Test (10000) memcpy of sizes (2048) ....
> 10000 memcpy. Time per memcpy: 2939 [nsec] (696 MB/sec)
>  finished.
> Test (10000) memcpy of sizes (4096) ....
> 10000 memcpy. Time per memcpy: 5706 [nsec] (717 MB/sec)
>  finished.
> Test (10000) memcpy of sizes (8192) ....
> 10000 memcpy. Time per memcpy: 17077 [nsec] (479 MB/sec)
>  finished.
> Test (10000) memcpy of sizes (16384) ....
> 10000 memcpy. Time per memcpy: 133314 [nsec] (122 MB/sec)
>  finished.
> Test (1000) memcpy of sizes (32768) ....
> 1000 memcpy. Time per memcpy: 243417 [nsec] (134 MB/sec)
>  finished.
> Test (1000) memcpy of sizes (51200) ....
> 1000 memcpy. Time per memcpy: 403455 [nsec] (126 MB/sec)
>  finished.
> Test (1000) memcpy of sizes (102400) ....
> 1000 memcpy. Time per memcpy: 713316 [nsec] (143 MB/sec)
>  finished.
> Test (100) memcpy of sizes (1048576) ....
> 100 memcpy. Time per memcpy: 7210570 [nsec] (145 MB/sec)
>  finished.
> Test (10) memcpy of sizes (10485760) ....
> 10 memcpy. Time per memcpy: 78162400 [nsec] (134 MB/sec)
>  finished.
> Test (5) memcpy of sizes (52428800) ....
> 5 memcpy. Time per memcpy: 425281800 [nsec] (123 MB/sec)
>  finished.
> 
> ======
> 
> Spawning the function testMemcpy() as a POSIX thread inside another
> program
> yields the following results:
> 
> bash-2.05b# bin/testspecs
> Test (10000) memcpy of sizes (1024) ....
> 10000 memcpy. Time per memcpy: 1566 [nsec] (653 MB/sec)
>  finished.
> Test (10000) memcpy of sizes (2048) ....
> 10000 memcpy. Time per memcpy: 2943 [nsec] (695 MB/sec)
>  finished.
> Test (10000) memcpy of sizes (4096) ....
> 10000 memcpy. Time per memcpy: 5696 [nsec] (719 MB/sec)
>  finished.
> Test (10000) memcpy of sizes (8192) ....
> 10000 memcpy. Time per memcpy: 17325 [nsec] (472 MB/sec)
>  finished.
> Test (10000) memcpy of sizes (16384) ....
> 10000 memcpy. Time per memcpy: 200892 [nsec] (81 MB/sec)
>  finished.
> Test (1000) memcpy of sizes (32768) ....
> 1000 memcpy. Time per memcpy: 400213 [nsec] (81 MB/sec)
>  finished.
> Test (1000) memcpy of sizes (51200) ....
> 1000 memcpy. Time per memcpy: 555240 [nsec] (92 MB/sec)
>  finished.
> Test (1000) memcpy of sizes (102400) ....
> 1000 memcpy. Time per memcpy: 1253123 [nsec] (81 MB/sec)
>  finished.
> Test (100) memcpy of sizes (1048576) ....
> 100 memcpy. Time per memcpy: 12413170 [nsec] (84 MB/sec)
>  finished.
> Test (10) memcpy of sizes (10485760) ....
> 10 memcpy. Time per memcpy: 124039572 [nsec] (84 MB/sec)
>  finished.
> Test (5) memcpy of sizes (52428800) ....
> 5 memcpy. Time per memcpy: 596899212 [nsec] (87 MB/sec)
>  finished.
> 
> As long as the memcpy works on the cache line only, the results are
> identical. As soon as the real DDR memory is used, performance drops by
> 66% !
> 
> I am assuming because of different linked-in time functions
> (clock_gettime())) I am measuring somehow differently. But I am clueless
> at the moment where and if the performance is eaten up.

Improving clock_gettime overhead by reading directly the tsc is my very
next task. If you want to check if the effect you measure is the result
of clock_gettime overhead, you can measure the duration of memcpy with
the native api service rt_timer_tsc, and convert the tsc difference with
rt_timer_tsc2ns.

-- 
                                                 Gilles Chanteperdrix

