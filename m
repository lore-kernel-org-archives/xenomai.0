From: "Jason Huang" <jason.huang@domain.hid>
Date: Fri, 4 Mar 2005 13:37:53 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <421D8BDF.5070601@domain.hid>
Message-id: <20050304131648.cc6c9533bf7d449eb5998eb5d884f538.in@domain.hid>
Subject: [Adeos-main] 'Badness in local_bh_enable at kernel/softirq.c:136' on 2.6.8.1 ARM
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos-main@gna.org

Dear list members,

After correcting a lot of my mistakes (in porting ADEOS ARM 2.4 to ARM9
2.6.8.1), I can boot up the Linux. However, I noticed a WARN_ON(irqs_disabled())
in softirq.c. Apparently, local IRQ was disabled unintentionally. This only
occurs once during initial NFS bootup.

Has anyone seen similar problems? What was the cause?

Thanks in advance.

Jason


