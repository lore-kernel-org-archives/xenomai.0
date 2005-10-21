Message-ID: <1187.10.2.100.4.1129894952.squirrel@domain.hid>
In-Reply-To: <4358CD46.7050301@domain.hid>
References: <4307.10.2.100.4.1129890030.squirrel@domain.hid>
	<4358CD46.7050301@domain.hid>
Date: Fri, 21 Oct 2005 13:42:32 +0200 (CEST)
Subject: Re: [Xenomai-help] Links between RTAI and Xenomai
From: "Germain Olivier" <germain.olivier@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Thanks, this is exactly what I wanted to know

> Germain Olivier wrote:
>> Hello
>>
>> I have a few questions about the links between RTAI and Xenomai
>>
>> -When RTAI and Xenomai merged to RTAI/Fusion, which code of each was
>> used ?
>> I mean that in the project, which fonctionnalities of each was kept.
>>
>
> RTAI and Xenomai merged as projects back in 2003, unfortunately (or
> fortunately)
> they never managed to merge as technologies because their respective core
> implementation just cannot match. This means that the two code bases were
> at the
> best side-by-side in the same RTAI distros (see the sched/xenomai and
> addons/skins dirs in RTAI's 3.0 and 3.1 releases), and not even in the
> same CVS
> tree during the RTAI/fusion effort.
>
> For this reason, the RTAI/fusion project - started in April 2004 - once
> envisioned a closer convergence of both systems at the API level, but on
> top of
> the Xenomai core. This is the kind of convergence the RTAI project
> eventually
> refused, unless some original RTAI code would be merged in RTAI/fusion.
> Since
> this solution was unacceptable to us for various reasons, we did some kind
> of
> "retro-merger", and Xenomai recovered its independence.
>
>> -With the actual Xenomai, which portion of RTAI remain in the code ? How
>
> Interestingly enough, things are going the other way around actually. I
> have
> founded the Xenomai project back in 2001 [1], then published the first
> Adeos
> patches in June 2002, and finally ported Xenomai 1.x over Adeos a few
> weeks
> later as the first illustration of the capabilities of the latter to
> provide
> support to RTOS [2]. Then, upon RTAI's founder request, I've accepted to
> implement a new hw abstraction layer for RTAI 24.1.10 based on Adeos in
> replacement of the legacy RTHAL, which eventually led to RTAI 24.1.11 [3].
> So
> regarding this matter, at least, it's Xenomai's know-how that went to
> RTAI, and
> not the other way around.
>
>> futur development of RTAI will be merged to Xenomai, as it is also a
>> skin
>> ?
>>
>
> I guess that you now have the answer. On the specific RTAI skin issue, it
> has
> been contributed by the Nextream fellows the way we once envisioned to
> port the
> whole RTAI API over the Xenomai core, that is to say a

