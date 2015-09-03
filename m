From: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Message-ID: <55E7E7ED.5060405@sigmatek.at>
Date: Thu, 3 Sep 2015 08:25:49 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] Activating PCI express on imx6 board
Reply-To: wolfgang.netbal@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I activated PCI express for my imx6 board.
To get PCI express up and running I have to activate the kernel option 
CONFIG_CPU_FREQ
here my configuration
#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_INTERACTIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_GOV_INTERACTIVE is not set
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
# CONFIG_GENERIC_CPUFREQ_CPU0 is not set

I think the frequency scaling can change the timing for xenomai and 
checked the .config file
where I found the following message.


#
# WARNING! You enabled APM, CPU Frequency scaling, ACPI 'processor'
#

#
# or Intel cpuidle option. These options are known to cause troubles
#

#
# with Xenomai, disable them.
#


Do you have any idea how to activate PCI express support when using xenomai.

Kind regards

-- 
Wolfgang Netbal
Softwareentwicklung
________________________________

SIGMATEK GmbH & Co KG
Sigmatekstraße 1
5112 Lamprechtshausen
Österreich / Austria

Tel.: +43/6274/4321-0
Fax: +43/6274/4321-300
E-Mail: wolfgang.netbal@sigmatek.at
http://www.sigmatek-automation.at

****************************Please note: ****************************
This email and all attachments are confidential and intended solely
for the person or entity to whom it is addressed. If you are not the
named addressee you must not make this email and all attachments
accessible to any other person. If you have received this email in
error please delete it together with all attachments.
*********************************************************************
