References: <CAOuPNLiWw7R9j75OvFWq6RAcwgiaGaOt_4Ep0hXOz-ZOMkrrww@mail.gmail.com>
 <4e64e78c-0b25-c6e6-90cb-f48c7cdd5051@xenomai.org>
 <CAOuPNLgw8NurkqsMUK49NTKiLx1YqidQZ=i7vMMpF=Nxu1ZROg@mail.gmail.com>
 <9df15323-f92d-a668-ba1a-5986170996ec@xenomai.org>
 <CAOuPNLidcKbBbguT6Ye8nCpMbdD9Q7qA5X=OS7Sbi=jJud-tHg@mail.gmail.com>
 <CAOuPNLj0p41A9bAV4P1cwufNJ7bkGQ8Kb=7L+2n5M_q0jAZgpg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <8638c645-800d-b97d-9678-8866b8516d32@xenomai.org>
Date: Fri, 8 Jun 2018 15:24:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAOuPNLj0p41A9bAV4P1cwufNJ7bkGQ8Kb=7L+2n5M_q0jAZgpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Applying arch specific ipipe patches - commit by
	commit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Kumar <pintu.ping@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/08/2018 03:10 PM, Pintu Kumar wrote:
> Dear Philippe,
> 
>>> $ git fetch --tags
>>> $ git checkout ipipe-core-4.9.51-x86-5
>>> $ ./scripts/ipipe/genpatches.sh --split
>>
> 
> Is there similar method to download xenomai-3 patches, by splitting
> arch and non-arch patches, and applying it to the single kernel.
> If yes, please let me know.
> If no, then can you suggest me some method to do it.
> 

$ cd build/linux

# Extract a full Xenomai patch for arm (noarch + arm bits)
$ ~/xenomai-dist/scripts/prepare-kernel.sh --arch=arm
--outpatch=xenomai-arm-full.patch

# Extract the noarch Xenomai bits only
$ ~/xenomai-dist/scripts/prepare-kernel.sh --arch=arm
--outpatch=xenomai-noarch.patch --filterarch=y

# Extract the arm-specific bits only
$ ~/xenomai-dist/scripts/prepare-kernel.sh --arch=arm
--outpatch=xenomai-arm-bits.patch --filterarch=n

-- 
Philippe.

