Message-ID: <2ff1a98a0712270815r30b5e19eycf6fb44224d2ea83@domain.hid>
Date: Thu, 27 Dec 2007 17:15:58 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <8b3b30860712270704o1a7d0cbahe97a4e90e9455cbc@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8b3b30860712270704o1a7d0cbahe97a4e90e9455cbc@domain.hid>
Subject: Re: [Xenomai-help] update from fusion 0.9.1 to xenomai 2.4.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Racconico Lambrati <racconico.lambrati@domain.hid>
Cc: xenomai@xenomai.org

On Dec 27, 2007 4:04 PM, Racconico Lambrati
<racconico.lambrati@domain.hid> wrote:
> Hi.
>
> I've update my system to xenomai 2.4.0 from fusion 0.9.1 using vxworks skin
>
> I used http://www.captain.at/xenomai-porting-fusion.php to make the porting
> of my application.
>
> now I have this linker problem:
>
> ... undefined reference to 'printk'
> ... undefined reference to 'intUnlock'
> ... undefined reference to 'intLock'
> ... undefined reference to 'sysClkConnect'
>
> could you give me an hint?

These functions are only available in kernel-space. The fact that you
must use them probably means that you should split your application:
move the part that require access to low-level functions in a driver
using the rtdm skin.

-- 
                                               Gilles Chanteperdrix

