Message-ID: <53FE46B5.4010001@mitre.org>
Date: Wed, 27 Aug 2014 16:59:33 -0400
From: Jeffrey Melville <jmelville@mitre.org>
MIME-Version: 1.0
References: <53F4B4DA.6050703@mitre.org> <53F4F273.7090104@xenomai.org>
In-Reply-To: <53F4F273.7090104@xenomai.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtdm_iomap_to_user caching followup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 8/20/2014 3:09 PM, Gilles Chanteperdrix wrote:
> On 08/20/2014 04:46 PM, Jeffrey Melville wrote:
>> All,
>>
>> There was a patch applied back in January 2013 to disable caching with
>> memory areas mapped with rtdm_iomap_to_user.
>> (http://www.xenomai.org/pipermail/xenomai/2013-January/027370.html)
>>
>> Henri Roosen followed up in September 2013 to say that he still saw
>> caching behavior with rtdm_iomap_to_user. The original patch didn't
>> cover the ifdef LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,16) &&
>> defined(CONFIG_MMU). He submitted two patch options but I didn't see any
>> responses.
>> (http://www.xenomai.org/pipermail/xenomai/2013-September/029211.html)
>
>
> I believe this has been merged with commit
> http://git.xenomai.org/xenomai-2.6.git/commit/?id=1b8fb14e486ac0604e44067a0f1f89dc14153e95
>
> Could you try xenomai 2.6 git to see if you still have the issue?
>
Gilles,

Thanks for your response. My mistake, I thought I had already looked at 
the 2.6 git head. The commit you mentioned is the right one. I tested 
the 2.6 git on my hardware and didn't have any lockup issues. Yocto 
actually still mistakenly applied my old patch against the kmem wrapper 
(which I'm not using anywhere). I need to remove that from my build but 
otherwise everything looks good for now.

Cheers,
Jeff

