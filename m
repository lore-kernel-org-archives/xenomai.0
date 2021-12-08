From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: RE: questions about comments on
 https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/33
Date: Wed, 8 Dec 2021 05:44:26 +0000
Message-ID: <MN2PR11MB428537A90BEDD278DC5E0176F26F9@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <BY5PR11MB4276970F873C8A411A7D555EF26E9@BY5PR11MB4276.namprd11.prod.outlook.com>
In-Reply-To: <BY5PR11MB4276970F873C8A411A7D555EF26E9@BY5PR11MB4276.namprd11.prod.outlook.com>
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
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>


>
>-----Original Message-----
>From: Chen, Hongzhan
>Sent: Tuesday, December 7, 2021 11:11 AM
>To: xenomai@xenomai.org<mailto:xenomai@xenomai.org>; Jan Kiszka jan.kiszka=
@siemens.com<mailto:jan.kiszka@siemens.com>
>Subject: questions about comments on https://gitlab.com/Xenomai/xenomai-ha=
cker-space/-/issues/33
>
>Hi Jan
>
>I have some questions about comments on  https://gitlab.com/Xenomai/xenoma=
i-hacker-space/-/issues/33 and need your help to comment more.
>
>1. I do not quite understand the requirement "visualize task switches corr=
ectly in Kernelshark (color in CPU bar is not updating on cobalt_switch_con=
text)".
>
>When I click the cobalt_switch_context event listed in the event table on =
the second half in the kernelshark, actually color in cpu bar is updating t=
o
>green because there is long green vertical  line to mark focused event lik=
e attached picture.  In addition , In spite of focused thing,  colors mainl=
y
>change depending on what task is running for cpu plots in kernelshark. whe=
n cobalt_switch_context is traced, it still be in the prev context and its
>color is same with task prev in kernelshark. Do we want to update color of=
  cobalt_switch_context  to specific color different from all tasks even if=
 there is no
>focused thing?  What result do we need to achieve when there is cobalt_swi=
tch_context, Could you be more specific?

After I understand what does means about sched_switch in kernelshark, I gue=
ss that we need to use cobalt_switch_context as dividing line for RT/non-RT=
 tasks similar with sched_switch after we use xenomai.

Regards

Hongzhan Chen

>
>2. Regarding  the requirement " visualize RT/Non-RT (out-of-band/in-band) =
state in CPU bar)",
>    2.1. Do we need to differentiate state  running a Linux task out-of-ba=
nd and running whatever code from the out-of-band execution stage as descri=
bed in
>             " What you really need to know at this point" of  https://evl=
project.org/dovetail/altsched/?
>    2.2 What state do we want to show  in CPU bar? Different color coverin=
g the size of  RT/Non-RT state other than all tasks and CPUs?  If so, we ma=
y ask for a plugin
>          in kernelshark , which would raise similar question as you menti=
oned in comments.
>
>For the other two aspects, I still need more time to do research.
>
>
>Regards
>
>Hongzhan Chen
