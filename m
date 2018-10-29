Date: Mon, 29 Oct 2018 19:42:05 +0000 (UTC)
From: Alec Ari <neotheuser@ymail.com>
Reply-To: Alec Ari <neotheuser@ymail.com>
Message-ID: <598074269.18541080.1540842125316@mail.yahoo.com>
In-Reply-To: <20181029110908.743b3f1b@md1pvb1c.ad001.siemens.net>
References: <0B8B4C90A6FEA34E9EA10570C016C358BB7D9D8A@DEMUC-SMX001.data-modul.local>
 <c371a628-edc2-0713-767b-80efac64833e@siemens.com>
 <0B8B4C90A6FEA34E9EA10570C016C358BB7DA2CC@DEMUC-SMX001.data-modul.local>
 <0c0a94e6-6650-88e2-7b89-3b6fa92efa65@siemens.com>
 <0B8B4C90A6FEA34E9EA10570C016C358BB7DA73C@DEMUC-SMX001.data-modul.local>
 <52b6df12-fbb5-871a-7c4c-5208e7e04978@siemens.com>
 <cuc1u0s6krjua13us78v6n9g.1539284434958@email.android.com>
 <0B8B4C90A6FEA34E9EA10570C016C358BB7DB540@DEMUC-SMX001.data-modul.local>
 <d1c7004d-c205-4ee2-c8c6-fa39e9bf1583@siemens.com>
 <1521267485.13306337.1540063633073@mail.yahoo.com>
 <9b840e99-4d20-671d-8799-6ca83798b9ee@xenomai.org>
 <1869341136.13320020.1540070747405@mail.yahoo.com>
 <20181029110908.743b3f1b@md1pvb1c.ad001.siemens.net>
Subject: Re: [Xenomai] Cobolt core not enabled in kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, Xenomai <xenomai@xenomai.org>

Hello and yes, thank you for asking. I switched the preemption model from low-latency to server (PREEMPT_NONE) and the warning I was getting went away.


This issue was fixed by Philippe, I haven't tested the patch though but that should do the trick.



I apologize for my emails being formatted horribly (new lines missing and such) Yahoo is terrible and keeps messing them up.


Alec

