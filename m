From: Philippe Gerum <rpm@xenomai.org>
References: <CAF06wtj2YM_Ue0Hzw5+LChWtve_3ta390aAu0CixsCQd+12bwg@mail.gmail.com>
 <CAO460__o2krnbVrxCtkh3dT8Li3yUnyxm3N7T+tonPsZdq_1Gw@mail.gmail.com>
 <fa961a8b-01b6-6268-6ba4-5747c3c78513@xenomai.org>
 <CAO460__1uc5Z8VDT+dsvkwkG+N7tiim6X7-h22nu6tBmijoG4w@mail.gmail.com>
Message-ID: <ab4ff9e3-d6ef-39af-ce18-9894957014c7@xenomai.org>
Date: Tue, 5 Sep 2017 19:57:11 +0200
MIME-Version: 1.0
In-Reply-To: <CAO460__1uc5Z8VDT+dsvkwkG+N7tiim6X7-h22nu6tBmijoG4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Two Minor Issues with Patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Stephen D. Cohen" <steve@uscohens.com>, xenomai@xenomai.org

On 09/01/2017 05:48 AM, Stephen D. Cohen wrote:
>      MAP_EXECUTABLE is set for any code section, so applies to shared
> libraries, PIE executables, etc. as well as executable files.

True, which means that this code never actually worked, even in its
original form... The reason it _seemed_ to work back then was because
all tests triggered relax spots from an executable, and never from DSOs:
IOW, no offset was ever subtracted from the offending $ip, which is
correct for pure executables.

 The
> vm_mmap() flag to follow that uniquely identifies an executable file is
> MAP_FIXED. I encourage you to chase it down the vm_mmap() rabbit hole
> and see that there is no corresponding flag set in the vm_flags of the
> vm_area_struct. At least not that I could find. A quick perusal of the
> definitions for the VM_XXX flags will show a pretty clear lack of a
> candidate for identifying fixed mappings as well, to reinforce this finding.
> 

I did not find any. AFAICT, load_elf_binary() sets MAP_FIXED for ET_DYN
types too, when the first loadable segment is seen by the mapping loop.

>      So with no other option, I went to the brute-force look in the ELF
> header approach I submitted. This is not really as awful as it seems,
> given that the sum-total of its operations is to read four bytes to make
> sure it is an mapped ELF file, then read two bytes to check the type.
> Perhaps there is some opportunity for vmas to be marked execute only so
> that the read would cause an issue? My tracking through the ELF mapping
> routines suggest this does not happen - the files are always mapped with
> read enabled. Plus the code is running in the kernel so, at least in
> theory, has full access regardless of the vm_flags.
> 

Ack.

>      So with a lack of better options, and a sort of sour taste in my
> mouth, I implemented what I submitted. I would love to be proven wrong,
> but in the mean time I enjoy having slackspot actually work.
> 

Ok, let's give it a day or two, so that I can squeeze in deeper review.
If no alternate option is found which does not depend on figuring out
the binary format the hard way, we'll go for your proposal.

>     We should move that to xeno-config*.in instead, as not everyone uses
>     wrap-link.sh. xeno-config would emit -no-pie, based on the detection
>     done in configure.ac <http://configure.ac>, of a compiler enabling
>     PIE by default.
> 
> 
>      But the issue only applies to the stage1 phase of wrap-link. There
> is no fundamental issue with creating and running PIE binaries under
> Xenomai. The problem is exclusive to stage1 of wrap-link passing the
> "-r" flag to ld.
> 
>     IOW, configure.ac <http://configure.ac> figures out whether $CC has
>     default-pie, setting a
>     substitution variable which xeno-config*.in emits when dumping the
>     CFLAGS.
> 
> 
>      But then you are preventing PIE binaries entirely. This may "solve"
> the problem, but PIE binaries are here to stay and significantly help to
> improve system security. Why force them off entirely without reason?
>  

The suggested approach was not aimed at forcing them off, only switching
back to the previous situation where pie was opt-in, not default. So
basically, changing xeno-config would make this opt-in again, but then
wrap-link.sh would still have a problem for people enable passing
$(xeno_config --ldflags) -pie. So, this idea was wrong and irrelevant
anyway.

Ok, fixing wrap-link.sh is the best idea. The proposed patch would break
cross-compilation though - we are not using the host's gcc compiler in
this case. We'd need to invoke $cc instead, but without the accumulated
flags, only the command path when giving --version.

-- 
Philippe.


