Date: Sat, 27 Jun 2015 14:43:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150627124339.GD9756@hermes.click-hack.org>
References: <C31C0BF8-AC9A-442B-8A2F-4576ACF1F817@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C31C0BF8-AC9A-442B-8A2F-4576ACF1F817@gmail.com>
Subject: Re: [Xenomai] Q on xenomai2/3 userland coexistence
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <haberlerm@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On Sat, Jun 27, 2015 at 02:22:09PM +0200, Michael Haberler wrote:
> ATM we're sorting through the machinekit xenomai3 transition on
> debian
> 
> I assume that users will continue to run xenomai2 kernels for a
> long time, so we work towards separate (but hopefully
> coexisting-in-peace) packages for Xenomai2 and Xenomai3 (startup
> is driven by kernel autodetection, so booting a different kernel
> chooses the right runtime)
> 
> The libxenomai-dev and libxenomai1 in debian are all xenomai2 atm,
> but I assume Xenomai3 equivalents will appear eventually

Xenomai 3 has a debian directory allowing to build it as a Debian
package. So, in fact, they are already here.


> 
> I hope these will be able to co-reside on the same host?
> 
> Ideally suggesting the Xenomai3 packages would be separate, be named differently, and not supersede any installed Xenomai2 packages?
> 
> 
> (or am I blundering and I can run applications linked against the Xenomai3 libraries on a Xenomai2 kernel? my tests so far indicate - not)
> 

I was afraid someone was going to ask for that. Experience has
proved that allowing to install silently several versions of Xenomai
is a recipe for trouble. So, relying on Debian allowing to install
only one version of the package was a nice feature.

So, if we agree that having the two versions installed is not
something for the common user, I would suggest people who want to do
that know what they are doing and can install one version as a
Debian package, and the other manually.

On the other hand, if we think having the two versions installed
will be a very common use case, I do not think there is any conflict
with library names, only with tool names, and since we provide the
the "xeno" wrapper to fetch the tools from another place than
/usr/bin, I guess the only conflict would be on the "xeno" wrapper
itself. So, maybe we could call it xeno3 in Xenomai3 Debian package
to avoid any issue? Or use the Debian "alternatives" mechanism
(though this mechanism is probably unknown from the typical ubuntu
user)? 

-- 
					    Gilles.
https://click-hack.org

