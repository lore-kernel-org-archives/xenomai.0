Message-ID: <4FBA2876.8050207@siemens.com>
Date: Mon, 21 May 2012 08:35:18 -0300
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <CANKLDmvnyqTJ-0poJHYWDtsrkrVdwsYGpw0uR3vfvJZg+hDYtQ@mail.gmail.com>
	<4FACCC46.6050001@xenomai.org>
In-Reply-To: <4FACCC46.6050001@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Does qemu-kvm impact realtime performance?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 2012-05-11 05:22, Gilles Chanteperdrix wrote:
> On 05/10/2012 04:26 PM, Henri Roosen wrote:
>> Hi all,
>>
>> Does anyone know if running qemu-kvm impacts the realtime Xenomai
>> performance of the host system?
>>
>> I have a multicore x86 target that runs a Xenomai enabled kernel and a
>> realtime application. Next to the realtime application I would like to
>> run qemu-kvm (on one of the cores) that runs some non-realtime guest
>> os. So I would like to know if qemu-kvm have impact on the
>> latencies/jitter of the realtime threads?
> 
> I would say it should have no direct impact, we should not expect kvm to
> create hard irqs masking sections. However, as usual, running a whole OS
> and applications inside another OS probably has a huge impact on cache,
> and so should cause more jitter than running xenomai on an idle system.

On a modern VT-x or AMD-V system, the impact is not different from
running some cache hungry application on the host besides a Xenomai
load. Recent processors can track which cache entry belongs to which
memory mapping and optimize the eviction regarding this. But if your RT
frequency is sufficiently low and you share the caches, you will still
see impact - with or without virtualization.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

