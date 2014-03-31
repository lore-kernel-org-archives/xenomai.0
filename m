MIME-Version: 1.0
In-Reply-To: <CAEbDrgkw0rw-xYz_thNyGdB4hwGLJpjA4uY13aNpbXP29eq5Zw@mail.gmail.com>
References: <CAEbDrgn=VM340xozWgS=8aap5Wkw2YCynGDSwtj9m1415J+XYw@mail.gmail.com>
 <44ha6j7j1j.fsf@lowell-desk.lan> <53346FF7.9010509@xenomai.org>
 <CAEbDrg=K=soaY9rV2GizdMANz8PKDGsLguCnb4Jh_iLuhqbLig@mail.gmail.com>
 <53358879.2040109@xenomai.org>
 <CAEbDrgkw0rw-xYz_thNyGdB4hwGLJpjA4uY13aNpbXP29eq5Zw@mail.gmail.com>
Date: Mon, 31 Mar 2014 22:05:45 +0100
Message-ID: <CAEbDrgkJqQJnD=-dPjorGmfgSGjYMegNj6bwH36F0iOxuryoCw@mail.gmail.com>
From: Gregory Dymarek <gregd72002@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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

Hi,

Included patch that adds support for --board parameter to the
prepare_kernel.sh script.

When --board is provided the script will look for optional board
patches in the folder that ipipe patch is and in $board subfolder if
exsists.
It expects the patch name to be: {ipipe_base_name}-{board_name}-{pre,post}-*
Where {ipipe_base_name} is the ipipe name before the last '-'.

Example:
For ipipe-core-3.10.18-arm-1.patch and board=3Draspberry it will look for:
- ipipe-core-3.10.18-arm-raspberry-{pre,post}-*.patch

Regards,
Gregory


On 28 March 2014 15:00, Gregory Dymarek <gregd72002@gmail.com> wrote:
> Thanks Gilles.
>
> Before I start messing around with the prepare-kernel.sh can someone
> review the proposal please?
>
>
> add --board flag:
>    tells the script about the target board. If unspecified, no board
> specific patches will be applied.
>
> suggest to modify prepare-kernel.sh in the following way:
> - construct pre ipipe patch name:
> patches/$board/ipipe-core-$linux_version-$board-pre-*
> - construct post ipipe patch name similar to above
> - if pre patch exist - apply before ipipe_patch
> - if post patch exist - apply after ipipe_patch
>
>
>
> This calls for board patch standards. Is there a standard for patch
> names currently in place?
> My I suggest ipipe-core-$linux_version-$board-{pre,post}-*
>
> This above might not work if custom adeos patch is specified. Should we c=
are?
>
>
> Thanks,
> Gregory
>
> On 28 March 2014 14:34, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> On 03/28/2014 03:22 PM, Gregory Dymarek wrote:
>>>
>>> Ok, I think I'm on top of it. Will post all the patches once I test
>>> them properly.
>>>
>>> Another question on the topic of PRE and POST patches. Is there a
>>> reason why prepare-kernel.sh cannot invoke PRE and POST patches
>>> automatically?
>>>
>>> I'm trying to get this into a buildroot and it does not support pre
>>> and post patches. Also, I'm getting a push back on adding the support
>>> for pre- and post- ipipe patches into buildroot.
>>
>>
>> No reason except the fact that -pre and -post patches are a temporary
>> solution while the support for the board is integrated into the mainline
>> kernel. Now, given the evolution pace of ARM platforms, it seems we will
>> always have -pre and -post patches, so it would make sense to add this
>> support to prepare-kernel.sh. So, the answer to your question is "patch
>> welcome".
>>
>>
>> --
>>                                             Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pre_post_prepare_kernel.patch
Type: text/x-patch
Size: 3060 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140331/d8469c5=
3/attachment.bin>
