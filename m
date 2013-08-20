Message-ID: <5213B966.1010604@gmail.com>
Date: Tue, 20 Aug 2013 20:45:58 +0200
From: Sagar Behere <sagar.behere@gmail.com>
MIME-Version: 1.0
References: <52138425.2030000@steinkuehler.net> <5213B7D3.5030606@xenomai.org>
In-Reply-To: <5213B7D3.5030606@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Building BeagleBone kernel from git
Reply-To: sagar.behere@gmail.com
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 08/20/2013 08:39 PM, Gilles Chanteperdrix wrote:
> On 08/20/2013 04:58 PM, Charles Steinkuehler wrote:
>> I am currently working with LinuxCNC in a xenomai real-time environment
>> on the BeagleBone:
>>
>> http://bb-lcnc.blogspot.com/p/machinekit_16.html
>>
>> Everything is working well, but the kernel is being built using an
>> out-of-tree patch set obtained by Michael Haberler.
>>
>> I would like to switch to using a more 'official' xenomai build from
>> git, but am unclear how to proceed.
>>
>> Which git repository/branch would be the most appropriate for use in
>> building a xenomai kernel for the BeagleBone / AM335x SoC?
>>
>> Are there any 'gotchas' when using xenomai from git, or do the
>> instructions and procedures for using a released version apply?
>
> You can use kernel from the I-pipe git at:
> git://git.xenomai.org/ipipe.git branch ipipe-3.8
>
> And xenomai from the xenomai 2.6 git at:
> git://git.xenomai.org/xenomai-2.6.git branch master
>
> The only difference in the installation procedure when using this kernel
> with this version of Xenomai is that the "prepare-kernel.sh" script will
> not apply the I-pipe patch to the kernel, since the kernel is already
> patched, so the argument to the "--adeos" parameter of prepare-kernel.sh
> is ignored.

For what it's worth, I tried this procedure and documented it

https://github.com/sagarbehere/beaglebone-xenomai/blob/master/beaglebone-xenomai-debian.md

I used the for-upstream/3.8 branch, but it should be similar for the 
ipipe-3.8 branch.

If you improve upon the procedure, please let me know and I will update 
the document accordingly, or fork it and send me a pull request :)

Regards,
Sagar

