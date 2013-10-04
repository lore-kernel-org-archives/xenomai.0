MIME-Version: 1.0
In-Reply-To: <201310041336.33020.paul_c@tuxcnc.org>
References: <CAK4EZFSLBBOs174xP+JAsqgJgG-MJ5UxMsj_FD5Pzjh1BHz7gw@mail.gmail.com>
	<52435E3D.7020202@xenomai.org>
	<201309261032.30542.paul_c@tuxcnc.org>
	<201310041336.33020.paul_c@tuxcnc.org>
Date: Fri, 4 Oct 2013 12:18:15 -0400
Message-ID: <CAK4EZFRUKBxu-sW68LoGF0w+PdoMxa2wK9eRB3-eYZPtFY_UDg@mail.gmail.com>
From: Adam Vaughan <vaughana@umich.edu>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Raspberry Pi patch issue?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul <paul_c@tuxcnc.org>
Cc: xenomai@xenomai.org

Hi Paul,

Thank you!  I really do appreciate your efforts putting the patches
together.  Just to get a rough idea what latency to expect, will these
patches achieve similar performance compared to the older patches for
Linux 3.5.7 provided at [1] and tested at [2]?  For quick reference,
I've attached the 24 hour GPIO latency test histogram under high load
from [2].

Finally, would like to just briefly mention that I think the Raspberry
Pi is a great hobbyist board for Xenomai to support because of it's
low cost and reasonably fast hardware FPU.  I've been really happy
with how easy it is to implement Xenomai code, and that incorporating
double precision matrix algebra support from the Eigen library has
been a breeze so far.

-Adam

[1]  http://www.blaess.fr/christophe/2013/02/15/raspberry-pi-interruptions-=
gpio-avec-rtdm
[2]  http://www.blaess.fr/christophe/2013/03/13/mesure-de-latences-dinterru=
ptions-gpio-rtdm

Note:  These pages are in French, but Google Translate (GT) does an
okay job translating them to English.  Only "okay" because it's
readable but GT replaces RTDM with TDGR and modifies some of the code.
 Nothing too terrible, just something to be aware of.

On Fri, Oct 4, 2013 at 8:36 AM, Paul <paul_c@tuxcnc.org> wrote:
> On Thursday 26 September 2013, Paul wrote:
>> On Wednesday 25 September 2013, Gilles Chanteperdrix wrote:
>> > On 09/24/2013 02:00 PM, Paul wrote:
>> > > On Tuesday 24 September 2013, Adam Vaughan wrote:
>> > >> I'm trying to build with the most recent xenomai-head in git for
>> > >> the Raspberry Pi, and I'm encountering an issue (see below) when
>> > >> I try to run prepare-kernel.sh .  I'm very new to this whole
>> > >> process (so it definitely could be user error), but it would
>> > >> seem that there's a problem with the patch.
>> > >
>> > > I'll have a look at it this evening and report back after making
>> > > a few checks.
>> >
>> > any news? Maybe I committed the wrong versions?
>>
>> My fault entirely - I used the wrong ipipe-core patch in preparing
>> the pre patch. Will have another look over the next couple of days
>> (trying to fit it in around work commitments).
>
> Apologies for the delay in looking at this. Please find updated patches.
>
> 1) Checkout kernel sources from git://github.com/raspberrypi/linux.git
> and use the rpi-3.8.y branch - d996a1b is the SHA-1 hash used, but
> later revisions should work.
> 2) Apply ipipe-core-3.8.13-raspberry-pre-2.patch
> 3) Apply ipipe-core-3.8.13-arm-2 patch
> 4) Apply ipipe-core-3.8.13-raspberry-post-2.patch
> 5) Resume generic installation instructions.
>
>
> Regards, Paul.
>
>
>
>
>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: ipipe-core-3.8.13-raspberry-post-2.patch
> Type: text/x-diff
> Size: 7296 bytes
> Desc: not available
> URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131004/60573=
d3c/attachment.patch>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: ipipe-core-3.8.13-raspberry-pre-2.patch
> Type: text/x-diff
> Size: 652 bytes
> Desc: not available
> URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131004/60573=
d3c/attachment-0001.patch>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Xenomai_Raspberry_Pi_high_load_24_hour_GPIO_latency_test.png
Type: image/png
Size: 5873 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131004/04d063e=
a/attachment.png>
