References: <B89CCBE86D4F62448EE4F6367C6D3C89221E32ED@USMLVA0EM24MSX.ww017.siemens.net>
 <560AB34B.5020300@xenomai.org>
 <B89CCBE86D4F62448EE4F6367C6D3C89221E4342@USMLVA0EM24MSX.ww017.siemens.net>
 <560AB938.8090905@xenomai.org>
 <B89CCBE86D4F62448EE4F6367C6D3C89221E435B@USMLVA0EM24MSX.ww017.siemens.net>
 <B89CCBE86D4F62448EE4F6367C6D3C89221E4474@USMLVA0EM24MSX.ww017.siemens.net>
 <B89CCBE86D4F62448EE4F6367C6D3C89221E4503@USMLVA0EM24MSX.ww017.siemens.net>
 <B89CCBE86D4F62448EE4F6367C6D3C89221EA9F2@USMLVA0EM24MSX.ww017.siemens.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <561568AE.30109@xenomai.org>
Date: Wed, 7 Oct 2015 20:47:10 +0200
MIME-Version: 1.0
In-Reply-To: <B89CCBE86D4F62448EE4F6367C6D3C89221EA9F2@USMLVA0EM24MSX.ww017.siemens.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Interrupt latency close to 1ms on powerpc Xenomai
	2.6.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "PRADHAN, MAKARAND (RC-CA)" <makarand.pradhan@siemens.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/07/2015 04:25 PM, PRADHAN, MAKARAND (RC-CA) wrote:
> Hi All,
> 
> On further experimentation, I still feel that rt_intr_enable may be causing my user space int handler to jump into secondary domain.
> 

rt_intr_enable() is a secondary domain call, it cannot execute over the
primary domain simply because the infrastructure shared with the regular
kernel that might be involved to enable/disable IRQs requires this. The
nucleus forcibly relaxes the calling thread for this reason. So the
behavior you observe is not a bug, it is actually the intent and
requirement for carrying out such request. Check
ksrc/native/syscall.c:4152, this call is tagged as "lostage", meaning
that it shall run from the lowest pipeline domain stage, i.e. linux.

This is the reason why handling interrupt top-halves in userland is a
bad idea, and also the reason why the RT_INTR support has completely
disappeared from 3.x's Alchemy API (formerly know as 2.x's "native"
API), in favor of a UIO-like model called UDD, standing for "user-space
device driver". There, top-halves must live in kernel space, and
bottom-halves may live in userland, which is the only sane and safe way
to handle interrupts from the latter.

The rationale for this change is stated here:
http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/#irqhandling

-- 
Philippe.

