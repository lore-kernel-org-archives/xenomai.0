From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 21 May 2015 17:01:28 -0400
Message-ID: <20150521210128.GW6169@csclub.uwaterloo.ca>
References: <20150521221811.1cc69dcd@crunchbang>
 <20150521204856.GV6169@csclub.uwaterloo.ca>
 <20150521225351.712910c6@crunchbang>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150521225351.712910c6@crunchbang>
Subject: Re: [Xenomai] Raspberry Pi + Xenomai doesn't compile
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marc =?utf-8?B?TWFyw60=?= <5.markmb.5@gmail.com>
Cc: xenomai@xenomai.org

On Thu, May 21, 2015 at 10:53:51PM +0200, Marc Marí wrote:
> Enabled by default:
> 
> $ grep -r IPIPE .config
> CONFIG_IPIPE_WANT_ACTIVE_MM=y
> CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH=y
> CONFIG_IPIPE_ARM_KUSER_TSC=y
> CONFIG_IPIPE=y
> CONFIG_IPIPE_LEGACY=y
> CONFIG_IPIPE_CORE=y
> CONFIG_IPIPE_CORE_APIREV=2
> CONFIG_IPIPE_WANT_APIREV_2=y
> CONFIG_IPIPE_TARGET_APIREV=2
> CONFIG_IPIPE_HAVE_HOSTRT=y
> CONFIG_IPIPE_DELAYED_ATOMICSW=y
> # CONFIG_IPIPE_DEBUG is not set
> 
> $ grep -r XENOMAI .config
> CONFIG_XENOMAI=y

Well that was the most obvious problem I have encountered with things
not compiling.  No idea then.

I stopped touching 3.8 a long time about because it was way too unstable
on the cpu we are using (caused random segfaults frequently).  Didn't seem
to be a problem with 3.8 in general, just for this particular chip.

-- 
Len Sorensen

