Message-ID: <50A39708.5060000@wanadoo.fr>
Date: Wed, 14 Nov 2012 14:05:12 +0100
From: Thierry Bultel <thierry.bultel@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] minor build issue with linux-rel_imx_3.0.15_12.03.00 +
 adeos-ipipe-3.0.36-arm-1.18-11.patch using imx6_defconfig
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Following latest README;

Manually applied :

adeos-ipipe-3.0.36-arm-1.18-11-pre.patch
adeos-ipipe-3.0.36-arm-1.18-11.patch
adeos-ipipe-3.0.36-arm-1.18-11-post.patch

and using imx6_defconfig

the build fails at:

drivers/misc/mxs-perfmon.c: In function 'perfmon_show':
drivers/misc/mxs-perfmon.c:174: error: too few arguments to function
'mxs_reset_block'
drivers/misc/mxs-perfmon.c: In function 'perfmon_store':
drivers/misc/mxs-perfmon.c:237: error: too few arguments to function
'mxs_reset_block'

It is the only and single issue, adding 'false' as 2nd arg is fine (for
building, not tested at runtime yet).

Cheers
Thierry

