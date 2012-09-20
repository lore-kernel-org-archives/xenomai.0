Message-ID: <505B5375.50007@grandegger.com>
Date: Thu, 20 Sep 2012 19:33:41 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <1347634862.78737.YahooMailNeo@web29605.mail.ird.yahoo.com>
	<5055E244.4040101@web.de> <003501cd9744$0c80a460$2581ed20$@de>
In-Reply-To: <003501cd9744$0c80a460$2581ed20$@de>
Content-Type: text/plain; charset=ISO-8859-1
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
Cc: 'Jan Kiszka' <jan.kiszka@web.de>, xenomai@xenomai.org

On 09/20/2012 05:24 PM, Franz Engel wrote:
> Hi Jan,
> 
>>> Hi,
>>>
>>> I've a little problem. I'm using the rtnet.h-header and the following
>> function:
>>> ret = recvfrom ( ethernetConnection.sock, &recBuffer, sizeof (
>>> recBuffer ),0, ( struct sockaddr * )
>>> &ethernetConnection.dest_addr,&destlen );
>>>
>>>
>>> I compiled the program with the xenomai compiling flags and library.
>>>
>>> When I look to the xenomai state I get something like this:
>>> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>>>  22  0      0          834840     0     00000082    0.1  rtnet-stack
>>>  22  0      0          1          0     00000082    0.0  rtnet-rtpc
>>>   0  6262   2          2          0     00300380    0.0
>> qs_robotpositio
>>>   2  6265   2          6          0     00300380    0.0
>> qs_robotpositio
>>>   0  6266   1          1          0     00300380    0.0
>> robotrsiinterfa
>>>   1  6268   1147       2365       0     00300182    0.8
>> robotrsiinterfa
>>>
>>> You can see, I get a lote of context and module switches just as the
>> rtnet-stack itself. Is that normal?
>>
>> Well, I have no clue what you configured, so I can only guess. If your
>> task 6268 is a pure RT task that is not supposed to interact with Linux
>> services, you first of all have a bug in your software stack. You
>> should look for the reason of those mode switches to Linux, e.g. by
>> asking Xenomai to raise SIGXCPU when this happens.
> 
> I use the SIGXCPU signal to look where I get a context switch. It is exactly
> in the line of the recvfrom. I get the same result when I step through my
> code. I debug from line to line and check the /proc/xenomai/state, so I can
> see that the CSW and MSW increases when I step over the recvfrom. I tried my
> code also with the native commands, like rt_recvfrom. But the result is the
> same.

What is the reason for the mode switch? How to get it see:

http://www.rts.uni-hannover.de/xenomai/lxr/source/examples/native/sigdebug.c

Wolfgang.


