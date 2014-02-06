Message-ID: <52F3848E.9030006@xenomai.org>
Date: Thu, 06 Feb 2014 13:48:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201402061158.29746.leo@alaxarxa.net>
 <52F36D64.7000109@xenomai.org> <52F372B5.9050909@xenomai.org>
 <201402061328.55141.leo@alaxarxa.net>
In-Reply-To: <201402061328.55141.leo@alaxarxa.net>
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
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: Sergi Ruiz Parra <sergi.ruiz.parra@upc.edu>, xenomai@xenomai.org

On 02/06/2014 01:28 PM, Leopold Palomo-Avellaneda wrote:
> A Dijous, 6 de febrer de 2014, Gilles Chanteperdrix va escriure:
>> On 02/06/2014 12:09 PM, Philippe Gerum wrote:
>>> On 02/06/2014 11:58 AM, Leopold Palomo-Avellaneda wrote:
>>>> Hi all,
>>>>
>>>> we are trying to develop an application using xddp protocol. We use as
> base,
>>>> the xddp-label exaample that compiles and run perfectly in our system
>>>> (Xenomai-2.6.3 with Linux 3.8.13).
>>>>
>>>> Our app is different from the xddp example because we have encapsulated
> the
>>>> realtime thread in a task, that it's in a library. We can run the
> task,called
>>>> from another part, and it rus.
>>>>
>>>> Our task create two sockets, one to receive from the NRT and another to
> send.
>>>> Yes, I know that we could do it in just one socket, but by design we must
> do
>>>> it in the way.
>>>>
>>>> Our main problem is when the RT task try to open the socket, the ipc
>>>> device isn't created. The error that appears is:"socket: Address family
> not
>>>> supported by protocol". I attach the real-time task code below.
>>>>
>>>> The xddp works, because the examples works. We have several /dev/rtpX and
> when
>>>> we run the example the /proc/xenomai/registry/rtipc/xddp/xddp-label is
>>>> created.
>>>>
>>>> Someone could give us some idea about what are we doing wrong?
>>>>
>>>
>>> Your application is likely not wrapping POSIX symbols properly, calling
>>> regular socket() instead of the Xenomai implementation. Check
>>> examples/rtdm/profiles/ipc/Makefile for LDLIBS. You must have --wrap or
>>> -Wl,@/some/path/posix.wrappers appearing in your link flags, for the
>>> wrapping to take place properly.
>>
>> See also:
>>
> https://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Compilation_flags
> 
> Thanks for the answers.
>   
> However, the pandora box has been open. :-(
> 
> We are using a modified version of SOEM [1][2] where the posix calls and
> selected in function of a defines.
> 
> We have not used any posix skin, if not native and rtdm. Using that wrapper
> have done that our lib doesn't work. All of our programs receive an SIGXCPU
> (CPU time limit exceeded). It's not easy for us with that.

SIGXCPU is in fact Xenomai's SIGDEBUG. See examples/native/sigdebug.c 
to find out why you receive SIGDEBUG. My bet would be that you are 
missing mlockall. That said, Xenomai should issue the mlockall 
automatically, you simply have to take care of putting xenomai 
libraries at the end of the link-edit command line, so that xenomai 
libraries are loaded first.

> 
> So, can we use the xddp protocol from native? Which functions we should use to
> send/receive, etc?

See:
http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__userapi.html

-- 
					    Gilles.

