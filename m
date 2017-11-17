MIME-Version: 1.0
In-Reply-To: <CABXF_AAQEVopEfK22jQ94n92Zy+ath_ngaHcXHV=yJN+=xiU6A@mail.gmail.com>
References: <CABXF_AChZTYyWqvJcLhfz6y1Z+Er-FDuKTtf=f-eJb+XGa6=RQ@mail.gmail.com>
 <CABXF_AAQEVopEfK22jQ94n92Zy+ath_ngaHcXHV=yJN+=xiU6A@mail.gmail.com>
From: Ivid Suvarna <ivid.suvarna@gmail.com>
Date: Sat, 18 Nov 2017 00:11:24 +0530
Message-ID: <CABXF_AAx2d+Hrn6YiTeXRQVyCgjzC9MkK6uzK+Qszgdqzkuj+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Xenomai patch on Hikey causing overheating and board reset
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi All,

I am facing overheating issue on my hikey 620 after applying xenomai-3
arm64 patches. It goes to 100 degree celsius in just under 5 mins. I
first assumed it might be ipipe patch that is causing problems but I
did git bisect and found that xenomai patch is creating problem.

I am using 4.9 kernel and ipipe-4.9.51 patch.
I am using stepwise governor.

ivid@ivid:~# cat /sys/class/thermal/thermal_zone0/policy
step_wise

My config is as below:

 CONFIG_THERMAL=y
 CONFIG_THERMAL_HWMON=y
 CONFIG_THERMAL_OF=y
 # CONFIG_THERMAL_WRITABLE_TRIPS is not set
 CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
 # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
 # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
 # CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
 # CONFIG_THERMAL_GOV_FAIR_SHARE is not set
 CONFIG_THERMAL_GOV_STEP_WISE=y
 # CONFIG_THERMAL_GOV_BANG_BANG is not set
 # CONFIG_THERMAL_GOV_USER_SPACE is not set
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 # CONFIG_CLOCK_THERMAL is not set
 CONFIG_THERMAL_EMULATION=y
 CONFIG_HISI_THERMAL=y
 # CONFIG_HI3660_THERMAL is not set
 # CONFIG_MAX77620_THERMAL is not set
 # CONFIG_QORIQ_THERMAL is not set
 # CONFIG_ROCKCHIP_THERMAL is not set
 # CONFIG_RCAR_THERMAL is not set
 # CONFIG_ARMADA_THERMAL is not set
 CONFIG_MTK_THERMAL=y
 CONFIG_EXYNOS_THERMAL=y
 # CONFIG_GENERIC_ADC_THERMAL is not set
 CONFIG_ACPI_THERMAL=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT=y
 CONFIG_CPU_FREQ_STAT_DETAILS=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
 # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
 # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
 # CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
 # CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
 # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
 CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
 # CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
 # CONFIG_CPU_FREQ_GOV_USERSPACE is not set
 # CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
 # CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
 # CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

I also tried "power_allocator" but heating issue still exists. Since
xenomai recommends CPU_FREQ to be disabled, I disabled it but to no
use

Any pointers on debugging this issue would be helpful

Thanks,
Ivid
