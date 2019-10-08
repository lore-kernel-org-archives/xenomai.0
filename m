From: steven.seeger flightsystems.net <steven.seeger@flightsystems.net>
Subject: Re: [PATCH 1/2] cobalt: Add _CC_COBALT_DEBUG_SYNC_BP feature
Date: Tue, 8 Oct 2019 14:17:11 +0000
Message-ID: <12773854.dYiKgG3qDd@omoikane>
References: <8271e30f-9fcf-b366-8154-922f988bf366@siemens.com>
 <a2366c15-7f1d-3721-5586-fe44d5f86b81@xenomai.org>
 <8cdf2c49-89df-be48-de2e-14d685caad59@siemens.com>
In-Reply-To: <8cdf2c49-89df-be48-de2e-14d685caad59@siemens.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A20ABFA67561314BB65F5D3E2F72D5FF@namprd05.prod.outlook.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

On Tuesday, October 8, 2019 9:53:34 AM EDT Jan Kiszka wrote:
> It remains just a debug feature, an ARM64 patch is already under test,
> PowerPC is not in regular testing (yet) - so let's just close the only
> more annoying issue (ARM64) and be done (for now). Anything else would
> mean rolling out tones for new releases for something that was already
> solved (for those).

Does this feature make debugging xenomai userspace apps more reliable with=
=20
gdb? I thought we already had in place a system that suspended all threads =
in=20
the process when a breakpoint is hit, and with set scheduler-locking on you=
=20
coudl step through a particular thread without interruption. What does this=
=20
new feature add?

If I wasn't super swamped I'd jump on this to try and make life easier for=
=20
everyone. It really doesn't seem like it would be that hard if it's just a=
=20
couple modifications to the return from interrupt path. On PPC there are=20
several of these paths.

I've been thinking that it may make some sense to drop older powerpc suppor=
t=20
since almost everything is e500 or later these days. (Though the project we=
=20
flew that's on the ISS right now was a 440.)

Steven




