References: <48bfcc92-3224-c7ce-10d9-9f4621e10331@tuebingen.mpg.de>
 <d009beb3-49d6-b318-e872-51ce93e49cf2@xenomai.org>
From: Vincent Berenz <vberenz@tuebingen.mpg.de>
Message-ID: <3fd685e2-b399-34c7-8529-48edc391712b@tuebingen.mpg.de>
Date: Thu, 7 Dec 2017 14:42:15 +0100
MIME-Version: 1.0
In-Reply-To: <d009beb3-49d6-b318-e872-51ce93e49cf2@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Xenomai] Xenomai 3.0.5 : RTIPC/XDDP protocol not supported by
 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

Many thanks for the answer

The demos xddp-echo , xddp-label and xddp-stream seems all to be working ok.

As sanity check, I copied xddp-echo.c to my workspace and compiled it 
with the rest of our code.

Compilation goes ok, but execution fails with message:

     socket: Address family not supported by protocol

This brought my attention to this:

    http://xenomai.org/pipermail/xenomai/2014-February/030113.html

which says:

   "Your application is likely not wrapping POSIX symbols properly, calling
    regular socket() instead of the Xenomai implementation. "

We do things this way, possibly something is missing ?

   exec_program(${XENOMAI_ROOT}/bin/xeno-config ARGS "--skin=native 
--cflags"
                                                   OUTPUT_VARIABLE 
XENOMAI_C_FLAGS)
   exec_program(${XENOMAI_ROOT}/bin/xeno-config ARGS "--skin=native 
--ldflags"
     OUTPUT_VARIABLE XENOMAI_LD_FLAGS)

   set(CMAKE_C_FLAGS "${XENOMAI_C_FLAGS} ${CMAKE_C_FLAGS}")
   set(CMAKE_CPP_FLAGS "${XENOMAI_C_FLAGS} ${CMAKE_CPP_FLAGS}")

   # libraries / executable are linked against this later on
   set(LAB_STD_LIBS alchemy copperplate cobalt modechk trank pthread 
edit curses nsl glut GL GLU X11 Xmu m)

   link_directories(${XENOMAI_ROOT}/lib /usr/lib /usr/X11/lib64 
/usr/X11/lib /usr/lib64 ${CMAKE_LIBRARY_PATH})

   add_definitions(${XENOMAI_C_FLAGS})

   add_definitions(-D__XENO__)
   add_definitions(-pipe)
   add_definitions(-D_REENTRANT)
   add_definitions(-D_GNU_SOURCE)

Best

Vincent


On 07.12.2017 10:46, Philippe Gerum wrote:
> On 12/06/2017 10:55 AM, Vincent Berenz wrote:
>> Hi,
>>
>> We are currently moving from xenomai 2 to xenomai 3.
>> I installed xenomai 3.0.5, and all seems to be working, with low latency.
>>
>> I am now trying to get our legacy code to work on xenomai 3 using the
>> transition kit.
>>
>> Our program compiles, but at runtime, on call to rt_pipe_create :
>>          0"000.000| WARNING: [main] RTIPC/XDDP protocol not supported by
>> kernel
>>
> Do you observe the same issue with any of the native POSIX demo apps
> available from <xenomai-install>/demo/xddp-*?
>


