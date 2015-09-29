From: "PRADHAN, MAKARAND (RC-CA)" <makarand.pradhan@siemens.com>
Date: Tue, 29 Sep 2015 17:14:10 +0000
Message-ID: <B89CCBE86D4F62448EE4F6367C6D3C89221E435B@USMLVA0EM24MSX.ww017.siemens.net>
References: <B89CCBE86D4F62448EE4F6367C6D3C89221E32ED@USMLVA0EM24MSX.ww017.siemens.net>
 <560AB34B.5020300@xenomai.org>
 <B89CCBE86D4F62448EE4F6367C6D3C89221E4342@USMLVA0EM24MSX.ww017.siemens.net>
 <560AB938.8090905@xenomai.org>
In-Reply-To: <560AB938.8090905@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Interrupt latency close to 1ms on powerpc Xenomai
 2.6.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks Philippe.

Will correct and retest for latency.

-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org]
Sent: Tuesday, September 29, 2015 12:16 PM
To: PRADHAN, MAKARAND (RC-CA); Xenomai@xenomai.org
Subject: Re: [Xenomai] Interrupt latency close to 1ms on powerpc Xenomai 2.=
6.4

On 09/29/2015 06:04 PM, PRADHAN, MAKARAND (RC-CA) wrote:
>> Are you playing with the T_LOCK bit?
>
> Yes. We do T_LOCK to lock the scheduler while we are in a critical sectio=
n. Is that why the scheduler does not kick in immediately after the HW int?

If the IRQ happens while some task holds the scheduler lock, the answer is =
yes, that is the point of it.

The scheduler lock is an ugly construct inherited from the dark ages of RTO=
S. Xenomai being about properly emulating these for running legacy code is =
the only reason why this anti-feature is present. I would strongly recommen=
d to use a mutual exclusion mechanism with a finer granularity.

--
Philippe.

This message and any attachments are solely for the use of intended recipie=
nts. The information contained herein may include trade secrets, protected =
health or personal information, privileged or otherwise confidential inform=
ation. Unauthorized review, forwarding, printing, copying, distributing, or=
 using such information is strictly prohibited and may be unlawful. If you =
are not an intended recipient, you are hereby notified that you received th=
is email in error, and that any review, dissemination, distribution or copy=
ing of this email and any attachment is strictly prohibited. If you have re=
ceived this email in error, please contact the sender and delete the messag=
e and any attachment from your system. Thank you for your cooperation

