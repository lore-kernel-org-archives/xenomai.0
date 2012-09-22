Message-ID: <505DC4FD.20802@xenomai.org>
Date: Sat, 22 Sep 2012 16:02:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.1.1348308001.4459.xenomai@xenomai.org>
	<004901cd98c5$194fc590$4bef50b0$@de> <505DBE28.1040803@xenomai.org>
	<004a01cd98c9$de589c50$9b09d4f0$@de>
In-Reply-To: <004a01cd98c9$de589c50$9b09d4f0$@de>
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

On 09/22/2012 03:55 PM, Franz Engel wrote:

>> On 09/22/2012 03:40 PM, Gilles Chanteperdrix wrote:
>>> On 09/22/2012 03:20 PM, Franz Engel wrote:
>>>> On Fri, 21 Sep 2012 12:08:40 +0200, Kai Bollue <mlist1@bollue.de>
>>>>> On 21.09.2012 12:02, Gilles Chanteperdrix wrote:
>>>>>> On 09/21/2012 11:58 AM, Kai Bollue wrote:
>>>>>>> On 14.09.2012 17:01, Franz Engel wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> I've a little problem. I'm using the rtnet.h-header and the
>>>> following function:
>>>>>>> ret = recvfrom ( ethernetConnection.sock, &recBuffer, sizeof (
>>>>>>> recBuffer ),0, ( struct sockaddr * )
>>>>>>> &ethernetConnection.dest_addr,&destlen );
>>>>>> Hi,
>>>>>>
>>>>>> stupid question: But you do use an rtnet socket, not a normal one,
>>>> do
>>>>>> you? In this case, shouldn't it be rt_dev_recvfrom(...)?
>>>>> When using the posix skin, recvfrom is substituted at compilation
>>>>> (or more exactly link-edit) time with __wrap_recvfrom, implemented
>>>>> in libpthread_rt.so, allowing to work with real-time sockets.
>>>>>
>>>>
>>>> Ah, sorry, I missed that.
>>>>
>>>
>>> Sorry, I missed to answer on some questions:
>>>
>>> Let me explain my problem again. When I run my program ("mytask") the
>>> CSW and MSW increase every time the program receive a message:
>>> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>>>   0  0      0          396        0     00500080  100.0  ROOT/0
>>>   1  0      0          0          0     00500080  100.0  ROOT/1
>>>   0  1336   1          1          0     00300380    0.0  kogmo_man
>>>   0  0      0          209        0     00000082    0.0  rtnet-stack
>>>   0  0      0          1          0     00000082    0.0  rtnet-rtpc
>>>   0  0      0          1          0     00000082    0.0  rtcfg-rx
>>>   0  5182   1          15         0     00340182    0.0  mytask


The thing is, we only see 1 MSW for mytask, I think it is normal to have
an MSW during task startup. CSW are completely normal for a recvfrom loop.

-- 
                                                                Gilles.

