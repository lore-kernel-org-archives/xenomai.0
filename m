Date: Sat, 27 Jun 2015 15:14:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150627131446.GF9756@hermes.click-hack.org>
References: <C31C0BF8-AC9A-442B-8A2F-4576ACF1F817@gmail.com>
 <558EA07F.2060204@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <558EA07F.2060204@xenomai.org>
Subject: Re: [Xenomai] Q on xenomai2/3 userland coexistence
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

On Sat, Jun 27, 2015 at 03:09:19PM +0200, Philippe Gerum wrote:
> On 06/27/2015 02:22 PM, Michael Haberler wrote:
> > ATM we're sorting through the machinekit xenomai3 transition on debian
> > 
> > I assume that users will continue to run xenomai2 kernels for a long time, so we work towards separate (but hopefully coexisting-in-peace) packages for Xenomai2 and Xenomai3 (startup is driven by kernel autodetection, so booting a different kernel chooses the right runtime)
> > 
> > The libxenomai-dev and libxenomai1 in debian are all xenomai2 atm, but I assume Xenomai3 equivalents will appear eventually
> > 
> > I hope these will be able to co-reside on the same host?
> > 
> > Ideally suggesting the Xenomai3 packages would be separate, be named differently, and not supersede any installed Xenomai2 packages?
> > 
> > 
> > (or am I blundering and I can run applications linked against the Xenomai3 libraries on a Xenomai2 kernel? my tests so far indicate - not)
> > 
> 
> Not possible. Xenomai 2 uses kernel services provided by the I-pipe
> compiled for legacy operation mode. Xenomai 3 wants this mode disabled.

The two kernels have different ABIs anyway. I think what Michael
wants to do is to also have the two patched kernels installed and
reboot (or kexec?) to switch from one to the other.

-- 
					    Gilles.
https://click-hack.org

