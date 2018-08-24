References: <c3a3b15a-ea65-4051-55d8-b74a0a3aa4ad@visutechsystem.by>
 <54569c93-a1e4-9e1e-2479-191532378dbf@xenomai.org>
 <349b2c10-b2bd-69d2-dcbd-e52454a35cbb@visutechsystem.by>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <c52b46b5-75d3-48ae-1603-11708f5a5d21@xenomai.org>
Date: Fri, 24 Aug 2018 16:15:05 +0200
MIME-Version: 1.0
In-Reply-To: <349b2c10-b2bd-69d2-dcbd-e52454a35cbb@visutechsystem.by>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai 3.0.6 get stuck on AM335x after 4-16 hours
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stepan Kizim <Stepan.Kizim@visutechsystem.by>, xenomai@xenomai.org
Cc: Sergey Belevich <Sergey.Belevich@visutechsystem.by>, Andrey Kuchinsky <Andrey.Kuchinsky@visutechsystem.by>, Yury Kaliukhovich <Jury.Kaliukhovich@visutechsystem.by>, "Victor VYSOTSKI (KPA)" <victor.vysotski@koenig-pa.de>

On 08/24/2018 03:37 PM, Stepan Kizim wrote:
> Hello Philippe,
> 
> Thank you very much for your advice! Unfortunately, 3 boards passed 24h
> long stress test with 'latency' and 'switchtest -s 200' in parallel.
> The issue still has low reproducibility but we catch one with added

>From your answer, I can't figure out whether the latency+switchtest
combo ran flawlessly for 24h+, or the test did fail although the bug was
a low reproducible one in this configuration?

> debug info (see .config_debug) and enabled sysrq (see 180824_bbb.txt for
> output of "sysrq: SysRq : Show State" and 180824_blocked_state.txt for
> "sysrq: SysRq : Show Blocked State").
> 
> Do you have any ideas about further tests?

First of all, please check how Xenomai 3.0.7 behaves, for testing
purpose. On a general note, until you can reproduce the issue on a
mainline kernel tree and test apps we have access to, there is not much
we can help with.

-- 
Philippe.

