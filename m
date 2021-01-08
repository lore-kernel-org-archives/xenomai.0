Subject: Re: [CXP] some questions about "Common Xenomai Platform"
References: <ce09c464-b17f-a977-2638-c0fb1f3bcdf4@yeah.net>
 <874kjxrkeb.fsf@xenomai.org>
 <2461fe05.185d.176dd8ca994.Coremail.hailongliiu@yeah.net>
 <CALLqZ8RPFrAFO=NCqGmyvWSWKTje3siXAOcLWp9y1uu2QBRupw@mail.gmail.com>
From: Hailongliu <hailongliiu@yeah.net>
Message-ID: <18a08b14-003e-aaab-f59f-d83a1913d5e7@yeah.net>
Date: Sat, 9 Jan 2021 07:43:58 +0800
MIME-Version: 1.0
In-Reply-To: <CALLqZ8RPFrAFO=NCqGmyvWSWKTje3siXAOcLWp9y1uu2QBRupw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 1/7/21 11:59 PM, Greg Gallagher wrote:
> 
> 
> On Thu, Jan 7, 2021 at 10:53 AM hailong via Xenomai <xenomai@xenomai.org <mailto:xenomai@xenomai.org>> wrote:
> 
>     At 2021-01-04 01:38:04, "Philippe Gerum" <rpm@xenomai.org <mailto:rpm@xenomai.org>> wrote:
>     >
>     >Hailongliu via Xenomai <xenomai@xenomai.org <mailto:xenomai@xenomai.org>> writes:
>     >
>     >> Hi,
>     >>
>     >> I learned the "Common Xenomai Platform" program from this mail-list and wiki
>     >> of project Xenomai. This is a very attractive plan, as it will port Xenomai for
>     >> recent LTS kernel(v5.10).
>     >>
>     >> I noticed that  March 31, 2021 is the deadline for "CXP", dose that mean we
>     >> can expect the new features at Xenomai-3.3 ?
>     >
>     >Yes, that is the plan. Xenomai 3.3 is going to be the first release
>     >fully implementing the CXP. Xenomai 4 which is going to use a different
>     >real-time core will be developed in parallel to Xenomai 3.3, aiming at
>     >CXP-compliance too. It should be clear that March 31, 2021 is the date
>     >for completing the CXP specification, not that of any release
>     >implementing it, which can only happen later by definition.
>     >
> 
>     Will the CXP or Xenomai 4 compatible with RT-patch over time?
>     In addition,   I learned that the legacy RTOS emulators (such as VxWorks)
>     will be excluded from Xenomai 3.x , neither Xenomai 4?
> 
> That is correct, we don't have the resources to continue to support the RTOS emulators.  I believe it was left open that if someone
> wants to take this on as a maintainer they could be included.
> 

Thank you for your kind reply.

Our work team members now are hesitating about which kernel version to choose
as our development baseline for Xenomai between linux-5.10 and linux-5.4,
because we find that there is a evl branch based on linux-5.4 but not for
linux-5.10 currently. 

And we also want to know the compatibility between the Xenomai4 and rt-patch.

So, could you kind give me some advice for that?
 
> 
>     >> I also concern about that how long Xenomai-3.3 will be live? And if there
>     >> will be a long term version with kernel-v5.10 for Xenomai?
>     >>
>     >
>     >Xenomai will run v5.10 LTS as soon as release 3.2, based on the ongoing
>     >port of the Cobalt core to Dovetail.
>     >
>     >How long a particular Xenomai release is maintained for a particular
>     >kernel version currently depends on a few individuals and companies
>     >having a specific requirement to keep such port alive, and contributing
>     >to this task directly (doing the work) or indirectly (funding someone
>     >else's work).
>     >
>     >Although there is a commitment to run Xenomai 3.x on top of kernel v5.10
>     >asap, I'm not aware of any formal commitment of any current contributor
>     >to maintain this port for a pre-defined period of time. One may only
>     >assume that by picking a LTS kernel like v5.10, we are likely going to
>     >maintain it "for some time".
>     >
> 
>     Thanks.
> 
> 
> Thanks
> 
> Greg 


