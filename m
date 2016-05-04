References: <4318702e-51ea-f276-55b0-490fdc13fffd@isir.upmc.fr>
 <20160426142028.GD27058@hermes.click-hack.org>
 <4e3bc939-1942-1e78-9551-fffe95204fef@isir.upmc.fr>
 <20160429194212.GP1881@hermes.click-hack.org>
From: Florian Richer <richer@isir.upmc.fr>
Message-ID: <d05a6592-b473-2a12-2e71-f9b067e2c83d@isir.upmc.fr>
Date: Wed, 4 May 2016 12:17:30 +0200
MIME-Version: 1.0
In-Reply-To: <20160429194212.GP1881@hermes.click-hack.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Subject: Re: [Xenomai] Latency test shows weird results
Reply-To: florian.richer@upmc.fr
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai@xenomai.org

Hello and sorry for the delay,

It seems to be isolated; The previous line displayed shows a best =

latency just above 0.

i tried to get a trace to show the problem but with the patch you =

mentioned, the trace is flooded with calls to xnclock_ticks_to_ns =

(called from xntimer_update_date in the while)

I rolled back to xenomai 2.6.4 for now and got a trace (attached) =

corresponding to these results :
RTS|    -121.330|    1.927|    94.445|    33040|     0| 16:17:44

Thanks again for your help

Le 29/04/2016 =E0 21:42, Gilles Chanteperdrix a =E9crit :
> On Thu, Apr 28, 2016 at 05:03:59PM +0200, Florian Richer wrote:
>> Hello,
>>> This is very much likely the issue fixed by this patch:
>>> https://git.xenomai.org/xenomai-3.git/commit/?h=3Dstable-3.0.x&id=3Db41=
88f68e9ac7c9e9da25cf57d9756f0ccb78f4d
>>>
>>> You may want to try Xenomai 3.0.2 to see if you still have the
>>> problem.
>> Xenomai 3.0.2 does indeed correct the "offset" caused by the overrun.
>>> Note that if it is the problem, the real problem is that you have
>>> latencies close to 100us, which should not happen on such a
>>> processor.
>> My latencies were probably caused by CONFIG_COMPACTION, which is now
>> disabled; After a full day of latency testing my maximum latencies are
>> now fine, but the min was at around -1000000us (-1s), any idea where
>> that could come from ? (dmesg and .config attached if it helps)
>>> To get useful traces with the I-pipe tracer, you should increase the
>>> number of "back trace points".
>> Thanks for your help !
> Has the minimum drifted slowly over time, or is this an isolated
> spot?
>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: trace.zip
Type: application/x-zip-compressed
Size: 249876 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20160504/4bf05dcd/at=
tachment.bin>
