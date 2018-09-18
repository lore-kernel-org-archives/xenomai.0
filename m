References: <51e26820-fb3f-0404-f799-2c87020a211d@gmail.com>
 <ee61ace6-ac6b-ed36-bcbf-9b17add27c09@siemens.com>
 <80b359f3-0a8a-6165-bb0f-4603aed42416@gmail.com>
 <86e38d35-c79f-2fe7-1976-85c784e473c8@siemens.com>
From: Edouard Tisserant <edouard.tisserant@gmail.com>
Message-ID: <9dff5b4c-03f1-fb62-e6c6-cbab57494592@gmail.com>
Date: Tue, 18 Sep 2018 12:30:26 +0200
MIME-Version: 1.0
In-Reply-To: <86e38d35-c79f-2fe7-1976-85c784e473c8@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Xenomai] [PATCH 0/1] Add non-RT sendmsg and recvmsg in
 rtpacket.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>



>> =C2=A0Why it is reserved only to userspace apps ? ;)
>
> Because there is no syscall entry point for kernel threads so that we
> could easily detect the condition and migrate them. And there are also
> no general use cases, I'm afraid.=20

Definitely. I was just kidding :)

> In your scenario, just spawn your own RT kernel thread, like RTnet
> does for some purposes as well (RTcfg eg.), and let that thread drive
> the periodic transmission. Does the current non-rt thread do anything
> with Linux at all? If not, migration would be even simpler.

It does. But no problem I'll just move those calls to rtpc_* in
rtdmnet.c, and use rtdm_in_rt_context() to decide.

rtpc_* calls are quite handy in that case. Symbols are exposed, but they
aren't documented in API, so I suppose they are not part of the "RTDM
Driver programming Interface" that I should use in that case... Is it
planned to have them in API ?

Edouard





