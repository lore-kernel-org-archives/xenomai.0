From: Lange Norbert <norbert.lange@andritz.com>
Subject: Re: running xenomai through scan-build or: some 100 issues 
Date: Mon, 14 Oct 2019 10:01:17 +0000
Message-ID: <VI1PR05MB591754A5C64BAE6292DD6184F6900@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

> -----Original Message-----

> From: Xenomai <xenomai-bounces@xenomai.org<mailto:xenomai-bounces@xenomai=
.org>> On Behalf Of Jan Kiszka

> via Xenomai

> Sent: Montag, 14. Oktober 2019 08:26

> To: Norbert Lange <nolange79@gmail.com<mailto:nolange79@gmail.com>>; Xeno=
mai <xenomai@xenomai.org<mailto:xenomai@xenomai.org>>

> Subject: Re: running xenomai through scan-build or: some 100 issues

> with static code analysis

>

> NON-ANDRITZ SOURCE: BE CAUTIOUS WITH CONTENT, LINKS OR ATTACHMENTS.

>

>

> On 13.10.19 21:49, Norbert Lange via Xenomai wrote:

> > Hello,

> >

> > I did run some static analysis tools over xenomai 3.1rc2 userspace

> > libraries, and there seems to be alot of real issues.

> >

> > The tools are clangs builtin statical analysis and clang-tidy,

> > naturally there is some overlap in the reports.

> > clang-tidy would need to be configured to fit Xenomai's practices

> > (there is a ton of configurable checks), so this is more of an example.

> > The other, clang's statical analysis is more relevant as there are

> > very few false positives.

> >

> > Additionally to the checks, there is a directory failures, files

> > that cant be built with clang. Even if no one ships Xenomai built by

> > that compiler, fixing those should help, for being able to run those

> > tools and several IDE's and Editors already use clangd for code competi=
tion etc.

> >

> > I'd hope that such reports could be incorporated into the CI builds.

> > running the analysis on cross-builds is alot more daunting, but on

> > native builds its rather easy.

>

> This is generally a valuable thing. Unfortunately, it starts with some

> more

> work: modelling of functions and syscalls that clang has no insight

> into and, thus, throws false-positives around them. Quickly browsing

> through the report, I only saw one real finding so far, and that was a

> harmless "assigned but never used" warning. But I'm sure that there

> are a few more severe issues in that haystack.



Did you look only at the tidy-report? The other, website based report has t=
ons of valid issues, and clang models POSIX/GNU functions - that's enough f=
or most of the code.



eg.:



utils/analogy/calibration_ni_m.c: use after free (your error() macro is bro=
ken).

lib/copperplate/heapobj-heapmem.c: heapobj_init_array_private with size=3D0=
 has undefined behavior



Every report I looked at seemed valid, those that are questionable, like he=
apobj_init_array_private Are questionable because it's not clear if this fu=
nction is allowed to be called with size=3D0.

Means it's questionable for everyone reading the code, and something an ana=
lyzer should throw up.

Its either a bug or some annotation would help (__builtin_expect(size !=3D =
0, 1) or assert(size !=3D 0)).



>

> I was already considering to enable Coverity via our CI. It generally

> works, it has proven to find real issues without too much modelling

> effort (though this case may be different because of all the custom

> syscalls), but since Synopsis bought it, the availability and quality

> of their public OSS service massively degraded.

>

> So, looking into clang might be a more reliable alternative. I'm open

> for patches that pave the way. For CI, we may need a more recent

> source than

> clang-6 because that is what Travis provides us ATM.



I dont have any experience with travis, but can't you just tell you want a =
recent Ubuntu/Debian?



Norbert



________________________________

This message and any attachments are solely for the use of the intended rec=
ipients. They may contain privileged and/or confidential information or oth=
er information protected from disclosure. If you are not an intended recipi=
ent, you are hereby notified that you received this email in error and that=
 any review, dissemination, distribution or copying of this email and any a=
ttachment is strictly prohibited. If you have received this email in error,=
 please contact the sender and delete the message and any attachment from y=
our system.

ANDRITZ HYDRO GmbH


Rechtsform/ Legal form: Gesellschaft mit beschr?nkter Haftung / Corporation

Firmensitz/ Registered seat: Wien

Firmenbuchgericht/ Court of registry: Handelsgericht Wien

Firmenbuchnummer/ Company registration: FN 61833 g

DVR: 0605077

UID-Nr.: ATU14756806


Thank You
________________________________
