Subject: Re: [PATCH] drivers/net: reformat using kernel coding style
References: <916874df-8fe5-30b5-0958-fa84d6261f65@xenomai.org>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <f079c34c-cd99-4a0d-eef5-3c01c7843d23@web.de>
Date: Mon, 1 Apr 2019 20:13:19 +0200
MIME-Version: 1.0
In-Reply-To: <916874df-8fe5-30b5-0958-fa84d6261f65@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 20.03.19 17:25, Philippe Gerum via Xenomai wrote:
>
> As discussed earlier on this list [1], this patch reformats the RTnet
> stack according to the kernel coding style. Due to its size, I'm not
> going to paste it inline; please find it at [2].
>
> Note: the following series introducing VLAN and multicast support is
> based on this patch.
>
> [1] https://www.xenomai.org/pipermail/xenomai/2019-February/040327.html
> [2]
> https://lab.xenomai.org/xenomai-rpm.git/commit/?h=3Dfor-upstream/next&id=
=3Df58f8e176a366182a182362b9af0ffe41ca81d86
>

Surely an improvement, but unfortunately with "some" regressions as well. =
Is the
conversion method used here the only option? Look:

total: 1329 errors, 3659 warnings, 118399 lines checked

That's checkpatch for the conversion patch.

Jan

