Message-ID: <52F372B5.9050909@xenomai.org>
Date: Thu, 06 Feb 2014 12:32:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201402061158.29746.leo@alaxarxa.net>
 <52F36D64.7000109@xenomai.org>
In-Reply-To: <52F36D64.7000109@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xddp and socket: Address family not supported by
	protocol
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, Sergi Ruiz Parra <sergi.ruiz.parra@upc.edu>

On 02/06/2014 12:09 PM, Philippe Gerum wrote:
> On 02/06/2014 11:58 AM, Leopold Palomo-Avellaneda wrote:
>> Hi all,
>>
>> we are trying to develop an application using xddp protocol. We use as base,
>> the xddp-label exaample that compiles and run perfectly in our system
>> (Xenomai-2.6.3 with Linux 3.8.13).
>>
>> Our app is different from the xddp example because we have encapsulated the
>> realtime thread in a task, that it's in a library. We can run the task,called
>> from another part, and it rus.
>>
>> Our task create two sockets, one to receive from the NRT and another to send.
>> Yes, I know that we could do it in just one socket, but by design we must do
>> it in the way.
>>
>> Our main problem is when the RT task try to open the socket, the ipc
>> device isn't created. The error that appears is:"socket: Address family not
>> supported by protocol". I attach the real-time task code below.
>>
>> The xddp works, because the examples works. We have several /dev/rtpX and when
>> we run the example the /proc/xenomai/registry/rtipc/xddp/xddp-label is
>> created.
>>
>> Someone could give us some idea about what are we doing wrong?
>>
> 
> Your application is likely not wrapping POSIX symbols properly, calling 
> regular socket() instead of the Xenomai implementation. Check 
> examples/rtdm/profiles/ipc/Makefile for LDLIBS. You must have --wrap or 
> -Wl,@/some/path/posix.wrappers appearing in your link flags, for the 
> wrapping to take place properly.

See also:
https://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Compilation_flags

-- 
                                                                Gilles.

