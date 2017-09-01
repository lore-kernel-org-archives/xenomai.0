MIME-Version: 1.0
References: <CAF06wtj2YM_Ue0Hzw5+LChWtve_3ta390aAu0CixsCQd+12bwg@mail.gmail.com>
 <CAO460__o2krnbVrxCtkh3dT8Li3yUnyxm3N7T+tonPsZdq_1Gw@mail.gmail.com>
 <fa961a8b-01b6-6268-6ba4-5747c3c78513@xenomai.org>
In-Reply-To: <fa961a8b-01b6-6268-6ba4-5747c3c78513@xenomai.org>
From: "Stephen D. Cohen" <steve@uscohens.com>
Date: Fri, 01 Sep 2017 03:48:30 +0000
Message-ID: <CAO460__1uc5Z8VDT+dsvkwkG+N7tiim6X7-h22nu6tBmijoG4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Two Minor Issues with Patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On Thu, Aug 31, 2017 at 12:13 PM Philippe Gerum <rpm@xenomai.org> wrote:


> It looks like the issue of replacing the initial check for execs was
> left pending since then.
>

     This explains why I was unable to find any way the example in the
documentation could have worked. It was simply from a version earlier than
I had imagined and I did not browse back in history quite far enough.
Though in my defense, it was part of a monolithic whole-file change-set so
rather difficult to spot. I actually find this quite a relief. I did not
like the loose-end of the working ARM example.


> Although this would probably work with both ELF and ELF_FDPIC
> (blackfin), maybe there is a better way to detect an exec mapping;
> peeking at the vma contents for this purpose makes me nervous.
>

     I completely concur on the "makes me nervous" part, but alas there is
no other way.


> Maybe there is a way to relate MAP_EXECUTABLE - as passed to vm_mmap()
> when called by the binfmt loaders - to the vmas, this needs to be
> investigated.
>

     MAP_EXECUTABLE is set for any code section, so applies to shared
libraries, PIE executables, etc. as well as executable files. The vm_mmap()
flag to follow that uniquely identifies an executable file is MAP_FIXED. I
encourage you to chase it down the vm_mmap() rabbit hole and see that there
is no corresponding flag set in the vm_flags of the vm_area_struct. At
least not that I could find. A quick perusal of the definitions for the
VM_XXX flags will show a pretty clear lack of a candidate for identifying
fixed mappings as well, to reinforce this finding.

     So with no other option, I went to the brute-force look in the ELF
header approach I submitted. This is not really as awful as it seems, given
that the sum-total of its operations is to read four bytes to make sure it
is an mapped ELF file, then read two bytes to check the type. Perhaps there
is some opportunity for vmas to be marked execute only so that the read
would cause an issue? My tracking through the ELF mapping routines suggest
this does not happen - the files are always mapped with read enabled. Plus
the code is running in the kernel so, at least in theory, has full access
regardless of the vm_flags.

     So with a lack of better options, and a sort of sour taste in my
mouth, I implemented what I submitted. I would love to be proven wrong, but
in the mean time I enjoy having slackspot actually work.

We should move that to xeno-config*.in instead, as not everyone uses
> wrap-link.sh. xeno-config would emit -no-pie, based on the detection
> done in configure.ac, of a compiler enabling PIE by default.
>

     But the issue only applies to the stage1 phase of wrap-link. There is
no fundamental issue with creating and running PIE binaries under Xenomai.
The problem is exclusive to stage1 of wrap-link passing the "-r" flag to ld.

IOW, configure.ac figures out whether $CC has default-pie, setting a
> substitution variable which xeno-config*.in emits when dumping the CFLAGS.
>

     But then you are preventing PIE binaries entirely. This may "solve"
the problem, but PIE binaries are here to stay and significantly help to
improve system security. Why force them off entirely without reason?

Warmest Regards,

Steve
