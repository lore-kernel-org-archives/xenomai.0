Message-ID: <e8770e9868002bd1d629d3598afe26e7.squirrel@sourcetrek.com>
In-Reply-To: <55B0B2EA.8000602@xenomai.org>
References: <55B0B2EA.8000602@xenomai.org>
Date: Thu, 23 Jul 2015 15:57:59 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] rt_print_auto_init()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>


Philippe Gerum wrote:
>
> Hi Jan,
>
> Do you still have a use case for calling rt_print_auto_init(false) or
> not calling rt_print_auto_init(true) from libcobalt's bootstrap code?
>

At some point, I added a pre-allocation of a few buffers which avoided the
need for malloc, and forced the call to rt_print_auto_init(true) in the
POSIX skin library. I do not know whether all this has survived the
Xenomai 3 cleanup though.

-- 
                                            Gilles.
https://click-hack.org


