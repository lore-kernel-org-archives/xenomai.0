Date: Mon, 19 Aug 2019 02:25:52 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <2460589.8959950.1566199552136.JavaMail.zimbra@wolfram.com>
In-Reply-To: <CAEmXcAwN1B_9FJyDsOuPHP+Eqw8p--6u2kFDKTNcogtskX49CQ@mail.gmail.com>
References: <CAEmXcAzKYTm-ExSxnU6XDuD6evBb4S_=NDQFLO7N8d6V1dtU7A@mail.gmail.com>
 <1320236447.8271136.1565956912620.JavaMail.zimbra@wolfram.com>
 <CAEmXcAwN1B_9FJyDsOuPHP+Eqw8p--6u2kFDKTNcogtskX49CQ@mail.gmail.com>
Subject: Re: Differences of Roundtrip time, latency between Xenomai 2 and
 Xenomai 3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: danwe <daniel.wenninger92@gmail.com>
Cc: xenomai <xenomai@xenomai.org>




----- Den 17 aug 2019, p=C3=A5 kl 12:13, danwe daniel.wenninger92@gmail.com=
 skrev:

> Hello Per,

Hello!
I'll re-add the list to my answer.

> thanks for your reply. It helped me a lot. But you did not really answer =
my
> question regarding the jitter:
> > 2. I have seen some big difference in jitter between Xenomai 2 / RTnet =
and
> > Xenomai 3 without RTnet while testing the latency. Xenomai 3 does have =
a
> > much smaller jitter than Xenomai 2 / RTnet. Can you tell me where exact=
ly
> > the difference come from?

> So why exactly is the Jitter of Xenomai 2 bigger than Xenomai 3? Just bec=
ause
> some intern improvements on Xenomai 3? Which improvements?

I don't know the answer to this, perhaps someone else does?

Your exact setup for comparing things matters a lot, as well as how you per=
formed the test. For the high-jitter case I would make sure that I have no =
accidental dropouts to secondary mode (non realtime) etc.=20

Another complicating factor is that there have been improvements in the reg=
ular Linux kernel too (e.g. PREEMT_RT) that improves the native real-time p=
erformance so kernel version and configuration matters a lot. A regular Lin=
ux kernel fully patched with the PREEMT_RT patches has quite good real time=
 performance in itself.=20

> And one more questioin: If Xenomai 3 without RTnet uses the normal Linux =
Kernel,
> why are my roundtrip times faster than on Debian system?

I cant answer this either exactly, but if you use Xenomai and regular netwo=
rk you are only using the driver part (kernel space) of the Linux kernel. W=
hen doing it using a regular Linux process you are in Linux user space and =
then your process is treated just as any other process. You could give your=
 process higher priority and things should improve a bit, but to give a goo=
d answer one would need to know exactly how the test was setup and how the =
system with kernels are configured which is kind of out of scope for this a=
nswer.

B.t.w, if you send messages using Xenomai on a regular network card and use=
 a blocking call you will most definitely end up in secondary mode and loos=
e real time for that thread/process and everything related by inter process=
 locks etc., but if it's only for the round trip test i guess it doesn't ma=
tter.=20

> Kind regards

> Daniel Wenninger

> Am Fr., 16. Aug. 2019 um 14:01 Uhr schrieb Per Oberg < [ mailto:pero@wolf=
ram.com
> | pero@wolfram.com ] >:

>> ----- Den 16 aug 2019, p=C3=A5 kl 10:17, xenomai [ mailto:xenomai@xenoma=
i.org |
>> xenomai@xenomai.org ] skrev:

>> > Hello,

>> > I have made a comparison for Roundtrip time between Xenomai 2 / RTnet,
>> > Xenomai 3 and Debian distribution. I would like to ask you some specif=
ic
>> > questions as I am not sure.

>> > 1. I have read that Xenomai does work on Linux and the Interrupt Pipel=
ine
>> > does know which message is for real-time (Xenomai) and which not (Debi=
an).
>> > As I am copy Xenomai on a SD-Card am I just using real-time messages o=
r is
>> > it also possible to use non-real-time messages? Does Xenomai need Debi=
an
>> > distribution or can it work by itself?

>> You would probably need at least a small Linux distribution.
>> Xenomai does not now how to talk to all hardware there is, e.g. read wri=
te to
>> disk or allocate memory etc. so someone else has to do that. And just to=
 be
>> clear, let's differentiate between a Linux kernel and a GNU/Linux OS. Th=
e
>> programs you write needs libraries with common functions, for example ma=
th
>> functions or stdio or similar and these are not part of the Linux kernel=
. They
>> are most often GNU (or from other sources).

>> And also, the Xenomai kernel IS a Linux kernel with some addons to handl=
e
>> interrupts and some of the hardware.

>> If you really want to slim down you would need

>> a) A Xenomai Linux kernel (would boot on its own, but may also need some=
 help
>> with loading firmware blobs for certain hardware)
>> b) A Xenomai compiled application. I guess if it's statically linked you=
 could
>> actually get away with running that instead of the regular init.

>> But in most cases you also need

>> c) A minimal Linux distribution, possibly just something to be able to l=
oad
>> drivers, set the time etc. (See for example Yocto/Openembedded that can =
run
>> busybox)
>> d) Some Xenomai runtime software like dynamically linked libraries for c=
ode you
>> haven't statically linked and some software for controlling Xenomai driv=
ers
>> such as rtcan etc.

>> > 2. I have seen some big difference in jitter between Xenomai 2 / RTnet=
 and
>> > Xenomai 3 without RTnet while testing the latency. Xenomai 3 does have=
 a
>> > much smaller jitter than Xenomai 2 / RTnet. Can you tell me where exac=
tly
>> > the difference come from?

>> > 3. I have also seen that the Roundtrip time for Xenomai 3 is twice the=
 size
>> > of Xenomai 2 / RTnet. So my question is: I thought that RTnet ist just=
 for
>> > synchronization and TDMA. Does RTnet also make it "more" real-time tha=
n
>> > Xenomai 3 itself?

>> Lets see if I can clarify things a bit. Perhaps it will answer some of y=
our
>> questions indirectly.

>> First, with regards to networking there are simply put two driver varian=
ts to
>> choose from in Xenomai, the regular Kernel driver or the RTNet driver.

>> The regular kernel driver is handled by the regular kernel which is allo=
wed to
>> process data when Xenomai thinks its fitting to do so. The RTNet driver =
is
>> handled directly by Xenomai. The problem with handing over things to the
>> regular kernel is that it might have other things that it thinks it need=
s to to
>> while in charge of the CPU, so this should give a bit more random behavi=
or. If
>> we decide to wait for an answer/result we may be waiting a long time if =
the
>> Linux kernel has other things to do so we may miss or deadline.

>> Secondly, when programming for Xenomai you may choose a skin of your lik=
ing.
>> When using the posix skin you may write posix UDP/TCP code for sending/r=
eading
>> a socket regardless of if its a RTNet driver or a regular driver. Xenoma=
i
>> should use the correct function automatically, but if it doesn't you may=
 use
>> macros or special functions with prefixes (__STD or __COBALT).

>> In practice this means that sending a UDP message from Xenomai on a netw=
ork card
>> that has the RTNet driver loaded is completely handled by the real time =
part
>> while sending on network card that has the regular Linux driver will nee=
d
>> regular Linux kernel to step in.

>> > Kind regards

>> > Daniel

>> Best regards
>> Per =C3=96berg

Per =C3=96berg=20

