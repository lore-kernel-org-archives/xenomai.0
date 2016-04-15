Date: Fri, 15 Apr 2016 18:44:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160415164451.GA24819@hermes.click-hack.org>
References: <1460646898.874575405@f99.i.mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1460646898.874575405@f99.i.mail.ru>
Subject: Re: [Xenomai] RTNet installation error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?0JDRgNGC0ZHQvCDQm9C+0LHQsNGH?= <smart9113@mail.ru>
Cc: xenomai@xenomai.org

On Thu, Apr 14, 2016 at 06:14:58PM +0300, Артём Лобач wrote:
>  Hi! It's the first time I try to install RTNet for Xenomai-patched kernel. I installed OS with Xenomai from RTXI LiveCD.
> >> # uname -a
> >> Linux A-L2 3.8.13-xenomai-2.6.4-aufs #1 SMP Wed Apr 29 17:19:21 EDT 2015 i686 i686 i686 GNU/Linux
> 
> After "make menuconfig" in rtnet source and applying parameters next error appeared:
> "checking for RT-extension... configure: error: *** RT-extended kernel not found in /lib/modules/3.8.13-xenomai-2.6.4-aufs/source"

Your problem seems to be that RTnet does not find the kernel
sources. The symbolic link
/lib/modules/3.8.13-xenomai-2.6.4-aufs/source does not point to
actual kernel sources. So, you need to also install the patched
kernel sources on the machine where you want to compile RTnet if
that is not already done, then pass the path where you installed the
kernel sources to RTnet configure script --with-linux option.

-- 
					    Gilles.
https://click-hack.org

