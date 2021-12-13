From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: RE: questions about comments on
 https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/33
Date: Mon, 13 Dec 2021 02:37:17 +0000
Message-ID: <MN2PR11MB4285148014996C770370B416F2749@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <BY5PR11MB4276970F873C8A411A7D555EF26E9@BY5PR11MB4276.namprd11.prod.outlook.com>
 <24acf7bd-1e34-a094-7853-9ad1602d8ddf@siemens.com>
 <MN2PR11MB4285BDFDBBA5193F5586B42AF2749@MN2PR11MB4285.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB4285BDFDBBA5193F5586B42AF2749@MN2PR11MB4285.namprd11.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>



=20
>>-----Original Message-----
>>From: Jan Kiszka <jan.kiszka@siemens.com>=20
>>Sent: Thursday, December 9, 2021 5:35 PM
>>To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>>Subject: Re: questions about comments on https://gitlab.com/Xenomai/xenom=
ai-hacker-space/-/issues/33
>>
>>On 07.12.21 04:11, Chen, Hongzhan wrote:
>>> Hi Jan
>>>=20
>>> I have some questions about comments on  https://gitlab.com/Xenomai/xen=
omai-hacker-space/-/issues/33 and need your help to comment more.
>>>=20
>>> 1. I do not quite understand the requirement "visualize task switches c=
orrectly in Kernelshark (color in CPU bar is not updating on cobalt_switch_=
context)".
>>>=20
>>> When I click the cobalt_switch_context event listed in the event table =
on the second half in the kernelshark, actually color in cpu bar is updatin=
g to=20
>>> green because there is long green vertical  line to mark focused event =
like attached picture.  In addition , In spite of focused thing,  colors ma=
inly=20
>>> change depending on what task is running for cpu plots in kernelshark. =
when cobalt_switch_context is traced, it still be in the prev context and i=
ts=20
>>> color is same with task prev in kernelshark. Do we want to update color=
 of  cobalt_switch_context  to specific color different from all tasks even=
 if there is no=20
>>> focused thing?  What result do we need to achieve when there is cobalt_=
switch_context, Could you be more specific?
>>>=20
>>
>>I assume this one is resolved now, at least regarding what the goal
>>would be.
>>
>>> 2. Regarding  the requirement " visualize RT/Non-RT (out-of-band/in-ban=
d) state in CPU bar)",
>>>     2.1. Do we need to differentiate state  running a Linux task out-of=
-band and running whatever code from the out-of-band execution stage as des=
cribed in=20
>>>              " What you really need to know at this point" of  https://=
evlproject.org/dovetail/altsched/?
>>>     2.2 What state do we want to show  in CPU bar? Different color cove=
ring the size of  RT/Non-RT state other than all tasks and CPUs?  If so, we=
 may ask for a plugin
>>>           in kernelshark , which would raise similar question as you me=
ntioned in comments.
>>
>>I suspect it would be best to decouple to stage state (in-band, oob)
>>from the current task, maybe by adding another bar underneath the task
 >bar for each CPU that shows this state.
>
>What about painting a hollow blue box under the baseline of corresponding =
task=20
>to mark running in OOB state, starting from first cobalt_switch_context sw=
itching
>task in  to next cobalt_switch_context switching it out like attached pic?

The hollow box is commonly used in task plot such as hollow green box for w=
ake up latency
as described in page 15 of [1].

Regards

Hongzhan Chen


[1]: https://elinux.org/images/6/64/Elc2011_rostedt.pdf


>
>>
>>In fact, visualizing the dovetail state could be seen as another use
>>case for visualizing things like interrupt masks of preemption locks
>>that Linux upstream has. Maybe there are already ideas or even bits to
>>make that possible, and would could re-used them. Or we could sell our
>>demand via enabling those other scenarios as well...
>>
>>Jan
>>
>>--=20
>>Siemens AG, T RDA IOT
>>Corporate Competence Center Embedded Linux

