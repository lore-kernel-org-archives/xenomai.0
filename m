MIME-Version: 1.0
In-Reply-To: <CAPRPZsCBku_sq49cBorxQXd1_TkZks17dE_iVkA03m=Z6b32EQ@mail.gmail.com>
References: <CAPRPZsBh=5TkR93kiQR8yg0ABfJZtwJ_piBQKAOznEWMppgCyw@mail.gmail.com>
	<5140F24B.7080900@xenomai.org>
	<CAPRPZsDDi_LfwiMdbfZro5h6cU69ONNNvG7XtSDdKE0M3bjwpw@mail.gmail.com>
	<CAPRPZsCBku_sq49cBorxQXd1_TkZks17dE_iVkA03m=Z6b32EQ@mail.gmail.com>
Date: Wed, 13 Mar 2013 23:19:41 +0100
Message-ID: <CAPRPZsBCXx+qjLU18irLuLME3r3QpeMMrUjjbAnqfsZpQS3qrg@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] SMI handling on x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Ok, I managed to get hold of the .config. I only retained those entries
that seemed obviously relevant to ACPI.


# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
# CONFIG_PM_RUNTIME is not set
CONFIG_ACPI=y
# CONFIG_ACPI_PROCFS is not set
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_EC_DEBUGFS=m
# CONFIG_ACPI_PROC_EVENT is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
# CONFIG_ACPI_PROCESSOR is not set
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_APEI is not set
# CONFIG_SFI is not set

CONFIG_HOTPLUG_PCI_ACPI=m
CONFIG_HOTPLUG_PCI_ACPI_IBM=m

CONFIG_PNPACPI=y

CONFIG_ATA_ACPI=y

# CONFIG_PATA_ACPI is not set

# ACPI drivers
#
CONFIG_I2C_SCMI=m

# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_HWMON=y
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y

# CONFIG_THINKPAD_ACPI is not set
CONFIG_ACPI_WMI=m
# CONFIG_ACPI_CMPC is not set


2013/3/13 Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>

> I don't have the .config at hand, but I believe so, yes. I did disable
> processor ACPI though.
>
>
>
>
> 2013/3/13 Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
>
>> I don't have the .config at hand, but I believe so, yes. I did disable
>> processor ACPIm though.
>>
>> Jeroen.
>>
>>
>
