MIME-Version: 1.0
In-Reply-To: <53358879.2040109@xenomai.org>
References: <CAEbDrgn=VM340xozWgS=8aap5Wkw2YCynGDSwtj9m1415J+XYw@mail.gmail.com>
 <44ha6j7j1j.fsf@lowell-desk.lan> <53346FF7.9010509@xenomai.org>
 <CAEbDrg=K=soaY9rV2GizdMANz8PKDGsLguCnb4Jh_iLuhqbLig@mail.gmail.com>
 <53358879.2040109@xenomai.org>
Date: Fri, 28 Mar 2014 15:00:56 +0000
Message-ID: <CAEbDrgkw0rw-xYz_thNyGdB4hwGLJpjA4uY13aNpbXP29eq5Zw@mail.gmail.com>
From: Gregory Dymarek <gregd72002@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Raspberry Pi - 3.10.34
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks Gilles.

Before I start messing around with the prepare-kernel.sh can someone
review the proposal please?


add --board flag:
   tells the script about the target board. If unspecified, no board
specific patches will be applied.

suggest to modify prepare-kernel.sh in the following way:
- construct pre ipipe patch name:
patches/$board/ipipe-core-$linux_version-$board-pre-*
- construct post ipipe patch name similar to above
- if pre patch exist - apply before ipipe_patch
- if post patch exist - apply after ipipe_patch



This calls for board patch standards. Is there a standard for patch
names currently in place?
My I suggest ipipe-core-$linux_version-$board-{pre,post}-*

This above might not work if custom adeos patch is specified. Should we care?


Thanks,
Gregory

On 28 March 2014 14:34, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 03/28/2014 03:22 PM, Gregory Dymarek wrote:
>>
>> Ok, I think I'm on top of it. Will post all the patches once I test
>> them properly.
>>
>> Another question on the topic of PRE and POST patches. Is there a
>> reason why prepare-kernel.sh cannot invoke PRE and POST patches
>> automatically?
>>
>> I'm trying to get this into a buildroot and it does not support pre
>> and post patches. Also, I'm getting a push back on adding the support
>> for pre- and post- ipipe patches into buildroot.
>
>
> No reason except the fact that -pre and -post patches are a temporary
> solution while the support for the board is integrated into the mainline
> kernel. Now, given the evolution pace of ARM platforms, it seems we will
> always have -pre and -post patches, so it would make sense to add this
> support to prepare-kernel.sh. So, the answer to your question is "patch
> welcome".
>
>
> --
>                                             Gilles.

