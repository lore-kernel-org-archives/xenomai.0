MIME-Version: 1.0
In-Reply-To: <533E7855.3090309@xenomai.org>
References: <CAEbDrgnR1aU-A6KDq7uRCKqV0=sj8yoQE_zUeiVdxmemdfnyMQ@mail.gmail.com>
 <533E7855.3090309@xenomai.org>
Date: Fri, 4 Apr 2014 10:22:34 +0100
Message-ID: <CAEbDrgm-7SvkR1hgfuYvGKTnP_RxBP1uYbxzbcSsYaUadVx3=w@mail.gmail.com>
From: Gregory Dymarek <gregd72002@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] [patch] prepare_kernel.sh --board argument
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Will create a new patch later on.
I really like this approach.

Thanks!

On 4 April 2014 10:16, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 04/02/2014 07:37 PM, Gregory Dymarek wrote:
>> Hi,
>>
>> From ealier discussion - given the evolution pace of ARM platforms, it
>> seems we will always have -pre and -post patches, so it would make
>> sense to add this support to prepare-kernel.sh.
>>
>> Included patch that adds support for --board parameter to the
>> prepare_kernel.sh script. This will cause prepare_kernel.sh to apply
>> automatically pre and post patches if available.
>>
>> When --board is provided the script will look for optional board
>> patches in the folder that ipipe patch is and in $board subfolder if
>> exsists.
>> It expects the patch name to be: {ipipe_base_name}-{board_name}-{pre,post}-*
>> Where {ipipe_base_name} is the ipipe name before the last '-'.
>>
>> Example:
>> For ipipe-core-3.10.18-arm-1.patch and --board=raspberry it will look for:
>> - ipipe-core-3.10.18-arm-raspberry-{pre,post}-*.patch
>
> Hi Gregory,
>
> sorry for not answering earlier. The --board argument looks
> complicated, and misleading. Complicated because it imposes restrictions
> on -pre and -post patch names which do not exist currently. Misleading,
> because applying pre- and post- patches is not
> really board specific but more specific to kernel forks, which may more
> aim at supporting SOC or even SOC family peripherals, but are not
> restricted to that (think of Android for instance). Anyway, it would
> be much simpler to modify the --ipipe argument to allow passing a list
> of patches separated by comas.
>
> For instance
>
> prepare-kernel.sh --ipipe patch1.patch,patch2.patch,patch3.patch
>
> would apply the three patches patch1.patch, path2.patch and patch3.patch
> sequentially.
>
> Regards.
>
> --
>                                                                 Gilles.

