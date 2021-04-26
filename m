Sender: chensong_2000@189.cn
Subject: Re: y2038 wiki/roadmap and development branch update
References: <bd6bbdd2de6f649a5c93a31dd9ef0e1c432d9ca2.camel@siemens.com>
From: "chensong_2000@189.cn" <chensong_2000@189.cn>
Message-ID: <f16dfe97-865f-37ae-5979-11696f3c12bc@189.cn>
Date: Mon, 26 Apr 2021 17:21:28 +0800
MIME-Version: 1.0
In-Reply-To: <bd6bbdd2de6f649a5c93a31dd9ef0e1c432d9ca2.camel@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "chensong@tj.kylinos.cn" <chensong@tj.kylinos.cn>



在 2021/4/23 下午11:30, Bezdeka, Florian 写道:
> Hi Song,
> 
> I just moved the y2038 roadmap we once prepared in my personal
> gitlab.com project to the official Xenomai hackerspace [1].
> 
> In addition there is now a florian/y2038 branch in the Xenomai
> hackerspace [2] which holds the current state. This branch is based on
> current wip/dovetail, so it's not a stable branch and might be rebased
> whenever needed.
> 
> While updating the roadmap I just realized that we already missed two
> affected syscalls, which (according to the current syscall table
> ordering) would be the first two:
>    - sc_cobalt_thread_setschedparam_ex
>    - sc_cobalt_thread_getschedparam_ex

i looked into functions thread_setschedparam_ex/thread_getschedparam_ex, 
didn't find anything about time64, but i will keep it in mind.

> 
> I updated the roadmap accordingly and re-sorted the table. Would be
> nice if you could double-check that again.

done, thanks

Song

> 
> Happy hacking!
> 
> Florian
> 
> 
> [1] https://gitlab.com/Xenomai/xenomai-hacker-space/-/wikis/y2038/Y2038_Roadmap
> [2] https://gitlab.com/Xenomai/xenomai-hacker-space/-/tree/florian/y2038
> 

