Message-ID: <53346FF7.9010509@xenomai.org>
Date: Thu, 27 Mar 2014 19:37:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAEbDrgn=VM340xozWgS=8aap5Wkw2YCynGDSwtj9m1415J+XYw@mail.gmail.com>
 <44ha6j7j1j.fsf@lowell-desk.lan>
In-Reply-To: <44ha6j7j1j.fsf@lowell-desk.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Raspberry Pi - 3.10.34
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/27/2014 04:33 PM, Lowell Gilbert wrote:
> Gregory Dymarek <gregd72002@gmail.com> writes:
>
>> To get kernel 3.10.34 to work the ipipe patch needs updating.
>> (ipipe-3.8.x does not apply cleanly).
>>
>> What is the process to release a new ipipe patch for 3.10.34?
>>
>> Or what is the alternative?
>
> The source control trees are easily available, so there are a lot of
> options.
>
> I did a "git merge" to bring the ipipe-3.10 branch into my 3.10 kernel
> branch. If I didn't have a lot of my own (evolving) hardware to deal
> with, I might not have needed to merge at all, so the ipipe-3.10 branch
> itself might be good enough for some people.
>
> Producing the patch may be as simple as a simple "git diff" operation.

It is a bit more complicated than that:
- git diff will produce a huge patch with all the architectures in, for 
this reason, there is a script in the I-pipe git to output only the 
changes for arm, scripts/ipipe/genpatches.sh
- if you want your patch to be distributed with Xenomai, we do not take 
a complete patch for the forked kernel, which would duplicate a lot of 
the contents of the vanilla patch, and lead to a maintenance nightmare 
every time we want to update the generic parts of the patch.

So, we use -pre and -post patches, which contain only the changes 
necessary for the forked kernel. The -pre patch is applied on the forked 
kernel sources so that the mainline patch applies, then the -post patch 
is applied after to revert the changes made by the -pre patch, and add 
the changes specific to the forked kernel.

In order to generate a -pre and -post patch. Start by merging the 
ipipe-3.10 branch with your forked kernel, as Gilbert says. This will be 
your reference branch.

Create a branch which contains only the forked kernel. Try and apply the 
mainline patch in "dry-run" mode. Reset every file which causes a 
conflict with the patch to the contents of the mainline kernel. The 
difference between the result of this operation and the forked kernel is 
the -pre patch.

Apply the mainline patch, which should apply without conflicts.

The difference between the reference branch and the result of this 
operation is the -post patch.

You can then verify that starting from the forked kernel, and applying, 
in this order, the -pre, the mainline, and the -post patches leads to 
the same result as your reference branch.

>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
					    Gilles.

