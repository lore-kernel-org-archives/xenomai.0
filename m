Message-ID: <55199D31.5080601@xenomai.org>
Date: Mon, 30 Mar 2015 21:00:01 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKk99t15m2dbUzGNxi4TsAVk4suZGc14qxv2cBh+iG1nWcM-kQ@mail.gmail.com>	<55196828.9020207@xenomai.org>	<20150330152002.GL32766@hermes.click-hack.org>	<55196B64.9010901@xenomai.org>	<20150330152957.GN32766@hermes.click-hack.org>	<55196DB0.8020308@xenomai.org>	<CAKk99t2LDG0+CC3360XmaQ-F6zb=OuKLMRCtEgfKYFYouoOYqw@mail.gmail.com>
 <CAKk99t0m=CoE7qw+4aH_UwhK+JYt5Ry5YtDA-7W79q91nOaWsw@mail.gmail.com>
In-Reply-To: <CAKk99t0m=CoE7qw+4aH_UwhK+JYt5Ry5YtDA-7W79q91nOaWsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] There is XDDP Sockets support in kernel?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Helder Daniel <hdaniel@ualg.pt>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/30/2015 05:55 PM, Helder Daniel wrote:
> After moving rtdm_bind() to the module initialization the module loads,
> but now something wrong happened to the kernel :). Probably I left the
> program buggy when moving the xddp-echo example to kernel space. I will
> take a deeper look. 
> 

You probably need to turn on CONFIG_FRAME_POINTER in order to get
meaningful backtraces.

-- 
Philippe.

