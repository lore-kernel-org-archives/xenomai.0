From: "Zheng, Qi" <qi.zheng@intel.com>
Date: Wed, 4 Jul 2018 07:27:08 +0000
Message-ID: <0DD381DBF8F68D419C32ACFCEB28EB2553AEB8B7@SHSMSX101.ccr.corp.intel.com>
References: <0DD381DBF8F68D419C32ACFCEB28EB2553ADA8AD@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: <0DD381DBF8F68D419C32ACFCEB28EB2553ADA8AD@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] How to locate the max latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "'xenomai@xenomai.org'" <xenomai@xenomai.org>

BTW, I already disabled the i915 power saving by adding "i915.enable_dc=3D0=
 i915.enable_rc6=3D0 i915.enable_execlists=3D0 i915.disable_power_well=3D0"=
 in  the cmdline.

Best Regards

SSG->OTC->One Linux Platform Engineering Team (Shanghai)

From: Zheng, Qi
Sent: Tuesday, July 3, 2018 5:00 PM
To: xenomai@xenomai.org
Subject: How to locate the max latency

I am using xenomai 3.0.5 (https://xenomai.org/downloads/xenomai/stable/xeno=
mai-3.0.5.tar.bz2) on the Intel SKL platform.
On console mode or accessed by vnc viewer (no i915 graphics interrupt), the=
 max latency values are usually below 20us no matter low or high loading (b=
y stress-ng).
But the max latency can reach up to 40us on GUI (gnome)  mode (dozens of i9=
15 interrupt counts per second).
I tried enabling the ipipe trace function, but couldn't find valuable infor=
mation.
Is there any other good ways to locate the max latency?
Or does anybody have experience on reducing the latency caused by graphics =
(such as i915) ?
Many thanks.


Best Regards

SSG->OTC->One Linux Platform Engineering Team (Shanghai)

