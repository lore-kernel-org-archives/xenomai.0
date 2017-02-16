From: Marcel Van Mierlo <Marcel.VanMierlo@marel.com>
Date: Thu, 16 Feb 2017 08:49:36 +0000
Message-ID: <VI1PR0501MB260657B457773886726D0C6A915A0@VI1PR0501MB2606.eurprd05.prod.outlook.com>
References: <VI1PR0501MB260685233C854A5963C3B46E915B0@VI1PR0501MB2606.eurprd05.prod.outlook.com>
In-Reply-To: <VI1PR0501MB260685233C854A5963C3B46E915B0@VI1PR0501MB2606.eurprd05.prod.outlook.com>
Content-Language: en-GB
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [SPOOF ?] Does it make sense to patch with both
 Xenomai and	PREEMPT_RT?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Ah, I see this was largely answered for Ran Shalit's question on Feb 07th.


Cheers,

Marcel.

________________________________
From: Xenomai <xenomai-bounces@xenomai.org> on behalf of Marcel Van Mierlo =
<Marcel.VanMierlo@marel.com>
Sent: 15 February 2017 16:42:38
To: xenomai@xenomai.org
Subject: [SPOOF ?][Xenomai] Does it make sense to patch with both Xenomai a=
nd PREEMPT_RT?

[This sender failed our fraud detection checks and may not be who they appe=
ar to be. Learn about spoofing at http://aka.ms/LearnAboutSpoofing]

Hi,


Is it possible to patch a Kernel (3.18.5) with both CONFIG_PREEMPT_RT and X=
enomai (3.0.2 Cobalt)? Does this make sense, or does the Xenomai patch intr=
oduce RT preemption anyway?


We have a real-time pSOS application currently running under a Xenomai patc=
hed Kernel  (Kernel 3.18.5, Xenomai 3.0.2 Cobalt), and would like to use th=
is environment to run an application which currently runs under a Kernel (3=
.14.48) which is patched with PREEMPT_RT.


Regards,

Marcel.

_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
https://xenomai.org/mailman/listinfo/xenomai
