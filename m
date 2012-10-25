Message-ID: <50898E1A.5010908@xenomai.org>
Date: Thu, 25 Oct 2012 21:08:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANzNmi8DYqXmwtGe+Nu_HnLC8KgRO=H-29p6QBrjWrawreK_ig@mail.gmail.com>	<508837F9.9060904@xenomai.org>	<CANzNmi8qKWz2PwyS0e_fchO7xpcsq_a0yqDYbuiRU_PYVjsvQA@mail.gmail.com>	<50883F34.4010604@xenomai.org>	<CANzNmi-7SKy9HS=5g63=aMom1KsO_ZmxkdULe2gAteuPsuW+_A@mail.gmail.com>	<50895B51.60409@xenomai.org>	<CANzNmi_0j7sFOBpLSdsyAgbsdvcRdB=3448nMpoTDQiq_wg+=A@mail.gmail.com>	<50895CFB.6090602@xenomai.org>
	<CANzNmi_V-qEXhob68AteDC1s=s8kqRUE8B9_meE8XGx2UEpBrg@mail.gmail.com>
In-Reply-To: <CANzNmi_V-qEXhob68AteDC1s=s8kqRUE8B9_meE8XGx2UEpBrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Problem trying an example for the first time.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sebastian Pavez <sebastian.pavez.t@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 10/25/2012 08:04 PM, Sebastian Pavez wrote:

> 2012/10/25 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> 
>> On 10/25/2012 05:35 PM, Sebastian Pavez wrote:
>>> 2012/10/25 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>>> What does apt-cache show xenomai-runtime say?
>>>
>>>
>>> Package: xenomai-runtime
>>> Version: 2.5.5.2-1ubuntu2
>>
>> So, is it more clear, now ?
>>
>> --
>>                                             Gilles.
>>
> I think so, I found the 2.6.0 version of xenomai-runtime, but when I try it
> I get the error (user-space requires '3', kernel provides '4'). In the
> forum I found a previous answer of you about the same branch of
> kernel-space and user-space. So I search for xenomai-runtime 2.6.0, but
> what I get it's an experimental package ... I really don't wanna something
> like that because of my lack of experience ... I should try to use xenomai
> 2.6.0 instead of the 2.6.1 I'm using now??


First, the error (user-space requires '3', kernel provides '4') and the
case of ubuntu is described here:
http://www.xenomai.org/documentation/xenomai-2.6/html/TROUBLESHOOTING/#_xenomai_incompatible_abi_revision_level
In a nutshell you are still mixing xenomai 2.6 with xenomai 2.5.

Second, 2.6.0 is not an experimental release, it is a stable release,
but obsolete, you should install xenomai 2.6.1 now.

Third, to install xenomai 2.6.1. You should first uninstall any Ubuntu
packages concerning xenomai. That is a mandatory prerequisite, do not
even read further until you have done that.

Then you have two solutions:
- install it by following README.INSTALL or the quick build guide,
compiling manually the kernel and the user-space, there is nothing
really complicated about that, the part that could be a bit hard, as you
figured out is the configure the kernel, but you always have to do that
anyway ;
- install it by generating Debian packages (but I wrote generating, not
download from a repository) following the instructions here:
http://www.xenomai.org/index.php/Building_Debian_packages. What you will
gain by doing that is that you will generate the packages once, and be
able to install them on many machines. And that the packages are
integrated in the Debian distribution, so, apt-get remove allows
uninstalling everything.

-- 
                                                                Gilles.

