Message-ID: <4FACCC46.6050001@domain.hid>
Date: Fri, 11 May 2012 10:22:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANKLDmvnyqTJ-0poJHYWDtsrkrVdwsYGpw0uR3vfvJZg+hDYtQ@mail.gmail.com>
In-Reply-To: <CANKLDmvnyqTJ-0poJHYWDtsrkrVdwsYGpw0uR3vfvJZg+hDYtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Does qemu-kvm impact realtime performance?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On 05/10/2012 04:26 PM, Henri Roosen wrote:
> Hi all,
> 
> Does anyone know if running qemu-kvm impacts the realtime Xenomai
> performance of the host system?
> 
> I have a multicore x86 target that runs a Xenomai enabled kernel and a
> realtime application. Next to the realtime application I would like to
> run qemu-kvm (on one of the cores) that runs some non-realtime guest
> os. So I would like to know if qemu-kvm have impact on the
> latencies/jitter of the realtime threads?

I would say it should have no direct impact, we should not expect kvm to
create hard irqs masking sections. However, as usual, running a whole OS
and applications inside another OS probably has a huge impact on cache,
and so should cause more jitter than running xenomai on an idle system.

-- 
					    Gilles.

