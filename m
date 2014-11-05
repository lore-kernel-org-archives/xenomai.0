Message-ID: <545A8AD7.1060300@free.fr>
Date: Wed, 05 Nov 2014 21:38:47 +0100
From: Thierry Bultel <tbultel@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] IMX kernel 3.0.35_4.1.0 + adeos-ipipe-3.0.43-mx6q-1.18-14
 -> very slow boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, "jean-Baptiste, TREDEZ (GE Healthcare,
 non-ge)" <Jean-baptiste.tredez@basystemes.fr>

Hi,
I have applied the adeos-ipipe-3.0.43-mx6q-1.18-14.patch provided with
xenomai-2.6.4 ,
onto the rel_imx_3.0.35_4.1.0 kernel

When CONFIG_IPIPE is enabled, the kernel is very slow to boot. Once it
is booted, it seems all right.
It boots fast when CONFIG_IPIPE is disabled

I have CONFIG_CPU_FREQ disabled.

It hangs for about 45 seconds after the
"console [tty0] enabled, bootconsole disabled" message

It is very slow to shutdown, too.

Where I can look to find the issue please ?

Best regards
Thierry


