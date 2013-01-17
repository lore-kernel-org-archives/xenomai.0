Message-ID: <50F7AF53.2090800@xs4all.nl>
Date: Thu, 17 Jan 2013 08:59:15 +0100
From: Bas Laarhoven <sjml@xs4all.nl>
MIME-Version: 1.0
References: <4D4F8D1B-022E-47F8-A579-EBF2A3427C5D@mah.priv.at>
	<50F6D940.3040406@xs4all.nl>
	<F1ACE4FC-3E71-4498-B683-81F5C40CB6E3@mah.priv.at>
In-Reply-To: <F1ACE4FC-3E71-4498-B683-81F5C40CB6E3@mah.priv.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [Emc-developers] "new RTOS" status: Scheduler (?)
	lockup on ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: EMC developers <emc-developers@lists.sourceforge.net>
Cc: xenomai@xenomai.org

On 16-1-2013 20:36, Michael Haberler wrote:
> Am 16.01.2013 um 17:45 schrieb Bas Laarhoven:
>
>> On 16-1-2013 15:15, Michael Haberler wrote:
>>> ARM work:
>>>
>>> Several people have been able to get the Beaglebone ubuntu/xenomai se=
tup working as outlined here: http://wiki.linuxcnc.org/cgi-bin/wiki.pl?Be=
agleboneDevsetup
>>> I have updated the kernel and rootfs image a few days ago so the kern=
el includes ext2/3/4 support compiled in, which should take care of two f=
ailure reports I got.
>>>
>>> Again that xenomai kernel is based on 3.2.21; it works very stable fo=
r me but there have been several reports of 'sudden stops'. The BB is a b=
it sensitive to power fluctuations but it might be more than that. As for=
 that kernel, it works, but it is based on a branch which will see no fur=
ther development. It supports most of the stuff needed to development; th=
ere might be some patches coming from more active BB users than me.
>> Hi Michael,
>>
>> Are you saying you don't have seen these 'sudden stops' yourself?
> No, never, after swapping to stronger power supplies; I have two of the=
se boards running over NFS all the time. I dont have Linuxcnc running on =
them though, I'll do that and see if that changes the picture. Maybe keep=
ing the torture test running helps trigger it.

Beginners error! :-P The power supply is indeed critical, but the=20
stepdown converter on my BeBoPr is dimensioned for at least 2A and=20
hasn't failed me yet.

I think that running linuxcnc is mandatory for the lockup. After a dozen=20
runs, it looks like I can reproduce the lockup with 100% certainty=20
within one hour.
Using the JTAG interface to attach a debugger to the Bone, I've found=20
that once stalled the kernel is still running. It looks like it won't=20
schedule properly and almost all time is spent in the cpu_idle thread.

The kernel with extra diagnostics produces these messages:

[ 3480.386342] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"=20
disables this message.
[ 3480.395913] INFO: task axis:799 blocked for more than 120 seconds.
[ 3480.406643] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"=20
disables this message.
[ 3600.408670] INFO: task hal_manualtoolc:788 blocked for more than 120=20
seconds.

On one run I was able to re-issue a command from the command history=20
before that console froze too.
Since the x86 version seems to be having none of these problems, it=20
might be ARM specific.
Any suggestions on how to proceed? Are other people working on the ARM=20
version?

I'm also sending this message to the xenomai mailing list as that might=20
be a better place to resume this thread.

-- Bas

>
> NB there is an ipipe trace option, but that doesnt help if you cant tal=
k to the damn thing.
>  =20
>> My system has frozen within one hour every time.
>> I'm aware of the power supply issues, but my configuration has _never_=
 experienced this problem over at least half a year of (heavy) use.
> just to clarifiy: you get the lockups only with the Xenomai kernel, I a=
ssume ? your other option is some Angstr=F6m kernel or what exactly (isn'=
t the list of options bewildering ;-?)
>
>> So I dare say that isn't the problem, at least not with my lock-ups I'=
m seeing.
>>
>> Currently I'm debugging the kernel to see what's going on. It looks li=
ke the kernel is idling, but the system is completely frozen (blocked, no=
t scheduling?).
>> I've built a kernel with symbols a lot of extra debug options and am w=
aiting for it to stop again right now. It's been running axis with the de=
mo for almost an hour, the best result up to now...
>>
>> Do you have an opinion on what would be the best kernel version for (f=
uture) development? Is Xenomai up with the current kernels? Are the DT ke=
rnels usable on the bone or do we have to wait another couple of months f=
or that?
> again it's a question of matching a Xenomai patch version with a stable=
 base version, and have the itimer support in it - that's what reduces th=
e range of options
>
> there are several base versions one could try; the integration towards =
mainline is now targeted at 3.8 and it seems the stock kernel has much of=
 what is needed including PRUSS. It's also possible that the current Xeno=
mai work for a 3.5.x base results in a match, I need to look into it. I w=
as suggested to 'forward port the ipipe patch myself' but I chickened out=
 on that one.
>
> summary: I'm pretty sure there is; I am not aware of tangible results.
>
> I will push the two patches I got from Stephan Kappertz and Sheng Chao =
Wong, I dont think they are online.
>
> - Michael
>
>
>> -- Bas
>>
>> Yes! Frozen Bone after 56 minutes uptime : ) Time to start debugging a=
gain!
>>
>>> Charles has done some great work for a high-speed stepgen on the Beag=
lebone, and a few folks have reproduced that, but I leave the fanfare to =
Charles here;)
>>>
>>> I have done no further work on the Raspberry, I do not consider that =
platform particularly useful to base work on.
>>>
>>> RTAI note:
>>>
>>> I was pointed to this thread recently, which is interesting to read f=
or several reasons:
>>> https://mail.rtai.org/pipermail/rtai/2012-December/thread.html  "Git =
repository for RTAI"
>>>
>>> It does mention a Ubuntu 12.04 RTAI kernel (Shahbaz Youssefi shabbyx =
at gmail.com Tue Dec 18 11:09:41 CET 2012) - it might be worth following =
that up, maybe this is an option to get the current builds out of the 10.=
04 end-of-support-life situation. I would appreciate if somebody more RTA=
I-aware than me would pick that up.
>>>
>>> It also touches on the issue how the source repository and collaborat=
ion model touches upon a project's success, and that's an interesting rea=
d. It looks like the nature of open source communities changes due to for=
 instance the github model, making it easier for the casual contributor, =
which is a sore spot with the linuxcnc proejct. Something to think about.
>>>
>>> - Michael
>>>
>>>
>>>
>>> ---------------------------------------------------------------------=
---------
>>> Master Java SE, Java EE, Eclipse, Spring, Hibernate, JavaScript, jQue=
ry
>>> and much more. Keep your Java skills current with LearnJavaNow -
>>> 200+ hours of step-by-step video tutorials by Java experts.
>>> SALE $49.99 this month only -- learn more at:
>>> http://p.sf.net/sfu/learnmore_122612
>>> _______________________________________________
>>> Emc-developers mailing list
>>> Emc-developers@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/emc-developers
>
> -----------------------------------------------------------------------=
-------
> Master Java SE, Java EE, Eclipse, Spring, Hibernate, JavaScript, jQuery
> and much more. Keep your Java skills current with LearnJavaNow -
> 200+ hours of step-by-step video tutorials by Java experts.
> SALE $49.99 this month only -- learn more at:
> http://p.sf.net/sfu/learnmore_122612
> _______________________________________________
> Emc-developers mailing list
> Emc-developers@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/emc-developers


