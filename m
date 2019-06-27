From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Waking up threads from the other xenomai/linux domain
References: <VI1PR05MB59174B1FCCC4A8B782A2EEEDF6E20@VI1PR05MB5917.eurprd05.prod.outlook.com>
Message-ID: <d1807b53-981e-734c-264d-719ca4d7844b@xenomai.org>
Date: Thu, 27 Jun 2019 14:42:40 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB59174B1FCCC4A8B782A2EEEDF6E20@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 6/26/19 1:05 PM, Lange Norbert via Xenomai wrote:
> Hello,
> 
> I have multiple threads, one of them is realtime, one other is responsible for controlling the service.
> 
> The controlling thread blocks on some linux sockets, the realtime one has a select on a RT socket and a timeout.
> 
> I now have the problem that I need to wake up the other thread under some circumstances, not always (then I would just poll),
> but potentially in regular burst (forwarding packets).
>>From the docs, XDDP seems the only solution, I wonder if there are more.
> 
> 1) Connect the threads with a XDDP socket, add the fd in the select calls.
> 2) Atleast when Linux is waking up Xenomai, I could use an IDDP/BUFP socket with the linux thread then being promoted for the duration of the call.

I would not recommend this unless those packets arrive at a fairly low
rate: a double mode migration is costly, way, way more than using XDDP.

> 3) Signals? Could they be used to interrupt the select (both linux and cobalt variant)?. The POSIX skin has no pselect so I wonder how I would make sure the signal
> is only delivered during select

I don't think the POSIX signal machinery can be described as
lightweight. Besides, since cobalt only implements the synchronous
interface via sigwait*(), select() would not unblock on signal receipt.

> 
> All the RTIPC sockets seem to use a global pool of ports, and I believe XDDP to be rather heavyweight.I am looking for an efficient way (in total CPU time) to unblock a thread,
> It does not need to have lowest latency.

You may be overestimating the XDDP overhead especially if the message
rate is low. Having a size-configurable (CONFIG_XENO_OPT_PIPE_NRDEV)
global pool of ports should not be an issue in a system where you can -
and should - know in advance how many of them are going to be used at
most. If the issue is with port naming conflicts, then you can ask XDDP
to allocate the next free port then attach a label to it. The
application goes through the registry to refer to such port by label,
instead of using its raw port number.

If you don't want messaging at all but only signaling, then you could
add some kind of cross-domain eventfd() protocol to the RTIPC driver.

> 
> (Note that this is in the same process, so I would prefer something like socketpair to open up an anonymous "pipe" not feeding from global ports).
> 

Cobalt does not provide this.

-- 
Philippe.

