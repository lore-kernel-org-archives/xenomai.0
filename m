Date: Sat, 11 Oct 2014 00:45:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141010224516.GH30368@sisyphus.hd.free.fr>
References: <CABVE6k3QSb-vCM_-wz0hmZAfYZt5tYqbo1enyxM0ZoUeigDhyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABVE6k3QSb-vCM_-wz0hmZAfYZt5tYqbo1enyxM0ZoUeigDhyw@mail.gmail.com>
Subject: Re: [Xenomai] build to kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hasret =?utf-8?Q?Sar=C4=B1yer?= <hsrtsryr@gmail.com>
Cc: Xenomai <Xenomai@xenomai.org>

On Sat, Oct 11, 2014 at 01:27:05AM +0300, Hasret Sarıyer wrote:
> We tried to install xenomai ubuntu 14.04. We did all step(same xenomai
> version) this guide ->
> http://xenomai.org/2014/06/building-debian-packages/#build_the_kernel.

So, once again you did not read the guide completely. The guide
tells you to install the latest stable version, not the same version
as the guide.

> 
> We are not clear how we should set some value on build kernel. We want to
> set default values because we don't know what we will need on our
> project.When we saw  (N,y,m,?),we clicked N(we thouht that first letter was
> recommended).
> 
> Is this solution a bad way? Can we will change it later?

Xenomai does not change anything to the way the Linux kernel is
configured and compiled. If you need some help on this subject, see:
http://kernelnewbies.org/

It just adds some entry in the configuration menus. Defaults for
configuration options in the Xenomai menu should be fine. For
options in other menus, see:
http://xenomai.org/2014/06/configuring-for-x86-based-dual-kernels/

(Note that this page is linked from the building debian package
page, but in case you miss that too, I remind you about it, reading
it is not optional)

-- 
					    Gilles.

