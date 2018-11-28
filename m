MIME-Version: 1.0
From: Sakshi Bansal <sakshi.april5@gmail.com>
Date: Wed, 28 Nov 2018 09:35:52 +0100
Message-ID: <CAHqFf+uBw8H+8tEq9-5hQod515gATdhb7nFwVrdSKWdAn2C3Sg@mail.gmail.com>
Subject: Unable to start RTnet
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

Hello,

Xenomai version - 3.0.5
Build-in RTnet kernel module - rt_e1000e
lspci -knn:

* Ethernet Controller [0280] Intel Corporation Device [8086:24fd] (rev 02==78)
* *Subsystem: Lenovo Ethernet Connection (2) I219-LM [17aa:310b]**
 Kernel modules: e1000e*

The rt_e1000e is not listed as a module. I suspect this is the reason why
RTnet won't start. Any ideas on what needs to be done next?
-- 
Thanks and Regards
Sakshi Bansal
