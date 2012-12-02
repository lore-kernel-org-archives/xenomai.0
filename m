MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sun, 02 Dec 2012 14:53:29 +0100
From: WONG Sheng Chao <wong@isir.upmc.fr>
In-Reply-To: <D5733E9B-1AA5-4C5F-A2E8-1346A11A7E4C@mah.priv.at>
References: "\"<mailman.0.1354186801.18650.xenomai@xenomai.org>"
	<6F62EBB3-71FC-47B6-B6A4-9A2A7EFE793B@kabelmail.de>"
	<bf6a998422f24fab874ae21fd0adb396@isir.upmc.fr>
	<F74C5334-2EAF-4D8E-AE55-38BF37437EE6@mah.priv.at>
	<50B8B7A8.2010800@xenomai.org>
	<D5733E9B-1AA5-4C5F-A2E8-1346A11A7E4C@mah.priv.at>
Message-ID: <7563882586f5c36943667b067978e7ff@isir.upmc.fr>
Subject: Re: [Xenomai] Compiling I-pipe patched kernel on beaglebone from
 Angstrom branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org

On Fri, 30 Nov 2012 20:22:11 +0100, Michael Haberler wrote:
> Am 30.11.2012 um 14:42 schrieb Gilles Chanteperdrix:
>
>> On 11/30/2012 12:45 PM, Michael Haberler wrote:
>>>
>>> Am 30.11.2012 um 09:54 schrieb WONG Sheng Chao:
>>>
>>>> On Thu, 29 Nov 2012 13:16:31 +0100, Stephan Kappertz wrote:
>>>>>
>>>>> The problem is that you are using the wrong timer.
>>>>> ...
>>>
>>>>>
>>>>> #endif
>>>>>
>>>>> - Stephan
>>>>
>>>> Thanks a lot Stephan and Gilles! The kernel is now able to boot 
>>>> with both CONFIG_XENOMAI and CONFIG_IPIPE.
>>>
>>> great! could you publish a complete patch relative to a known base?
>>>
>>> thanks in advance,
>>
>> As I already said, if someone takes the little time it takes to 
>> generate
>> a pre and post patch (I explained the why and how in a previous 
>> mail),
>> we can even integrate it in xenomai repository.

I am trying to generate the pre and post patch following the 
instructions from this mail

http://www.xenomai.org/pipermail/xenomai/2012-September/026190.html

But I am still not clear on the pre-patch part especially this part of 
the mail

The pre-patch is the reverse diff between the files in the vanilla 
kernel,
and the files conflicting in the vendor branch.
Generate the pre-patch.
git reset --hard
git clean -df (beware this erases all files non commited in git, so do
not do that if you keep precious files not under git control)


 From what I understand so far, the steps to make the pre and post patch 
are as follow

1) Make a copy of the original_vendor_kernel_source and run git commit.

2) I ran the i-pipe patch from xenomai/scripts with the linux_tree 
pointing to the original_vender_kernel_source to check for the 
conflicting files.

3) I fix the conflicting files in the original_verndor_kernel_source by 
replacing the files from the vanilla_kernel_source

4) I use git diff to create a patch, is this consider a pre-patch?

5) I ran the i-pipe patch again, now the i-pipe will patch 
successfully, commit the changes

6) Modify the timer.c, irq.c, some includes file, and create the post 
patch with git diff.

Is this flow correct?


>
> I'll take that on after I have something working.
>
> The beaglebone has very good potential for RT applications especially
> with the PRU coprocessors which are dead simple to use and blazing
> fast, so I see some folks coming in that direction.

Hi Michael

I am still trying to figure out how to make the proper pre and psot 
patch files. But I do have a txt files which I wrote down the steps and 
changes I made based on advice from Gilles and Stephen to make Xenomai 
running on my Beaglebone for the Angstrom branch. If you are interested 
I can send the txt file to you.

- Wong

