Date: Sat, 30 May 2015 16:12:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150530141255.GA25493@hermes.click-hack.org>
References: <CAKC9m6cqL6vFttH3QJM9Z64YqHscF1QGCeP6dq5w=XepGDXgeQ@mail.gmail.com>
 <20150513180613.GE3759@hermes.click-hack.org>
 <CAKC9m6edtqma0t4ddUpqker1Ofx5YDyV6TUXNY3EAZnxyDu2vQ@mail.gmail.com>
 <20150518173654.GC10686@hermes.click-hack.org>
 <CAKC9m6d025dA-8hZ=tRS86+RP9jomraT9MKvBBDdiBNo9DUmwQ@mail.gmail.com>
 <20150519183909.GH10686@hermes.click-hack.org>
 <CAKC9m6e3=O2jhAQ124Mv4+7kEHpkqFFD4THpTgTa=0zWbCJNAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKC9m6e3=O2jhAQ124Mv4+7kEHpkqFFD4THpTgTa=0zWbCJNAA@mail.gmail.com>
Subject: Re: [Xenomai]
 =?utf-8?b?SVJRIGZsb3cgaGFuZGxlcjog4oCcaGFuZGxlX2VkZ2Vf?=
 =?utf-8?b?aXJx4oCdIHZzIOKAnGhhbmRsZV9sZXZlbF9pcnHigJ0=?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hongfei Cheng <hongfei@mperpetuo.com>
Cc: xenomai@xenomai.org

On Fri, May 29, 2015 at 02:32:51PM -0700, Hongfei Cheng wrote:
> Two questions:
> 1). Is the linux spinlock used in its scheduler's complete() function safe
> in this chain of spinlocks?

Definitely not. Obviously. I am even surprised you ask.

> 2). Is there any risk if gic_arch_extn.irq_hold() and
> gic_arch_extn.irq_release() are set as NULL (in the platform driver)?

There should be no reason to define this archiecture hold and
release. Using the mask and unmask ones should be sufficient.
 

-- 
					    Gilles.

