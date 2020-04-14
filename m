Subject: Re: I think there is no way to sync objects which are used in both rt
 rtdm ops and nrt rtdm ops.Am i right?
References: <CAAvDm6ZuXW2mhkgPo7NN=_=jfM=FvFcJnNkPYGLLCqn4ysA2yw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <74573d2c-a829-3b38-a4a1-98771337f80a@siemens.com>
Date: Tue, 14 Apr 2020 07:14:43 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6ZuXW2mhkgPo7NN=_=jfM=FvFcJnNkPYGLLCqn4ysA2yw@mail.gmail.com>
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
To: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>, xenomai <xenomai@xenomai.org>

On 14.04.20 06:49, 孙世龙 via Xenomai wrote:
> Hi,
>           I think there is no way to sync objects which are used in both  rt
> rtdm ops and nrt rtdm ops.Am i right?

Use rtdm_spin_* in those cases. Of course, that implies short and 
non-blocking lock-holding times. Non-blocking because those context do 
not share the same scheduler, thus cannot but themselves asleep in the 
same way.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

