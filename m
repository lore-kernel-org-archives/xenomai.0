Subject: Re: Cyclic hardware reset for e1000e
References: <1798013633.4056474.1550493375498.JavaMail.zimbra@wolfram.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f51b37b7-4293-4b29-6d78-3eb460de3015@siemens.com>
Date: Mon, 18 Feb 2019 13:43:07 +0100
MIME-Version: 1.0
In-Reply-To: <1798013633.4056474.1550493375498.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Per Oberg <pero@wolfram.com>, xenomai <xenomai@xenomai.org>

On 18.02.19 13:36, Per Oberg via Xenomai wrote:
> Hello list
> 
> I have this issue where my e1000e network card gets into some kind of cyclic hardware reset during operation. The weird thing is that this only happens when I let systemd start the application. If it's started manually it always works as intended.
> 
> I am running  xenomai 3.0.7 with a linux-4.9.38 kernel and I use the network connection in Linux non-rt mode. I use systemd and NetworkManager.
> 
> I do realize that once I get into the reset it will continue resetting because I keep flooding the buffers. My issue is that it -never- happens when I start my process manually, only when systemd starts it. Because the network goes down quite badly I cannot log in and disable the service once it happens and therefore I cannot really try starting it manually after letting the network recover.
> 
> There is some information from intel in [1] below. There is talk about power management function and EPROM etc. They specifically write:
> 
> "82573(V/L/E) TX Unit Hang Messages
> Several adapters with the 82573 chipset display "TX unit hang" messages during normal operation with the e1000 driver. The issue appears both with TSO enabled and disabled, and is caused by a power management function that is enabled in the EEPROM. Early releases of the chipsets to vendors had the EEPROM bit that enabled the feature. After the issue was discovered newer adapters were released with the feature disabled in the EEPROM."
> 
> 
> I also read something about disabling GRO/TSO/GSO that helped some people.
> 
> My questions to the list are:
> 
> 1. Have you guys any experience with this?
> 2. Would I be better of using the RT Net drivers?
> 3. What could cause the issue to trigger only when run by systemd. (I thought about timing issues and NetworkManager, but how do I debug this?)
> 
> [1] https://serverfault.com/questions/193114/linux-e1000e-intel-networking-driver-problems-galore-where-do-i-start
> 
> Thoughts anyone?

Are you giving Linux enough time to work (no 100% RT domination of any core for 
hundreds of milliseconds or longer)?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

