References: <3b845105-f0b5-6df1-c800-e4bb954d8aa0@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <238db18f-bbec-716a-a022-f806bce7b5b9@xenomai.org>
Date: Wed, 24 Jan 2018 18:29:34 +0100
MIME-Version: 1.0
In-Reply-To: <3b845105-f0b5-6df1-c800-e4bb954d8aa0@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe: kernel updates in the light of recent fixes
	(meltdown...)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>


Hi Jan,

On 01/23/2018 06:52 PM, Jan Kiszka wrote:
> Hi Philippe,
> 
> as the number of question increase here, but I bet elsewhere as well,
> and I'm planning to work on some parts soonish, I'd like to coordinate:
> 
> Where are we standing with 4.14 right now? There is nothing for x86 yet,
> right?
>

Correct.

> What are the update plans for 4.9? We currently have one x86 user on
> that kernel, but I suppose we could also move on to 4.14 once it's
> ready. For me the question is right now where to invest x86-wise, 4.9
> update or 4.14 completion + update?
> 

Regarding x86, 4.9 is still the current release for the pipeline.
Porting to 4.14/x86 requires an overhaul of the fpu management in the
pipeline and cobalt cores (actually, the mainline changes requiring this
were introduced in the 4.11 timeframe). The basic issue is about
dropping the assumptions cobalt does about the kernel using the lazy fpu
scheme, since mainline switched to strict eager mode for x86, dropping
the former option entirely.

> For 4.4, which we will need for product use for sure, I'm considering to
> lift the support from 4.4 LTS to the CIP [1][2] kernel. That one will be
> longer maintained and basically differs from LTS only in mainline
> backports of certain hardware support and critical features. Plus some
> reverts of broken LTS commits that will later on be reverted there as
> well. The fuss that meltdown brings in would be a good point to do the
> jump IMHO (there is no CIP kernel with meltdown fixes yet, due to issues
> in LTS, but that will change soon).
>

No objection.

> Regarding spectre, I'm not expected that much impact on ipipe, but that
> situation is still too much in flux, even in upstream.
> 
> What do you think?
> 

I did not have any issue porting dovetail (4th gen pipeline) to
arm/4.15; although the pipeline implementation is quite different, the
mm portions are similar, so there is hope for the current pipeline with
respect to mainline changes to the generic vm core, the situation with
x86-specific bits is likely going to be different for obvious reasons. I
did not check in details though.

> @all: What are requirements of other users here?
> 
> Jan
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-cip.git
> [2]
> https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipkernelmaintenance
> 


-- 
Philippe.

