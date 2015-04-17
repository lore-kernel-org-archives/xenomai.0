Message-ID: <5530BA92.4000708@xenomai.org>
Date: Fri, 17 Apr 2015 09:47:30 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CACreCVJiKuVmA5cnH7sLxK=3-nCJwo=Q-bJFugLgoM8LTDdYWQ@mail.gmail.com>
 <20150416132316.GD1589@hermes.click-hack.org> <552FBC6B.4070402@siemens.com>
 <CACreCVLZwXhFiWzpFewR+a6ab6+SyKQnPLFA7=mP5BcwEFzugA@mail.gmail.com>
 <20150416161819.GG1589@hermes.click-hack.org>
 <CACreCVLbXk1M=pf9o0QcRNbYEeoU_BinVHuokXMO2ec00yngNQ@mail.gmail.com>
In-Reply-To: <CACreCVLbXk1M=pf9o0QcRNbYEeoU_BinVHuokXMO2ec00yngNQ@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] CLOCK_HOST_REALTIME failure on Xenomai 3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: GP Orcullo <kinsamanka@gmail.com>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/17/2015 09:01 AM, GP Orcullo wrote:
> The problem was due to uClibc; I was using buildroot for the initramfs.
> 
> Compiling the tools under glibc fixed the switchtest issue.
> 

Xenomai 3.x works with uClibc, since is actually the typical Blackfin
configuration which I'm working with.

-- 
Philippe.

