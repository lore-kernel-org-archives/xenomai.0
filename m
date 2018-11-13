Subject: Re: Xenomai support for arm64
References: <3e868e4f-7bd5-2874-d72b-fc2449ef4b65@siemens.com>
 <111becaa-9e0f-f8ad-4802-62f51379fc07@xenomai.org>
 <08f84d9f-594c-8d82-1da8-f747430226e3@xenomai.org>
 <3b2d567d-b489-723c-41de-9c73fb755763@siemens.com>
 <8ced9265-1312-0e13-d2dc-3813de0bccbf@linx-info.com>
 <cc54c85a-9a72-c7d8-e5be-17e7a1f78acd@linx-info.com>
 <CALLqZ8T-avpC9_3iJUrwHmr9k=wqCxbDu-8EfcHa-_W-Kmk_Fw@mail.gmail.com>
From: duanwujie <wjduan@linx-info.com>
Message-ID: <9717d431-e10d-cba4-b4e9-ba5cba64536b@linx-info.com>
Date: Tue, 13 Nov 2018 11:15:24 +0800
MIME-Version: 1.0
In-Reply-To: <CALLqZ8T-avpC9_3iJUrwHmr9k=wqCxbDu-8EfcHa-_W-Kmk_Fw@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: Philippe Gerum <rpm@xenomai.org>, Dmitriy Cherkasov <dmitriy@oss-tech.org>, Xenomai <xenomai@xenomai.org>, =?UTF-8?B?5b2t5b+X6Iiq?= <zhpeng@linx-info.com>

We are using the DragonBoard 410c, after that we  will choose the 
specific board which not support by xenomai.

Before that, we thought that xenomai could be used directly after the 
I-pipe work was completed, but the real situation is not like this.

So we hope find the way of port xenomai to arm64 !  In the wiki of 
xenomai  , there's no detail description of how to port xenomai to 
arm64. I hope to find a way from you.

At 2018/11/12 Afternoon 9:17, Greg Gallagher Write:
> What board are you using? Arm64 works on a handful of boards so far. 
> You may need to enable support for the specific board you are using.
>
> Greg
>
> On Mon., Nov. 12, 2018, 2:20 a.m. duanwujie via Xenomai 
> <xenomai@xenomai.org <mailto:xenomai@xenomai.org> wrote:
>
>
>     On the arm64 already have ipipe patch , but the Xenomai not properly
>     worked on the arm64.
>
>     In order to support arm64, what other work needs to be done! Can you
>     provide some clues?
>
