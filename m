From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <4ffc41e4-c59d-9886-d37d-71395c8275d8@siemens.com>
Content-Type: text/plain; charset="utf-8"
Date: Thu, 29 Jul 2021 09:32:00 +0200
MIME-Version: 1.0
Message-ID: <10a0-61025980-117-29fb8780@204571764>
Subject: =?utf-8?q?Re=3A?==?utf-8?q?_=5BPATCH?==?utf-8?q?_v2=5D?= Enable
 retrieving 
 of RTNET network packet timestamp OOB using =?utf-8?q?recvmsg=28=29?=
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

Le Mardi, Juillet 27, 2021 18:44 CEST, Jan Kiszka <jan.kiszka@siemens.c=
om> a =C3=A9crit: 
 
> On 27.07.21 14:13, Fran=C3=A7ois Legal wrote:
> > Le Lundi, Juillet 26, 2021 14:01 CEST, Jan Kiszka <jan.kiszka@sieme=
ns.com> a =C3=A9crit: 
> >  
> >> On 17.05.21 11:44, Fran=C3=A7ois Legal via Xenomai wrote:
> >>> This patch enables retrieving, in realtime application, of RTNET =
enabled adapters packet timestamps.
> >>> It uses the linux semantic SO=5FTIMESTAMPNS, and the linux code t=
o put the timestamp in the control=5Fmsg structure.
> >>>
> >>> I tested this patch with af=5Fpacket sockets only. UDP  & TCP mig=
ht be a little bit trickier as many fragment/segments get reassembled i=
n a single recvmsg. I believe the linux code I used to put the timestam=
ps in the control structure should be OK though.
> >>
> >> One of my question on v1 is still open: How does Linux handle stam=
ping
> >> the context of fragmented UDP and TCP packets? And given that you =
enable
> >> it for those protocols as well, we should likely test that too.
> > 
> > I thought I already gave an answer to this. Sorry.
> > Linux does not handle time stamping of UDP and TCP as far as I unde=
rstand.
> 
> Does Linux return an error when you try to enable this for UDP or TCP=

> sockets?

Alright so I rechecked everything again. Linux does not return an error=
 when requesting timestamping for UDP or TCP (or any other kind of sock=
et it seems).

Despite my previous assertion, timestamping is supported for UDP  and i=
f I understood the code correctly, only one timestamp is returned in an=
y case (the time stamp of the last received datagram). This is done in =
reassembly queues, where the queue always keep the timestamp of the las=
t received datagram, and when doing the reassembly, this last timestamp=
 is reported to the re created skb.

For TCP it is definitely not supported.

So I should modify the patch to make it comply with what linux does I g=
uess ?

> 
> > I certainly plan to use the UDP timestamping feature at some point =
in the future, but maybe I can exclude UDP and TCP for the moment, and =
stick to af=5Fpacket which has be tested by myself. I'll resubmit anoth=
er patch with (at least) udp support whenever I need it and have time t=
o test it.
> > 
> > What do you think ?
> 
> We need at least a plan how to evolve that interface. Actually doing
> that can then happen in steps, yes.
> 
> Jan
> 
> -- 
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux


