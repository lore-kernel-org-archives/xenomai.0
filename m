Message-ID: <5146E61E.4080606@hilscher.com>
Date: Mon, 18 Mar 2013 11:02:06 +0100
From: Jerome Poncin <JPoncin@hilscher.com>
MIME-Version: 1.0
References: <512C806F.2020209@hilscher.com>	<512CC6A3.1010005@siemens.com>	<512F120A.5060109@hilscher.com>	<512F4005.60000@siemens.com>	<512F48AA.8020601@hilscher.com>	<5130B39C.70300@hilscher.com>	<513465CF.4030807@hilscher.com>	<51350D5B.6060309@xenomai.org>	<5135CCDE.5090401@hilscher.com>	<5135D667.8060309@siemens.com>	<51361281.20307@hilscher.com>	<51364A61.3090002@xenomai.org>	<5136F9E9.9030604@hilscher.com>	<5136FC1E.6060608@xenomai.org>	<51371B89.4020103@hilscher.com>	<513730CE.2070102@xenomai.org>	<51374B98.7030103@hilscher.com>	<51376093.7060701@siemens.com>	<5137AF89.1020009@xenomai.org>	<5138B33C.1060506@hilscher.com>	<5139BABA.8010602@hilscher.com>	<5139D7F5.2090904@xenomai.org>
	<513EF0F0.4070705@hilscher.com>	<513F1DBD.5090603@xenomai.org>
	<513F4944.9010202@hilscher.com> <513F8434.6070405@xenomai.org>
	<51405E4A.9010607@hilscher.com> <5142E55E.4090705@hilscher.com>
	<51430107.3060600@siemens.com> <51431C55.8050304@hilscher.com>
	<51432110.3090900@siemens.com>
In-Reply-To: <51432110.3090900@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Hilscher driver for cifX boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Le 15/03/2013 14:24, Jan Kiszka a écrit :
> On 2013-03-15 14:04, Jerome Poncin wrote:
>> Hello Jan,
>>
>> Yes you're right. I have 1 thread for test (main) application and the
>> driver create one or two thread if IRQ or polling is enable.
>> The driver thread are loop waiting event with delay.
>> At Driver start it take few second to download firmware and configuration.
>> My question is why it's a problem to have a real time that that run few
>> second.
>> If this task have the bigger priority, it's normal to not release hand
>> and to not sleep, I'm right or not ?
> Linux is not capable (yet) of handling the case that an online CPU is
> 100% occupied. Sooner or later, the whole (Linux) system will lock up,
> also the timekeeping can be negatively affected. That's nothing Xenomai
> can change.
>
> Therefore, every real-time task has to behave properly, sleep on
> asynchronous external events or suspend itself for a certain while when
> there is nothing to do. In good real-time designs, that is usually no
> problem, specifically if the number of tasks is moderate and the
> workload is clear. I've seen less obvious problems in large
> applications, but those were typically bugs as well.
>
> Jan
>
Hello Jan,

I investigated my problem and the problem come from some lock on thread.
I think my thread management is not correct... I
Is there an example in posix with multiple thread management ?

Thank you for your help,

Jerome

