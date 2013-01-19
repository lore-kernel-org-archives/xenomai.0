Message-ID: <50FAE4B0.60505@xenomai.org>
Date: Sat, 19 Jan 2013 19:23:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <718DFA7882181D45B8BD18F31C46D554218F71D6@MBX201.domain.local>,
	<50FA920A.1070900@xenomai.org>
	<718DFA7882181D45B8BD18F31C46D554219008E1@MBX201.domain.local>
In-Reply-To: <718DFA7882181D45B8BD18F31C46D554219008E1@MBX201.domain.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai Documentation for ARM Integration
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gregory Perry <Gregory.Perry@govirtual.tv>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/19/2013 07:12 PM, Gregory Perry wrote:

>> ________________________________________ From: Gilles Chanteperdrix
>> [gilles.chanteperdrix@xenomai.org] Sent: Saturday, January 19, 2013
>> 7:31 AM To: Gregory Perry Cc: xenomai@xenomai.org Subject: Re:
>> [Xenomai] Xenomai Documentation for ARM Integration
> [...]
>> This process is already documented in the README.INSTALL guide... 
>> The part we do not document is the configuration and compilation
>> of the Linux kernel, someone else volunteered to provide more
>> documentation on this subject, you may want to coordinate your
>> efforts with him.
> 
> It seems that this is the step where most of the confusion arises;
> OpenEmbedded with Bitbake recipes are the recommended method for
> compiling a kernel on the BeagleBone, but the way that OE is setup
> does not facilitate easy patching of the kernel or even a reasonable
> way to fetch a specific kernel revision that is compatible with
> Xenomai.  Subsequent invocations of Bitbake will then destroy changes
> that have been made to a custom kernel, there has to be a better way
> to maintain a kernel with Xenomai than this.  I am thinking a non-OE
> kernel + Xenomai integrated git repo with Buildroot for creating a
> minimal target kernel and filesystem with userland Xenomai support.
> Unless there is a better way than this?


As I have already said several times, putting Xenomai and the I-pipe
kernel in the same repository is a bad idea. It makes hard upgrading any
of the two without the other, and following Xenomai stable branch is the
recommended way of working. The rules should be made such that xenomai
and the kernel are two separate dirs, and run prepare-kernel.sh before
compiling the kernel. The custom rootfs build system we use for testing
xenomai works this way, I have worked this way with snapgear, buildroot
works this way[1] and I bet any rootfs build system can be made to work
this way.

[1] http://git.buildroot.net/buildroot/tree/linux/linux-ext-xenomai.mk



-- 
                                                                Gilles.

