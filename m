From: Paul <paul_c@tuxcnc.org>
Date: Fri, 19 Apr 2013 15:19:55 +0100
References: <bbc6252ba3dfdbef5f91d311e740e966@apollo.open-resource.org>
In-Reply-To: <bbc6252ba3dfdbef5f91d311e740e966@apollo.open-resource.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201304191519.55313.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] Xenomai, Raspberry Pi, 3.5.7 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: chrono <chrono@open-resource.org>
Cc: xenomai@xenomai.org

On Friday 19 April 2013, chrono wrote:
> Hi everyone, Paul

> I was looking for a more recent xenomai + pi setup than 3.2.27 and
> found
> your post on the ML which encouraged me to try to compile a more
> recent PI Kernel with Xenomai in order to play with LinuxCNC on the
> PI.

You really don't want to go down that route... Accept that the Raspberry 
is an educational tool and teaching aid.

> Test 1:
>
> 1. Fetched the RPI Kernel sources:
> git clone git://github.com/raspberrypi/linux.git linux-rpi

Wrong. No one has suggested using the modified sources from the 
RaspberryPi repository.

> 2. Tried to get back to the commit you suggested (871eef1b84)
> 3. Download xenomai-2.6.1 and unpack
> 4. Downloaded Paul's combined patch
> (http://www.xenomai.org/pipermail/xenomai/attachments/20130216/4f487e
>30/attachment.patch)
>
> xenomai-2.6.1/scripts/prepare-kernel.sh  --arch=arm
> --adeos=/usr/src/xenomai-2.6.1/ksrc/arch/arm/patches/ipipe-core-3.5.7
>-arm.patch --linux=/usr/src/linux-rpi
>
> Almost all hunks failed to apply and it ends with:
>
> prepare-kernel.sh: Unable to patch kernel 3.6.11 with
> ipipe-core-3.5.7-arm.patch.

Entirely predictable - You are trying to patch one (modified) kernel 
version with a patch intended for a completely different one.


> Test 2:
> 1. Reset kernel to suggested commit
> git reset --hard 871eef1b84
> 2. Download xenomai-2.6.2.1 and unpack
> 3. Trying to patch with the bundled ipipe arm patch
> xenomai-2.6.2.1/scripts/prepare-kernel.sh  --arch=arm
> --adeos=/usr/src/xenomai-2.6.2.1/ksrc/arch/arm/patches/ipipe-core-3.5
>.7-arm-3.patch --linux=/usr/src/linux-rpi
[...]
> prepare-kernel.sh: Unable to patch kernel 3.6.11 with
> ipipe-core-3.5.7-arm-3.patch.

See above. 

> Paul, you mentioned: "This assumes the appropriate arm patch has
> already
> been applied to a virgin stable 3.5.7 tree as per standard
> instructions."

Download an unpatched kernel source tarball from www.kernel.org, 
specifically the 3.5.7, unpack, run the prepare-kernel.sh script, and 
THEN apply the Raspberry Pi patch that accompanies the xenomai-2.6.2.1 
sources.

> What am I missing here?

No comment.

> Thanks a lot for all your time and efforts to put Xenomai/LinuxCNC to
> the PI :)

My interest lies purely with Xenomai and real applications - A patch for 
3.8.y should be ready in a day or three.


Regards, Paul.






