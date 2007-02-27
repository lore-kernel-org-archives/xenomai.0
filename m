Message-ID: <45E44415.9000707@domain.hid>
Date: Tue, 27 Feb 2007 15:45:41 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <45E4401F.3050904@domain.hid>
In-Reply-To: <45E4401F.3050904@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [CAN] SIOC* clash
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi Wolfgang,
> 
> just realised that there is an ABI mine laid in rtcan.h:
> 
> #ifndef SIOCGIFINDEX
> #define SIOCGIFINDEX \
>             _IOWR(RTIOC_TYPE_CAN, 0x00, struct ifreq)
> #endif
> 
> So, if you happen to have included sys/ioctl.h earlier in your
> application, an incompatible IOCTL code will be used in user space.
> 
> I recommend to switch to existing IOCTL codes where available (that's
> what we do in RTnet as well). This may also mean betting on the current
> IOCTL assignments in Socket-CAN, that they will survive unchanged the
> eventual merge into Linux mainline.

D'accord, I will change this with the next update.

Wolfgang.


