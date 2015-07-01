MIME-Version: 1.0
Date: Wed, 1 Jul 2015 11:02:56 +0200
Message-ID: <CAL5YyVbm6rHu0QFyfMZbrVdDAeHmJrtrggbsAyERdC5HhaeQng@mail.gmail.com>
From: ACO31 <alain.cordat@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Kernel compilation problem x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I want to compile the RC5 of Xenomai 3  for X86 arch
I use ipipe core 3.16.7-5  accorded to linux kernel 3.16.7 from kernel.org.
(I've do the same compile for the RC4 without problem)
no error message for prepare-kernel.sh.
No problem with kernel make menuconfig.
But the compile stop with error message about apc.h:
cobalt/kernel/apc.h no such file or dir
#include <cocobalt/kernel/apc.h>
...
I re lauch teh compil wit same kernel archive and rc4 to valide archives
and process:
No error message...
Thanks
alain


-- 
Cordialement.

A.Cordat
Port: 06 04 04 17 69
