Message-ID: <505DBE28.1040803@xenomai.org>
Date: Sat, 22 Sep 2012 15:33:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.1.1348308001.4459.xenomai@xenomai.org>
	<004901cd98c5$194fc590$4bef50b0$@de>
In-Reply-To: <004901cd98c5$194fc590$4bef50b0$@de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Context Switch with rtnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Franz Engel <franz_lambert_engel@yahoo.de>
Cc: xenomai@xenomai.org

On 09/22/2012 03:20 PM, Franz Engel wrote:

>> On Fri, 21 Sep 2012 12:08:40 +0200, Kai Bollue <mlist1@bollue.de>
>>> On 21.09.2012 12:02, Gilles Chanteperdrix wrote:
>>>> On 09/21/2012 11:58 AM, Kai Bollue wrote:
>>>>> On 14.09.2012 17:01, Franz Engel wrote:
>>>>> Hi,
>>>>>
>>>>> I've a little problem. I'm using the rtnet.h-header and the
>> following function:
>>>>> ret = recvfrom ( ethernetConnection.sock, &recBuffer, sizeof (
>>>>> recBuffer ),0, ( struct sockaddr * )
>>>>> &ethernetConnection.dest_addr,&destlen );
>>>> Hi,
>>>>
>>>> stupid question: But you do use an rtnet socket, not a normal one,
>> do
>>>> you? In this case, shouldn't it be rt_dev_recvfrom(...)?
>>> When using the posix skin, recvfrom is substituted at compilation (or
>>> more exactly link-edit) time with __wrap_recvfrom, implemented in
>>> libpthread_rt.so, allowing to work with real-time sockets.
>>>
>>
>> Ah, sorry, I missed that.
>>
> 
> Sorry, I missed to answer on some questions:
> 
> Let me explain my problem again. When I run my program ("mytask") the CSW
> and MSW increase every time the program receive a message:
> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>   0  0      0          396        0     00500080  100.0  ROOT/0
>   1  0      0          0          0     00500080  100.0  ROOT/1
>   0  1336   1          1          0     00300380    0.0  kogmo_man
>   0  0      0          209        0     00000082    0.0  rtnet-stack
>   0  0      0          1          0     00000082    0.0  rtnet-rtpc
>   0  0      0          1          0     00000082    0.0  rtcfg-rx
>   0  5182   1          15         0     00340182    0.0  mytask
>   0  0      0          143        0     00000000    0.0  IRQ22: rteth0
>   1  0      0          186        0     00000000    0.0  IRQ22: rteth0
>   0  0      0          2054479    0     00000000    0.0  IRQ4364: [timer]
>   1  0      0          547805     0     00000000    0.0  IRQ4364: [timer]
> 
> Wolfgang advised me to find the reason for this phenomenon like the program
> on this link:
> http://www.rts.uni-hannover.de/xenomai/lxr/source/examples/native/sigdebug.c
> I tried it and modified my code (see the code further down). When I insert
> an "cout" after "rt_task_set_mode(0, T_WARNSW, NULL);" I get a failure
> message (so it should work). But when I run this program without the cout I
> get no message, but the CSW and MSW counter are still increases.  
> 
> 
> That's my versions:
> rtnet 0.9.12
> xenomai 2.5.5.2


That is not the latest release in the 2.5 branch. You are advised to
upgrade to 2.5.6, it should work with the same linux kernel version.

>

>     exec_program("${XENOMAI_DIR}/bin/xeno-config --skin=native --ldflags"
> OUTPUT_VARIABLE XENOMAI_EXE_LINKER_FLAGS)
>     set(CMAKE_EXE_LINKER_FLAGS ${CMAKE_EXE_LINKER_FLAGS}
> ${XENOMAI_EXE_LINKER_FLAGS})
>     exec_program("${XENOMAI_DIR}/bin/xeno-config --skin=native --cflags"
> OUTPUT_VARIABLE XENOMAI_DEFINITIONS)


Here you are retrieving the flags for the native skin, not for the posix
skin, unless there is some other part of your makefile which gets them.

>     if ( ( ethernetConnection.sock = socket ( AF_INET, SOCK_DGRAM,
> IPPROTO_UDP ) ) < 0 )

> (...)
>     if ( bind ( ethernetConnection.sock, ( struct sockaddr * )
> &ethernetConnection.local_addr, sizeof ( ethernetConnection.local_addr
) ) <
> 0 )
> (...)
>         recvfrom( ethernetConnection.sock, &recBuffer, sizeof ( recBuffer
> ),0, ( struct sockaddr * ) &ethernetConnection.dest_addr,&destlen );

Here you are using the posix calls socket, bind and recvfrom. It will
allow you to work with an RTDM socket only if you compile for the posix
skin. See:

http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Compilation_for_the_Xenomai_POSIX_skin

Now, I have no idea why you do not get any signal when using these calls.

-- 
                                                                Gilles.

