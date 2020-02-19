From: steven.seeger flightsystems.net <steven.seeger@flightsystems.net>
Subject: Re: Towards Xenomai on Dovetail
Date: Wed, 19 Feb 2020 15:33:01 +0000
Message-ID: <2657497.jFxQff4vTC@omoikane>
References: <97687b86-9c39-e808-d49c-04b0178d8c31@siemens.com>
 <3a0bab49-a40f-75d3-9abb-26a7a2e2341c@gmail.com>
In-Reply-To: <3a0bab49-a40f-75d3-9abb-26a7a2e2341c@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F906267A0C1C0942A7AA1C818E4328F1@namprd05.prod.outlook.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>, Philippe Gerum <philippe.gerum@gmail.com>

On Tuesday, February 18, 2020 12:36:45 PM EST Philippe Gerum wrote:
> - kernel/cobalt/arch/*/ and related can go, almost entirely. There is
> direct support for context switching including fpu management for
> threads controlled by the companion (e.g. real-time) core. This means
> that Xenomai's scheduler core should be adapted to use the available
> dovetail interface for this. The workings are explained in the
> description of the so-called "alternate scheduling" Dovetail implements [=
3].

Sorry for joining this discussion late.

Is there still a syscall interface (and fast ipipe syscall path) for doveta=
il?=20
Or is this done away with?

Steven




