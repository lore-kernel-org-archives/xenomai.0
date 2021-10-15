MIME-Version: 1.0
From: Jabba Oks <jabaoks@gmail.com>
Date: Fri, 15 Oct 2021 17:50:42 +0300
Message-ID: <CADUiVjZcCR52jbotxfw7cTRQ+0uw6ahAaS_BaNG7-WdzbsCNEQ@mail.gmail.com>
Subject: wl18xx module hangs on imx6q with Linux 4.19.33 + Xenomai 3.1
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi !
I'm trying to start WiFi wl18xx module on arm/iMX6Q Linux 4.19.33 + Xenomai
3.1 as follows:
# modprobe wl18xx
# modprobe wlcore_sdio
# wpa_supplicant -i wlan0 -c/etc/wpa_supplicant.conf -Dnl80211

It hangs the Kernel with "wlcore: WARNING ELP wakeup timeout!"
At the same time, the same Kernel configuration and Device Tree works Ok on
the same Linux 4.19.33 but without Xenomai patch. Has anyone faced similar
issue? What can be done to overcome this ?
Thank you in advance
Alexander
