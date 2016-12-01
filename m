References: <e91afecfce4b074fe8e8bcce5d868237@stupar.com>
 <b049cec3-3df5-d18d-a50e-9a9654f9094f@xenomai.org>
 <d990539f06316a5a249ea6dcbb0caf77@stupar.com>
 <20161129020423.07be3fae@Babylon>
From: Jorge Ramirez <jro@xenomai.org>
Message-ID: <0ee05c5d-ef35-9928-f439-02db59f20daf@xenomai.org>
Date: Thu, 1 Dec 2016 08:22:25 -0500
MIME-Version: 1.0
In-Reply-To: <20161129020423.07be3fae@Babylon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Migrating device drivers from RTLinux to
 Xenomai/Analogy
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul <paul_c@tuxcnc.org>, andrija@stupar.com
Cc: xenomai@xenomai.org

On 11/28/2016 09:04 PM, Paul wrote:
> On Mon, 28 Nov 2016 14:34:03 -0500
> andrija@stupar.com wrote:
>
>> Thanks for your reply. I have posted the driver on github:
>> https://github.com/AndrijaPFC/RTDAQDriver/blob/master/acromag.c
> Had a quick scan of the code, and have a couple of observations.
>
> The Linux kernel has seen quite a few changes since the 2.4 days. The
> makefiles for starters. There are also builtin functions for
> downloading fpga binary blobs from disk so you no longer have to hard
> code them in to the module - I'm assuming the missing fpga_prog.h
> contains the binary blob.
>
> The PCI interface has changed and there are also routines to handle
> Industry Pack modules - It may be worth your while contacting Acromag
> and asking them what support they can offer. You may even find drivers
> exist in the latest kernel for your IP modules - These could be used as
> a reference or modified to suit you application.


The effort to get this driver under Xenomai seems trivial (a little bit 
longer if you want to bring it under the Analogy stack, maybe a couple 
of weeks).
You should consider throwing away the code and writing it from scratch 
avoiding some of the terrible hacks they have crafted around some 
platform issues (usleep causing segmentation faults?)



>
>
> Regards, Paul.
>


