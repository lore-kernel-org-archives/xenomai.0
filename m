Subject: Re: Controlling DMA priority between GPU and CPU on x86
References: <a10e8232f3104d32900617139e7033da@heig-vd.ch>
 <cc3833cd-118f-8fce-6bd4-585bb79330a6@siemens.com>
 <6b84e3f52b1c497daa5f675f69e15a77@heig-vd.ch>
 <344ff7b8-eb50-de6c-5b0e-ff4ca84d8b98@numalliance.com>
 <92697766dd5c4634bc7ec342a18a5e3a@heig-vd.ch>
From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <4959ca2a-e59b-5183-d26c-dd0e5530c253@numalliance.com>
Date: Mon, 7 Oct 2019 10:06:03 +0200
MIME-Version: 1.0
In-Reply-To: <92697766dd5c4634bc7ec342a18a5e3a@heig-vd.ch>
Content-Language: fr
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Rossier Daniel <Daniel.Rossier@heig-vd.ch>, Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>


Le 07/10/2019 =C3=A0 09:59, Rossier Daniel a =C3=A9crit=C2=A0:
>> -----Original Message-----
>> From: St=C3=A9phane Ancelot <sancelot@numalliance.com>
>> Sent: lundi, 7 octobre 2019 09:15
>> To: Rossier Daniel <Daniel.Rossier@heig-vd.ch>; Jan Kiszka
>> <jan.kiszka@siemens.com>; xenomai@xenomai.org
>> Subject: Re: Controlling DMA priority between GPU and CPU on x86
>>
>> Hi,
>>
>> You won't be able to achieve realtime using the actual intel linux vid=
eo driver
>> using GPU.
>>
>> The driver is not preemptible.
>>
>> This mainly happens when GPU receives batch job (eg launching a progra=
m
>> that creates many graphic widgets , moving a window with a 19 inch dis=
play) .
>>
>> The memory is locked by the GPU. Isolating rt tasks /IT to cpus won't =
solve it,
>> since the memory is shared with all CPUs (eg only one=C2=A0 numa node)
>>
>> The problem can better being watched splitting a realtime task in 2 or=
 3 tasks,
>> (task1 executes, and wakes up task2, task2 executes and wakes up task3=
) .
>>
>> We may manage to solve the problem if being able to provide intel a un=
it
>> testing program being able to reproduce the phenomen.
>> Reducing GPU frequency decreases problem frequency but does not solve =
it.
>>
>> For reference:
>> https://bugs.freedesktop.org/show_bug.cgi?id=3D110950
> Thanks a lot for this feedback. We will try to move the GUI on a remote=
 PC.
> Although the network card will also perform DMA access, it could involv=
e less latencies,
> or the network card can be configured to be used in a polling mode. Do =
you have some hints about
> such an approach?
 From my experience, the problem has not appeared redirecting whole=20
graphic through an ssh -X connection.(and inhibiting X11 in RT computer)
>
> Regards,
> Daniel
>
>
>> Regards,
>> S.Ancelot
>>
>> Le 05/10/2019 =C3=A0 10:03, Rossier Daniel via Xenomai a =C3=A9crit=C2=
=A0:
>> -----Original Message-----
>> From: Jan Kiszka mailto:jan.kiszka@siemens.com
>> Sent: vendredi, 4 octobre 2019 10:15
>> To: Rossier Daniel mailto:Daniel.Rossier@heig-vd.ch;
>> mailto:xenomai@xenomai.org
>> Subject: Re: Controlling DMA priority between GPU and CPU on x86
>>
>> On 03.10.19 17:23, Rossier Daniel via Xenomai wrote:
>> Hi all,
>>
>> We are currently working on a project called OpenCN which is a framewo=
rk
>> deeply inspired from LinuxCNC, but with a revisited architecture.
>> Hence, OpenCN is related to machine control.
>>
>> Our framework mainly use a AMP approach and runs the Xenomai/Cobalt
>> kernel on a dedicated CPU with no I-pipe (reworked out).
>> (We plan to release the framework by first of November).
>>
>> IOW, "bare-metal" Cobalt? Collaborative AMP, or partitioned via
>> virtualization?
>>
>> Actually, we have patched a lot Xenomai/Cobalt to keep the cobalt sche=
duler
>> and main functions (mutex, task create/delete, timer, etc.) running on=
 CPU
>> #1 and
>> we manage interactions with CPU #0 via specific IPI interrupts.  The L=
inux
>> scheduler does not intervene here.
>>
>>
>> Our framework works well on a x86 PC, but we have to face an issue
>> regarding DMA priority between the GPU and CPU; when the user plays
>> with the GUI, some small latencies (O(10ms)) raise up.
>> Although the question is not directly related to Xenomai, I would be
>> very interested if somebody knows if it possible to give CPU priority =
against
>> the GPU, and how to manage the related DMA controller? Is it possible =
to
>> configure it ? Or any other hint to avoid this latency ?
>>
>> Many thanks in advance for any inputs.
>>
>> I didn't dig into anything that manages PCI bandwidth yet. I heard tha=
t
>> something exists, but at that time it was not publicly documented. And=
 it's
>> likely highly platform specific (SoC/chipset).
>>
>> Did you clearly identify that it's DMA contention which increased your
>> latency?
>>
>> The latency appears when there are some activities on the GPU (the use=
r
>> moves windows for example).
>> Otherwise, the system is very stable, on a long period too.
>>
>> Do you cache-miss delays increase (PMU should tell you)? Or is there a
>> contention between a RT device doing DMA and the GPU?
>>
>> How can I get info from PMU in that sense? There is the network card
>> (e1000e) which makes DMA access probably,
>> however we do not use interrupts here, only polling since it is patche=
d
>> Ethercat-based driver.
>>
>> I also attached some information about our lab PC.
>>
>> Daniel
>>
>>
>> Jan
>>
>> --
>> Siemens AG, Corporate Technology, CT RDA IOT SES-DE Corporate
>> Competence Center Embedded Linux
>> -------------- next part --------------
>> An embedded and charset-unspecified text was scrubbed...
>> Name: lscpu.txt
>> URL:
>> http://xenomai.org/pipermail/xenomai/attachments/20191005/16b7c474/at
>> tachment.txt
>> -------------- next part --------------
>> An embedded and charset-unspecified text was scrubbed...
>> Name: lscpu_C.txt
>> URL:
>> http://xenomai.org/pipermail/xenomai/attachments/20191005/16b7c474/at
>> tachment-0001.txt
>> -------------- next part --------------
>> An embedded and charset-unspecified text was scrubbed...
>> Name: lspci_knnvv.txt
>> URL:
>> http://xenomai.org/pipermail/xenomai/attachments/20191005/16b7c474/at
>> tachment-0002.txt
