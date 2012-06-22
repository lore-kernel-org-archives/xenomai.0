Message-ID: <4FE41E45.1070406@xenomai.org>
Date: Fri, 22 Jun 2012 09:27:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHyVJyz4B9Z1nCLEg3G9u-r5d5iHdGwiA78w_enRc--MuVrgMQ@mail.gmail.com>
In-Reply-To: <CAHyVJyz4B9Z1nCLEg3G9u-r5d5iHdGwiA78w_enRc--MuVrgMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai RT user application- POSIX interface
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mohit Jandwani <mohitjandwani@gmail.com>
Cc: xenomai@xenomai.org

On 06/22/2012 03:57 AM, Mohit Jandwani wrote:
> Hello I am trying to develop a real time Ethercat master on xenomai on an
> exynos board.While I am still stuck with installing xenomai(and plan to
> give it all next week), I have run into some problems which I  have not
> been able to find on the website anywhere.
> 
> I am trying to use the posix skin of xenomai(as I need the stdio functions
> and socket functions) simply because of portability and the fact that I
> don't have to install it(I can build it while building the kernel).What I
> want to ask is:

Whatever skin you use, you have to enable it in xenomai kernel
configuration, and you have to install xenomai user-space support by
running "make DESTDIR=/some/dir", which installs headers and libraries
for all skins. Then you can start building applications using this skin
by getting flags with xeno-config. So, the posix skin is not different
from any other skin.

-- 
                                                                Gilles.

