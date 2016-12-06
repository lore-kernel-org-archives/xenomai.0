MIME-Version: 1.0
In-Reply-To: <20ca0cb9-9b12-c60b-1957-b925ed97152d@xenomai.org>
References: <CAMJ=MEfiDuUFduQp7=TgLcNn4NQvr7UKYgS1RrnZMT21+Ohsdg@mail.gmail.com>
 <20ca0cb9-9b12-c60b-1957-b925ed97152d@xenomai.org>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Tue, 6 Dec 2016 14:18:18 +0100
Message-ID: <CAMJ=MEenBOXEXyBaKO8nfyiwZ+7rH0a615ZhNkeeCbEveVhDPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Question about the implementation of tunables.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, Dec 6, 2016 at 1:06 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 12/05/2016 05:36 PM, Ronny Meeus wrote:
>> Hello
>>
>> we use the pSOS skin over the Mercury core.
>>
>> I'm preparing a set of patches that introduce new tunables.
>> What I observe is that in a small test applications it works well but once I
>> start to use these in our real applications, I observe that the tunables are
>> not called.
>>
>> I have identified that the root-cause of this is that we postpone the calling
>> of the static constructors to a certain point in the application init and call
>> __do_global_ctors_aux ourselves.
>> (to make this work our build enviroment uses the -nostartfiles linker option
>> and some other constructs ...)
>>
>> Now the question is: are there any option to make this work or have other
>> people seen similar issues before?
>> So we should be able to call the static constructors of the tunables only
>> before we call copperplate_init ...
>>
>
> It's not a matter of building a small or large application, it is a
> matter of disabling the normal runtime init code by passing the
> -nostartfiles option to the linker, which could affect a so-called small
> test program the same way.
>
> I don't see any reasonable way to fix the issue with your app: like any
> regular user-space code may do, the Xenomai libs depends on the regular
> C runtime startup code to execute prior to entering main(). Since you
> manually handle the pre-main() init code yourself it seems, you need to
> add the libcopperplate and libpsos .init sections to the list of duties
> your own early runtime code carries out.
>

Thanks Philippe for the feedback.
We will try to find a solution for this.

Ronny

> --
> Philippe.

