Message-ID: <4F062D33.3060606@domain.hid>
Date: Thu, 05 Jan 2012 23:07:31 +0000
From: Jakub Nowacki <j.s.nowacki@domain.hid>
MIME-Version: 1.0
References: <000301cccaed$80667540$81335fc0$@soterem.fr>	<4F046865.9000408@domain.hid>
	<000001cccafd$1c6046b0$5520d410$@soterem.fr>
	<4F049054.4000302@domain.hid>
In-Reply-To: <4F049054.4000302@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] unresolved symbol - check the
	xenomai	installation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On 04/01/12 17:45, Gilles Chanteperdrix wrote:
>
> This looks bad. Please re-run latency with no argument. If should
> normally produce a report about min/average/max latency every second. If
> it does not, I would recommend restarting the installation from scratch:
> - first uninstalling any installed version, running "make uninstall" in
> the build directory, this for xenomai 2.4.4 and 2.6.0.
> - re-run prepare-kernel, recompile the kernel, leaving the xenomai
> configuration options to their default value.
>
I have a similar problem trying to install xenomai 2.6.0. In my case 
latency works correctly, but trying to compile examples gives me the 
same 'unresolved reference' error. I noticed this first trying to 
compile RTXI, which also gives me

/usr/xenomai/lib/libnative.so: undefined reference to `xeno_current'
/usr/xenomai/lib/libnative.so: undefined reference to `xeno_sem_heap'
/usr/xenomai/lib/libnative.so: undefined reference to 
`xeno_sigshadow_install_once'
/usr/xenomai/lib/libnative.so: undefined reference to `xeno_set_current'
/usr/xenomai/lib/libnative.so: undefined reference to `xeno_map_heap'
/usr/xenomai/lib/libnative.so: undefined reference to `xnarch_tsc_to_ns'
/usr/xenomai/lib/libnative.so: undefined reference to 
`xeno_handle_mlock_alert'
/usr/xenomai/lib/libnative.so: undefined reference to `xeno_fault_stack'
/usr/xenomai/lib/libnative.so: undefined reference to 
`xeno_set_current_mode'
/usr/xenomai/lib/libnative.so: undefined reference to `xeno_bind_skin_opt'
/usr/xenomai/lib/libnative.so: undefined reference to `xeno_current_mode'
/usr/xenomai/lib/libnative.so: undefined reference to `xnarch_ns_to_tsc'

I did it before with Xenomai 2.5.6 and did not recall such a linking 
problems. I read before that it might be causes by cross-compilation 
being messed up, but in that case I do default compilation on linux 
2.6.38.8. I did not try 2.5.6 again to check if the problem remains for 
2.5.6, I can try to do that.

Best wishes,

Jakub

