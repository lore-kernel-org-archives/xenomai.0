MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18291.60209.715762.159719@domain.hid>
Date: Thu, 27 Dec 2007 19:13:05 +0100
In-Reply-To: <8b3b30860712271005i3e4f9eb6t4ad35205c0117b9a@domain.hid>
References: <8b3b30860712270704o1a7d0cbahe97a4e90e9455cbc@domain.hid>
	<2ff1a98a0712270815r30b5e19eycf6fb44224d2ea83@domain.hid>
	<8b3b30860712271005i3e4f9eb6t4ad35205c0117b9a@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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

Racconico Lambrati wrote:
 > 2007/12/27, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
 > >
 > > On Dec 27, 2007 4:04 PM, Racconico Lambrati
 > > <racconico.lambrati@domain.hid> wrote:
 > > > Hi.
 > > >
 > > > I've update my system to xenomai 2.4.0 from fusion 0.9.1 using vxworks
 > > skin
 > > >
 > > > I used http://www.captain.at/xenomai-porting-fusion.php to make the
 > > porting
 > > > of my application.
 > > >
 > > > now I have this linker problem:
 > > >
 > > > ... undefined reference to 'printk'
 > > > ... undefined reference to 'intUnlock'
 > > > ... undefined reference to 'intLock'
 > > > ... undefined reference to 'sysClkConnect'
 > > >
 > > > could you give me an hint?
 > >
 > > These functions are only available in kernel-space. The fact that you
 > > must use them probably means that you should split your application:
 > > move the part that require access to low-level functions in a driver
 > > using the rtdm skin.
 > >
 > It could be a chance but for now I want to run my
 > application as I run it under fusion to test that everything
 > is ok.
 > 
 > I see that intLock intUnlock and sysClkConnect are present
 > in vxworks.h, why the linker can't find it?
 > 

As I already told these functions are only available in kernel-space,
they can not be implemented in user-space, they are not present in
the vxworks library so the linker can not find them.

Your only chance is to run your application in kernel-space. But this
will make it harder to debug.

Without seeing the parts of your code requiring these low-level calls,
it is hard to say anything.

-- 


					    Gilles Chanteperdrix.

