Message-ID: <9f7421b4e96ca7d5e6ce77ffe8fc34f6.squirrel@sourcetrek.com>
In-Reply-To: <55A4BA1C.9080306@siemens.com>
References: <CO1PR01MB256AC4CE16186B5C49AEABD949B0@CO1PR01MB256.prod.exchangelabs.com>
 <55A4BA1C.9080306@siemens.com>
Date: Tue, 14 Jul 2015 09:36:29 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] xenomai latency test hangs due to kernel paging
 request
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Gowtham Garimella <ggarime1@jhu.edu>, "xenomai@xenomai.org" <xenomai@xenomai.org>


Jan Kiszka wrote:
> What this tells us, though, is that userspace is likely out of sync /wrt
> to the kernel used here. Please check if both installations actually
> match.

How is that? The kernel ABI is versioned and the version is checked at
startup, so, I believe the user and kernel can not be "out of sync".

Can not the name pointer passed to rt_task_create simply be invalid?

-- 
                                            Gilles.
https://click-hack.org


