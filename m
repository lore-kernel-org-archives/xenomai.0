Date: Thu, 26 Jun 2014 13:19:49 +0200
From: Arnaud Degroote <arnaud.degroote@isae.fr>
Message-ID: <20140626111949.GA4486@dmia-degroote.isae.fr>
References: <20140624062309.GA9564@dmia-degroote.isae.fr>
 <53A91AC0.30801@xenomai.org>
 <20140624122129.GA18908@dmia-degroote.isae.fr>
 <53A9C41C.6020700@xenomai.org>
 <20140625081129.GA31341@dmia-degroote.isae.fr>
 <53AA8A35.7000506@xenomai.org>
 <20140625094715.GA26690@dmia-degroote.isae.fr>
 <53AB4BE3.2070302@xenomai.org>
 <20140626075607.GA32691@dmia-degroote.isae.fr>
 <53ABFF21.8010700@xenomai.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53ABFF21.8010700@xenomai.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Support of Beagleboard xm rev C on 3.14-ipipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 26/Jun - 13:08, Gilles Chanteperdrix wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 06/26/2014 09:56 AM, Arnaud Degroote wrote:
> > On 26/Jun - 00:23, Gilles Chanteperdrix wrote:
> >> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >> 
> >> On 06/25/2014 11:47 AM, Arnaud Degroote wrote:
> >>> On 25/Jun - 10:37, Gilles Chanteperdrix wrote:
> >>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >>>> 
> >>>> On 06/25/2014 10:11 AM, Arnaud Degroote wrote:
> >>>>> On 24/Jun - 20:31, Gilles Chanteperdrix wrote:
> >>>>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >>>>>> 
> >>>>>> On 06/24/2014 02:21 PM, Arnaud Degroote wrote:
> >>>>>>> On 24/Jun - 08:29, Gilles Chanteperdrix wrote:
> >>>>>>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >>>>>>>> 
> >>>>>>>> On 06/24/2014 08:23 AM, Arnaud Degroote wrote:
> >>>>>>>>> On 24/Jun - 01:45, Gilles Chanteperdrix wrote:
> >>>>>>>>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >>>>>>>>>> 
> >>>>>>>>>> On 06/23/2014 01:18 PM, Arnaud Degroote wrote:
> >>>>>>>>>>> On 23/Jun - 11:22, Gilles Chanteperdrix wrote:
> >>>>>>>>>>>> On 06/23/2014 11:08 AM, Arnaud Degroote
> >>>>>>>>>>>> wrote:
> >>>>>>>>>>>>> Hi list,
> >>>>>>>>>>>>> 
> >>>>>>>>>>>>> I'm trying to deploy a 3.14 kernel on my 
> >>>>>>>>>>>>> BeagleBoard XM rev C but got several
> >>>>>>>>>>>>> issues. So, first question, it is supposed
> >>>>>>>>>>>>> to be supported or am I somewhere in a grey
> >>>>>>>>>>>>> zone ?
> >>>>>>>>>>>>> 
> >>>>>>>>>>>>> Let describe more precisely the
> >>>>>>>>>>>>> configuration and the symptom. -
> >>>>>>>>>>>>> linux-ipipe branch ipipe-3.14 - xenomai
> >>>>>>>>>>>>> 2.6.3 + some patches from 2.6 branch
> >>>>>>>>>>>>> (including 
> >>>>>>>>>>>>> d1d00e0acd29bb5f9023494a883a7fa0def40917 
> >>>>>>>>>>>>> 41cb1f73814d1094e0ea75ccbbd23ff01280787e 
> >>>>>>>>>>>>> 7a48019268d7e1157ebb072b88f6683425f0c7c5 
> >>>>>>>>>>>>> f00d22eca6277e780c19a5d5ecd2ed0e23dabafe )
> >>>>>>>>>>>> 
> >>>>>>>>>>>> It is supposed to work, could you try again
> >>>>>>>>>>>> with the xenomai 2.6 git?
> >>>>>>>>>>>> 
> >>>>>>>>>>> 
> >>>>>>>>>>> Hi Gilles,
> >>>>>>>>>>> 
> >>>>>>>>>>> I just tested against 2.6-git and observe the
> >>>>>>>>>>> same behaviours.
> >>>>>>>>>>> 
> >>>>>>>>>>> Best regards,
> >>>>>>>>>>> 
> >>>>>>>>>> Could you post your configuration?
> >>>>>>>>> 
> >>>>>>>>> Sure, see the attached defconfig. It is basically 
> >>>>>>>>> yocto base arm kernel + xenomai (and some kernel 
> >>>>>>>>> hacking option).
> >>>>>>>>> 
> >>>>>>>>> 
> >>>>>>>> Could you try to turn off CONFIG_NO_HZ ?
> >>>>>>> 
> >>>>>>> Without CONFIG_NO_HZ, it hangs repeatably during the
> >>>>>>> boot (in the same place than with CONFIG_NO_HZ without
> >>>>>>>  CONFIG_DEBUG_LOCK_ALLOC, so this last option is more
> >>>>>>> a timing workaround than a "real fix"). See the
> >>>>>>> attached defconfig and boot log.
> >>>>>> 
> >>>>>> Do you have the same problem if you boot using NFS
> >>>>>> instead of an SD card?
> >>>>>> 
> >>>>> 
> >>>>> Using root on nfs does not seem to change the problem. It 
> >>>>> still hangs in the same place.
> >>>> 
> >>>> Ok, could you disable FTRACE, then enable the I-pipe debugs 
> >>>> except the I-pipe tracer? And enable all the xenomai debugs?
> >>>> 
> >>> 
> >>> Without FTRACE, the kernel seems to boot successfully quite
> >>> often (I won't say always still). Moreover, the clocktest now
> >>> terminates. Still, the latency hangs, without much debug
> >>> information (maybe I miss some options in the kernel
> >>> configuration or at runtime). At this moment,
> >>> /proc/xenomai/sched shows
> >>> 
> >>> root@beagleboard:~# cat /proc/xenomai/sched CPU  PID    CLASS
> >>> PRI TIMEOUT   TIMEBASE   STAT       NAME 0  0      idle    -1
> >>> - master     R          ROOT 0  391    rt       0      - master
> >>> X          switchtest 0  392    rt       0      - master     X
> >>> switchtest 0  405    rt       0      - master     X
> >>> display-393 0  406    rt      99      481us master     Dt
> >>> sampling-393 0  0      rt       1      - master     Wl
> >>> rtk1/0 0  0      rt       1      - master     Wl         rtk2/0
> >>> 0  0      rt       1      - master     Wlf        rtk3/0 0  0
> >>> rt       1      - master     Wlf        rtk4/0 0  0      rt
> >>> 1      - master     Wlf        rtk5/0 0  0      rt       1
> >>> - master     Wlf        rtk6/0 0  0      rt       1      - 
> >>> master     Wl         rtk1/0 0  0      rt       1      - master
> >>> Wl         rtk2/0 0  0      rt       1      - master     Wlf
> >>> rtk3/0 0  0      rt       1      - master     Wlf        rtk4/0
> >>> 0  0      rt       1      - master     Wlf        rtk5/0 0  0
> >>> rt       1      - master     Wlf        rtk6/0 0  417    rt
> >>> 1      - master     Wl         rtup0-7 0  419    rt       1
> >>> - master     Wl         rtup0-7 0  420    rt       1      - 
> >>> master     Wl         rtup0-8 0  421    rt       1      - 
> >>> master     Wl         rtup0-8 0  422    rt       1      - 
> >>> master     Wl         rtup_ufpp0-9 0  423    rt       1      - 
> >>> master     Wl         rtup_ufpp0-9 0  424    rt       1      - 
> >>> master     Wl         rtup_ufpp0-10 0  426    rt       1
> >>> - master     Wl         rtup_ufpp0-10 0  427    rt       1
> >>> - master     X          rtus0-11 0  428    rt       1      - 
> >>> master     X          rtus0-11 0  429    rt       1      - 
> >>> master     X          rtus0-12 0  430    rt       1      - 
> >>> master     X          rtus0-12 0  432    rt       1      - 
> >>> master     X          rtus_ufps0-13 0  433    rt       1
> >>> - master     X          rtus_ufps0-13 0  434    rt       1
> >>> - master     X          rtus_ufps0-14 0  435    rt       1
> >>> - master     X          rtus_ufps0-14 0  436    rt       1
> >>> - master     X          rtuo0-15 0  437    rt       1      - 
> >>> master     X          rtuo0-15 0  438    rt       1      - 
> >>> master     X          rtuo0-16 0  439    rt       1      - 
> >>> master     X          rtuo0-16 0  440    rt       1      - 
> >>> master     X          rtuo_ufpp0-17 0  441    rt       1
> >>> - master     X          rtuo_ufpp0-17 0  442    rt       1
> >>> - master     Wl         rtuo_ufpp0-18 0  443    rt       1
> >>> - master     X          rtuo_ufpp0-18 0  444    rt       1
> >>> - master     Wl         rtuo_ufps0-19 0  445    rt       1
> >>> - master     X          rtuo_ufps0-19 0  446    rt       1
> >>> - master     Wl         rtuo_ufps0-20 0  447    rt       1
> >>> - master     X          rtuo_ufps0-20 0  448    rt       1
> >>> - master     Wl         rtuo_ufpp_ufps0-21 0  450    rt
> >>> 1 -         master     X          rtuo_ufpp_ufps0-21 0  451
> >>> rt 1      -         master     Wl         rtuo_ufpp_ufps0-22 0
> >>> 452 rt       1      -         master     X
> >>> rtuo_ufpp_ufps0-22
> >> 
> >> You are not just running latency, you are running latency and
> >> switchtest.
> >> 
> >> Could you try and run the latency test alone? Please proceed one
> >> step at a time.
> > 
> > Yes, sorry for that, I use xeno-regression-test directly.
> > 
> > latency seems to work properly. switchtest with the default
> > argument hangs quite fast. switchtest -s 1000 seems to survive long
> > time.
> > 
> > Concerning your previous mail, any easy way to test GP timer I'm
> > not aware about or must I write some kind of test kernel module ?
> > 
> If the latency test works, the GP timer works, no need to test it.
> 
> switchtest is another story. Does switchtest hang, or does the system
> completely freeze?

switchtest hangs, but the system is still responsive. I can ctrl-c
it and restart it. On C-c, it prints "properly" a number of ctx switches
done (which is far from other "normal" values).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140626/c22ec378/attachment.sig>
