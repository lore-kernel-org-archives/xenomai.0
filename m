Subject: Re: [PATCH 09/10] dovetail/clock: implement pipeline_timer_name to
 get name of real device
References: <20210111064318.6154-1-hongzhan.chen@intel.com>
 <20210111064318.6154-9-hongzhan.chen@intel.com>
 <5FFCF963.7000407@tj.kylinos.cn>
 <MWHPR11MB1710D0CE4E5F4994BE9A8EB3F2AA0@MWHPR11MB1710.namprd11.prod.outlook.com>
From: chensong <chensong@tj.kylinos.cn>
Message-ID: <5FFCFE53.3050801@tj.kylinos.cn>+04E87F13AA7AA16C
Date: Tue, 12 Jan 2021 09:41:39 +0800
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1710D0CE4E5F4994BE9A8EB3F2AA0@MWHPR11MB1710.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>



On 2021年01月12日 09:35, Chen, Hongzhan wrote:
>  >
>
>  >
>
>  >-----Original Message-----
>
>  >From: chensong <chensong@tj.kylinos.cn>
>
>  >Sent: Tuesday, January 12, 2021 9:21 AM
>
>  >To: Chen, Hongzhan <hongzhan.chen@intel.com>; Xenomai@xenomai.org
>
>  >Subject: Re: [PATCH 09/10] dovetail/clock: implement
> pipeline_timer_name to get name of real device
>
>  >
>
>  >
>
>  >
>
>  >On 2021?01?11? 14:43, hongzha1 via Xenomai wrote:
>
>  >> Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
>
>  >> ---
>
>  >>   include/cobalt/kernel/dovetail/pipeline/clock.h | 5 ++---
>
>  >>   kernel/cobalt/dovetail/tick.c                   | 8 ++++++++
>
>  >>   2 files changed, 10 insertions(+), 3 deletions(-)
>
>  >>
>
>  >> diff --git a/include/cobalt/kernel/dovetail/pipeline/clock.h
> b/include/cobalt/kernel/dovetail/pipeline/clock.h
>
>  >> index ce9a5c867..771104ab4 100644
>
>  >> --- a/include/cobalt/kernel/dovetail/pipeline/clock.h
>
>  >> +++ b/include/cobalt/kernel/dovetail/pipeline/clock.h
>
>  >> @@ -12,6 +12,7 @@
>
>  >>   struct timespec64;
>
>  >>
>
>  >>   extern inline void xnproxy_timer_set(unsigned long delta);
>
>  >> +inline const char *xn_get_timer_name(void);
>
>  >>
>
>  >>   static inline u64 pipeline_read_cycle_counter(void)
>
>  >>   {
>
>  >> @@ -37,9 +38,7 @@ static inline const char *pipeline_timer_name(void)
>
>  >>           * Return the name of the current clock event chip, which is
>
>  >>           * the real device controlled by the proxy tick device.
>
>  >>           */
>
>  >> -        TODO();
>
>  >> -
>
>  >> -        return "?";
>
>  >> +       return xn_get_timer_name();
>
>  >>   }
>
>  >>
>
>  >
>
>  >PATCH 02/10, PATCH 08/10 and this one, all of them have the changes for
>
>  >pipeline_read_cycle_counter in
>
>  >include/cobalt/kernel/dovetail/pipeline/clock.h, and they look
>
>  >different, how so? or they are incremental implementation,but PATCH
>
>  >02/10 returns ktime_get_raw_fast_ns() and PATCH 09/10 returns
>
>  >xn_get_timer_name();.
>
>  >
>
> Patch 02/10 really modify pipeline_read_cycle_counte but 08/10 actually
> modify
>
> pipeline_set_timer_shot and this one modify pipeline_timer_name. The
> patch format
>
> created by git send-email is really not friendly to read, I also
>
> made such mistake before.

it's really confusing,anyway,clear to me,many thanks.

song
>
> Regards
>
> Hongzhan Chen
>
>  >>   static inline const char *pipeline_clock_name(void)
>
>  >> diff --git a/kernel/cobalt/dovetail/tick.c
> b/kernel/cobalt/dovetail/tick.c
>
>  >> index 58662e94e..e40ec06cb 100644
>
>  >> --- a/kernel/cobalt/dovetail/tick.c
>
>  >> +++ b/kernel/cobalt/dovetail/tick.c
>
>  >> @@ -16,6 +16,14 @@ extern struct xnintr nktimer;
>
>  >>
>
>  >>   static DEFINE_PER_CPU(struct clock_proxy_device *, proxy_device);
>
>  >>
>
>  >> +inline const char *xn_get_timer_name(void)
>
>  >> +{
>
>  >> +       struct clock_proxy_device *dev = __this_cpu_read(proxy_device);
>
>  >> +       struct clock_event_device *real_dev = dev->real_device;
>
>  >> +
>
>  >> +       return real_dev->name;
>
>  >> +}
>
>  >> +
>
>  >>   inline void xnproxy_timer_set(unsigned long delta)
>
>  >>   {
>
>  >>          struct clock_proxy_device *dev = __this_cpu_read(proxy_device);
>
>  >>
>



