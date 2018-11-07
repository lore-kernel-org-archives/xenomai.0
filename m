Subject: Re: [RFC] xenomai-images: test and demo image generator
References: <c32e5b83-4eec-f6f2-dd63-c1e5b753a78f@siemens.com>
 <CALLqZ8RSY9Kc4vwS7D_JnVm3GNRNGQV6PAv7Mi7fmrGPPQ88WQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <43dccda9-1b84-4169-7d83-621053387994@siemens.com>
Date: Wed, 7 Nov 2018 07:37:19 +0100
MIME-Version: 1.0
In-Reply-To: <CALLqZ8RSY9Kc4vwS7D_JnVm3GNRNGQV6PAv7Mi7fmrGPPQ88WQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>, Steven Seeger <steven.seeger@nasa.gov>

On 06.11.18 20:28, Greg Gallagher wrote:
> This looks really good.  How easy is it to add more targets?  I looked
> at the jailhouse-images commits to see how to add a board, is that a
> good place to start to see how to add a new board?
> 

Yes, it is. But I'll likely commit at least one real example later today also to
this project.

The tricky thing is generally enabling the board to boot at all. By now, we have
covered a pretty broad range of cases, but each board remains different. E.g., I
still have the enabling of the Ultra96 on my to-do list because building of the
boot loader is so complicated, even more than the MACCHITObin which was recently
added to jailhouse-images. You will find good examples in that repo, and I also
just posted some cases to Isar upstream [1].

Once that is done and you have Debian running, only I-pipe issues should remain,
unless the board has been manually enabled before for this.

What would definitely be more "interesting" is enabling PowerPC for the first
time because this is not supported by Isar yet (though that should only be about
adding some arch definitions), I have no clue about the general Debian status,
and I do not know which QEMU target would be best to start with (as many of us
will likely not have any board in reach). But I do want this see this working as
well.

Jan

[1] https://groups.google.com/forum/#!topic/isar-users/AvDmjp2z9Zo

> -Greg
> 
> On Tue, Nov 6, 2018 at 1:58 PM Jan Kiszka via Xenomai
> <xenomai@xenomai.org> wrote:
>>
>> Hi all,
>>
>> as I was (and still am) in the need to test also non-x86 from time to time, I
>> hacked up a little framework for generating bootable Debian images with Xenomai
>> pre-installed. It's currently hosted on my personal github space:
>>
>> https://github.com/jan-kiszka/xenomai-images
>>
>> I think we should move this over to the Xenomai group at gitlab.denx.de and
>> expand this step-wise with more archs (that QEMU support) as well as real
>> targets. I think I will add the HiKey board tomorrow, should be rather simple as
>> I did this for jailhouse-images [1], the inspiration and source of this layer,
>> just recently. Provided the ipipe kernel works fine with it.
>>
>> Comments? Suggestions? Opinions?
>>
>> Jan
>>
>> [1] https://github.com/siemens/jailhouse-images
>>
>> --
>> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>> Corporate Competence Center Embedded Linux
>>


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

