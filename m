Message-ID: <50FA920A.1070900@xenomai.org>
Date: Sat, 19 Jan 2013 13:31:06 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <718DFA7882181D45B8BD18F31C46D554218F71D6@MBX201.domain.local>
In-Reply-To: <718DFA7882181D45B8BD18F31C46D554218F71D6@MBX201.domain.local>
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

On 01/18/2013 10:26 PM, Gregory Perry wrote:

> Hello,
> 
> I have been following the Xenomai project for a few months now and it
> seems there is a lot of confusion about the optimal path to
> integrating Xenomai with the appropriate I-pipe patches and other
> legwork required to get it running and stable on ARM platforms such
> as the BeagleBone and Raspberry Pi.


The simplest solution is to integrate the support for these processors 
to the mainline kernel so that the I-pipe support can be merged in the 
I-pipe patch itself. That is what I tried to tell here:
http://xenomai.org/index.php/I-pipe-core:ArmPorting#Publishing_your_modifications

Failing that, I recommended, several times, to provide pre and post
patches allowing to apply the support for the additional processor in
addition to the I-pipe patch, explained how to generate these 
patches, and said that we would be glad to distribute these patches
as part of the xenomai tarball.

> 
> I would be willing to document at length the entire process required
> for building a kernel successfully with all userland and kernel
> support required, but I want to make sure that it is a workflow
> advocated by the project maintainers in terms of the build
> environment, patching process, and performance testing objectives of
> the documentation.


This process is already documented in the README.INSTALL guide...
The part we do not document is the configuration and compilation of
the Linux kernel, someone else volunteered to provide more documentation
on this subject, you may want to coordinate your efforts with him.

> 
> Is there any interest in this and would someone from the Xenomai
> project be willing to provide answers to questions if I were to write
> up the documentation?  In the long run it would probably cut down on
> most if not all of the redundant "how do I get Xenomai running on the
> BeagleBone" threads that pop up from time to time.


>From my point of view, these threads exist because the work on BeagleBone
is still separated.


-- 
                                                                Gilles.

