Date: Wed, 7 Nov 2018 08:57:23 -0500
Subject: Re: 32bit on 64bit in xenomai 2.6.0
Message-ID: <20181107135723.yg6qs5gz6xou36hp@csclub.uwaterloo.ca>
References: <CAPNo5QJdOpN8cztKGNZjifmP-Bx4wRyOq0XAw7HM1UQ+Op5E3Q@mail.gmail.com>
 <69c8bfc1-f7d5-b935-6db1-99d496a80dc7@siemens.com>
 <CAPNo5QJ4WHKnajbYB-RF9CqX8ZtF2Mss6FRNubjYECwh_wmUjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPNo5QJ4WHKnajbYB-RF9CqX8ZtF2Mss6FRNubjYECwh_wmUjg@mail.gmail.com>
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Manikanta Mylavarapu <mylavarapumanikanta23@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On Wed, Nov 07, 2018 at 12:36:20PM +0530, Manikanta Mylavarapu via Xenomai wrote:
> Thank you Jan.
> 
> For my project requirement I am working with xenomai 2.6.0 on fedora 13.
> 
> My doubt is at least sample app compiled as a 32bit exe on 64bit kernel
> should work. But it is not running on xenomai patched 64bit os,why?

Is 32 bit support even enabled in the kernel config?
CONFIG_IA32_EMULATION under executable file formats is rather required.

And which kernel are you using, given xenomai 2.6.0 had ipipe patches for
2.6.35 and a few others, but not 2.6.32 that I believe fedora 13 used.

Of course who remembers what things were like 8 years ago.

Other than configuring the kernel wrong I see no reason 32 bit linux
applications shouldn't work on a 64 bit linux kernel, but xenomai apps
have to be 64 bit (unless you move to xenomai 3.x).

-- 
Len Sorensen

