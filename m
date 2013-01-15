Message-ID: <50F509C5.7070300@xenomai.org>
Date: Tue, 15 Jan 2013 08:48:21 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] bool type breaking 2.4 kernels
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>


Hi Jan,

we have a build failure on 2.4 kernels with the changes made in intr.c
for the correct display in /proc, it seems the "bool" type is not
available for these kernels.

http://sisyphus.hd.free.fr/~gilles/bx/lite5200-2.4/2.4.25-DENX-ppc_6xx-gcc-3.3.3/log.html#1

Regards.

-- 
                                                                Gilles.

