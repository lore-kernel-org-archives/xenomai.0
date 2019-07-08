Subject: Re: use of posix function clock_gettime
References: <trinity-a65a3ea0-cae5-4f13-9fdf-bda26c1616ab-1562590950171@3c-app-webde-bs07>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3f76a1b5-24eb-6efb-d8d2-3de10554c7ed@siemens.com>
Date: Mon, 8 Jul 2019 15:34:15 +0200
MIME-Version: 1.0
In-Reply-To: <trinity-a65a3ea0-cae5-4f13-9fdf-bda26c1616ab-1562590950171@3c-app-webde-bs07>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mario Molitor <Mario_Molitor@web.de>, xenomai@xenomai.org

On 08.07.19 15:02, Mario Molitor via Xenomai wrote:
> Hello  Xenomai-Community,
> 
> we are seeming to have a migration problem by our internal synchronization kernel-module.
> 
> The module try to get timestamp of Host-Real-Time-Clock in Real-Time IRQ context.
> In the old version of XENOMAI (2.6.5) it was possible to use XENOMAI POSIX function directly (clock_gettime(CLOCK_HOST_REALTIME,tp)) in the kernel module.
> 
> But with XENOMAI version 3.0.7 is this not possible and I haven't found any good workaround in the moment.
> 
> We use Xenomai in combination with kernel 4.14.71.
> 
> Every hint or suggestion are welcome.

First of all, all in-kernel APIs have been deprecated and removed in favor of
RTDM driver APIs. However, RTDM does not expose this clock directly. You can
only do rtdm_clock_read (realtime) or rtdm_clock_read_monotonic().

We could add a host_realtime API to RTDM if there is a good use case. And that
would include a reason why the timestamp adjustment (monotonic -> host-realtime)
cannot be done in the userspace application that consumes the driver data.

Also note that CLOCK_HOST_REALTIME is broken for releases prior to
ipipe-core-4.14.132-x86-6.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

