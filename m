References: <c152b2c4-d6a6-930a-3f6f-2fff032da08e@gmail.com>
 <ff2a8ac1-4054-bbbb-cfea-1277a926e498@siemens.com>
From: Edouard Tisserant <edouard.tisserant@gmail.com>
Message-ID: <eb90c876-85e3-0418-2c18-0a14ae15ff36@gmail.com>
Date: Mon, 17 Sep 2018 09:52:49 +0200
MIME-Version: 1.0
In-Reply-To: <ff2a8ac1-4054-bbbb-cfea-1277a926e498@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Xenomai] NRT send/recv with rtpacket
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Hi Jan

Sorry for the mess.

> Can you send the patches as separate emails, inlined (git send-email)?
> This is not easily reviewable because...
>
> ...these attachments are not forwarded to the list.

ok, will resend git email so that list can review.

> Also note that features should first be in next/master before we
> decide whether pushing them to stable as well is OK (generally, only
> fixes should go there). Patches should therefore target the next branch=
=2E

Sorry, I tried applying it on stable-3.0.x, and git feels to me like
driving a tank with a trackball. I'll do it on next branch next time,
and hope that rebasing this one won't be a problem... thanks in advance.

Edouard

PS: I also forgot this reference:
[1] https://hg.beremiz.org/etherlabmaster/file/tip/devices/rtdmnet.c



