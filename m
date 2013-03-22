Message-ID: <514CA003.6080705@xenomai.org>
Date: Fri, 22 Mar 2013 19:16:35 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAMJ=MEdBofo5+uaFiTLpEE6mHaFhEit=Ae=i=05wu0+fydo2=g@mail.gmail.com>
	<5139FDB3.5010207@xenomai.org> <5139FE6C.7030407@xenomai.org>
	<CAAXf6LVQG2RDwZZfxepJKFxeiLjJAW=Ua1z1PbWVDfOuV7tEAQ@mail.gmail.com>
	<513A2F68.4000404@xenomai.org>
	<CAAXf6LUa8t37Vz+A6+0Kcq-MMzHWbBe_rx1EzjRrxHVC-O91bA@mail.gmail.com>
In-Reply-To: <CAAXf6LUa8t37Vz+A6+0Kcq-MMzHWbBe_rx1EzjRrxHVC-O91bA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai-forge: Interface change of copperplate_init
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thomas De Schampheleire <patrickdepinguin@gmail.com>
Cc: xenomai@xenomai.org

On 03/08/2013 08:03 PM, Thomas De Schampheleire wrote:

>> I'll do my best. Now that people are officially asking for living on the
>> bleeding edge using forge, I'll open a -next branch in the forge repo, which
>> will be subject to rebasing, keeping the linear history of master unbroken.
>
> This sounds great, it would help us a lot.
> I think xenomai-forge/Mercury is a great project, and would like to
> thank you for all the effort you put into it, and the great support
> you've given us so far!
>

Please have a look at:
http://git.xenomai.org/?p=xenomai-forge.git;a=commit;h=ec99782c35c4dfa548512434180db303a34d1d2b

Testing CONFIG_XENO_UAPI_LEVEL from userland (xeno_config.h) should 
allow people to issue conditional code depending on the revision level 
of the copperplate library.

Let me know if that fits the bill.

TIA,

-- 
Philippe.

