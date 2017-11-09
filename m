References: <CADYdroNR6zjbKrPKPm3d_7+55Rg2SDbmpxiNR-xu78QNHSrr9g@mail.gmail.com>
 <20170810114956.04f62bc6@md1em3qc>
 <CADYdroM8E7jhuyRoW4JkSzZfGg27VvpjLmHGmMmX79wgEqPJog@mail.gmail.com>
 <20171012103345.04d854c2@md1em3qc>
 <CADYdroOAVb0wPAvuynvuOUtSnp85FT2Ett80amzDpDCFHPHHzA@mail.gmail.com>
 <CADYdroNeQOY2MN-b=r6bNh=69oeGP2oWry2CXHYH9RJtTt1MFA@mail.gmail.com>
 <CADYdroN-yNG+nLrhfiH8MgMVr7D82-wNnjvyVXcX6hNU2mikcg@mail.gmail.com>
 <20171013113118.6e6f0fcd@md1em3qc>
 <CADYdroPP8ZQ91eqfJjJP9UFufpJOWm7+zsDePz-0a_TaDV_9_Q@mail.gmail.com>
 <20171013122653.1adbf99e@md1em3qc>
 <CADYdroP7G6irhKJUtpWfoVdivT3ey_i58zAvMz-O7E7PycH6ug@mail.gmail.com>
 <08ed4b28-608a-4a3b-6946-d910861017d3@xenomai.org>
 <20171019185557.41f55c24@md1em3qc>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b33db7eb-e88f-2253-c702-239a633c0d2f@xenomai.org>
Date: Thu, 9 Nov 2017 10:38:42 +0100
MIME-Version: 1.0
In-Reply-To: <20171019185557.41f55c24@md1em3qc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Won`t build on new Debian Stable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: norbert.lange@andritz.com, Norbert Lange <nolange79@gmail.com>, Xenomai <xenomai@xenomai.org>

On 10/19/2017 06:55 PM, Henning Schild wrote:
> On Thu, 19 Oct 2017 12:03:33 +0200
> Philippe Gerum <rpm@xenomai.org> wrote:
> 
>> On 10/13/2017 01:36 PM, Norbert Lange wrote:
>>> I works, because collect2 (the "compiler driver", which documents
>>> the -r option) now knows about the -r flag, using -Wl,-[U]r would
>>> mean the flags aren't even looked at.
>>> It can then disable functionality that is not supposed to be done at
>>> this point (see gcc/collect2.c, search for 'early_exit'). It might
>>> actually be in conflict with the -Ur option from the comments, but I
>>> don't know what this is trying to solve (the constructor tables
>>> would then be built in the second step?)
>>>
>>> I would prefer the compiler driver knowing about the flags and
>>> correctly dealing with them, instead of replicating this logic in
>>> scripts (and keeping it up to date with this internal logic).  
>>
>> Ack.
>>
>>> Might be that your wrapper script is doing something similarly by
>>> filtering out the arguments for the first step, which might be the
>>> same functionally that is skipped when adding '-r'
>>>
>>> I dont know what the -Ur flag is trying to solve, and the first
>>> patch adding -no-pie is way less likely to change something (given
>>> that I would not have compiled with -pie before).
>>> The new patch would however leave more of the magic to the toolchain
>>> and seems more "correct" to me, for whatever that's worth. But it
>>> might have some subtle differences to before, got some testcase
>>> where lacking the -Ur flag made a difference?  
>>
>> I don't know the original intent about passing -Ur to the linker,
>> except maybe to stick to the ld manpage which states that the last
>> partial link command should be given such option.
>>
>> However my understanding is that we don't need it in wrap-link.sh,
>> since the script eventually completes the link stage to produce a
>> fully resolved executable. That implies collecting the ctors/dtors and
>> resolving all references from the partially linked object file anyway.
>>
>> Some testing only passing -r here seems to confirm this assumption
>> with C++ apps; C++ users may want to check this too:
> 
> I just told some C++ power users to give that a try. I am not sure how
> fast the feedback will arrive, i hope in the next two weeks.
> 
> Henning
> 
>>
>> diff --git a/scripts/wrap-link.sh b/scripts/wrap-link.sh
>> index aab7899..fa83bd5 100755
>> --- a/scripts/wrap-link.sh
>> +++ b/scripts/wrap-link.sh
>> @@ -204,7 +204,7 @@ done
>>
>>  if $stage2; then
>>      $verbose && set -x
>> -    $dryrun $cc -o "$output.tmp" -Wl,-Ur -nostdlib $stage1_args
>> +    $dryrun $cc -o "$output.tmp" -r -nostdlib $stage1_args
>>      $dryrun $cc -o "$output" "$output.tmp" $stage2_args
>>      $dryrun rm -f $output.tmp
>>  else
>>

Any news from the Xenomai/C++ folks regarding this change? I plan to
merge it next week if nobody complains.

-- 
Philippe.

