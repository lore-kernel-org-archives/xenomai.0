Subject: Re: Could anybody help to reslove the question about _RTIOC_LISTEN?
References: <CAAvDm6YJC2r0Kj6+sLAueja0cBnua161gXbtprgh94GknCJQ9Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ee8ed0f9-356a-d172-8c8c-c74bbdf30913@siemens.com>
Date: Mon, 11 May 2020 08:48:09 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6YJC2r0Kj6+sLAueja0cBnua161gXbtprgh94GknCJQ9Q@mail.gmail.com>
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

On 11.05.20 07:59, 孙世龙 via Xenomai wrote:
> Hi,
>         As per the source code(
> https://gitlab.denx.de/Xenomai/xenomai/-/blob/v3.0.9/kernel/drivers/net/stack/ipv4/tcp/tcp.c),
> I could see that some code have relation to  _RTIOC_LISTEN.For details, see
> below.
> 

lib/cobalt/rtdm.c, COBALT_IMPL(int, listen, (int fd, int backlog)). So, 
if you wrap your posix application, it will first try _RTIOC_LISTEN via 
Xenomai on an fd and then fall back to regular listen. If the fd 
happened to be an rt-tcp socket, that driver above will be called.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

