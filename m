Message-ID: <513A2F68.4000404@xenomai.org>
Date: Fri, 08 Mar 2013 19:35:20 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAMJ=MEdBofo5+uaFiTLpEE6mHaFhEit=Ae=i=05wu0+fydo2=g@mail.gmail.com>
	<5139FDB3.5010207@xenomai.org> <5139FE6C.7030407@xenomai.org>
	<CAAXf6LVQG2RDwZZfxepJKFxeiLjJAW=Ua1z1PbWVDfOuV7tEAQ@mail.gmail.com>
In-Reply-To: <CAAXf6LVQG2RDwZZfxepJKFxeiLjJAW=Ua1z1PbWVDfOuV7tEAQ@mail.gmail.com>
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

On 03/08/2013 05:08 PM, Thomas De Schampheleire wrote:
> Hi Philippe,
>
> On Fri, Mar 8, 2013 at 4:06 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>> On 03/08/2013 04:03 PM, Philippe Gerum wrote:
>>>
>>> On 03/08/2013 03:16 PM, Ronny Meeus wrote:
>>>>
>>>> Hello
>>>>
>>>> I see that the interface of copperplate_init has been changed from:
>>>>
>>>> void copperplate_init(int argc, char *const argv[]);
>>>> to
>>>> void copperplate_init(int *argcp, char *const **argvp);
>>>>
>>>> This is disturbing if I have an application that needs to be run on
>>>> the 2 versions of xenomai.
>>>> Is there any construction (for example a define) I can use in my code
>>>> to call this function in a correct way?
>>>>
>>>
>>> Nope, and don't expect any. The -forge interface is still in a state of
>>> flux, albeit dust has settled a lot since it was all started. There
>>> won't be any effort toward backward compat until 3.x is officially out.
>>> No ETA.
>
> Although I understand that -forge is still under heavy development,
> isn't it possible to manage it in such a way that people can already
> use it in a more or less stable way?

It should become possible now that the most invasive changes went in.

>
> What about exporting defines with the version, so that an application
> could test for this version and call copperplate_init in the right way
> accordingly? Similar to how you can test the kernel version.

Yes, adding an API rev number one can test can be done.

>
> Another problem point is the occasional rebasing of the -forge tree,
> which causes all commit hashes to change. Is there no other way to
> handle this? I haven't encountered another open-source project doing
> that.

Fact is that -forge has been my private playground for trying new ideas 
for the past years, things which just can't be done in 2.x, with several 
architecture-level changes. Rebasing allowed me to clean up my private 
history from all the non-sense I might have come with until I eventually 
saw the light. Obviously, this approach is annoying to people who don't 
think this should be a private tree anymore. Fair enough.

> We have a local clone of the xenomai-forge tree, and we refer to it
> from buildroot based on the commit hash. If we then want to upgrade
> xenomai-forge, we cannot pull anymore, and have to recreate the entire
> repo. This means that all existing builds no longer work. It would
> really be nice if it were possible to keep existing commits untouched.
>

I'll do my best. Now that people are officially asking for living on the 
bleeding edge using forge, I'll open a -next branch in the forge repo, 
which will be subject to rebasing, keeping the linear history of master 
unbroken.

> Thanks,
> Thomas
>


-- 
Philippe.

