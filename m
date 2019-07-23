From: alessio margan <alessio.margan@iit.it>
Subject: prepare-kernel.sh
Message-ID: <0817b60a-3a5c-3cae-475d-ce78dd89ef10@iit.it>
Date: Tue, 23 Jul 2019 14:37:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

I got this error when trying to configure the kernel 4.19.57 with the 
procedure that I used so far.

Is there something new that I miss

(base) embedded@com-exp:/usr/local/src/xenomai.git(stable/v3.0.x)$ 
./scripts/bootstrap

libtoolize: putting auxiliary files in AC_CONFIG_AUX_DIR, 'config'.
libtoolize: copying file 'config/ltmain.sh'
libtoolize: putting macros in AC_CONFIG_MACRO_DIRS, 'config'.
libtoolize: copying file 'config/libtool.m4'
libtoolize: copying file 'config/ltoptions.m4'
libtoolize: copying file 'config/ltsugar.m4'
libtoolize: copying file 'config/ltversion.m4'
libtoolize: copying file 'config/lt~obsolete.m4'
configure.ac:80: installing 'config/compile'
configure.ac:105: installing 'config/missing'
demo/alchemy/Makefile.am: installing 'config/depcomp'
(base) embedded@com-exp:/usr/local/src/xenomai.git(next)$ 
./scripts/prepare-kernel.sh --linux=/usr/src/linux-4.19.57-xeno-3.0.9 
--ipipe=../ipipe-core-4.19.57-x86-3.patch --arch=x86_64
(base) embedded@com-exp:/usr/local/src/xenomai.git(next)$


(base) embedded@com-exp:/usr/src/linux-4.19.57-xeno-3.0.9$ make menuconfig
   HOSTCC  scripts/basic/fixdep
   UPD     scripts/kconfig/.mconf-cfg
   HOSTCC  scripts/kconfig/mconf.o
   YACC    scripts/kconfig/zconf.tab.c
   LEX     scripts/kconfig/zconf.lex.c
   HOSTCC  scripts/kconfig/zconf.tab.o
   HOSTCC  scripts/kconfig/lxdialog/checklist.o
   HOSTCC  scripts/kconfig/lxdialog/inputbox.o
   HOSTCC  scripts/kconfig/lxdialog/menubox.o
   HOSTCC  scripts/kconfig/lxdialog/textbox.o
   HOSTCC  scripts/kconfig/lxdialog/util.o
   HOSTCC  scripts/kconfig/lxdialog/yesno.o
   HOSTLD  scripts/kconfig/mconf
scripts/kconfig/mconf  Kconfig
init/Kconfig:2056: can't open file "arch/$SRCARCH/xenomai/Kconfig"
make[1]: *** [scripts/kconfig/Makefile:29: menuconfig] Error 1
make: *** [Makefile:532: menuconfig] Error 2


TIA

Alessio


-- 

ISTITUTO ITALIANO DI TECNOLOGIA

Alessio Margan
Chief Technician
Advanced Robotics Department

alessio.margan@iit.it
Via Morego 30, 16163 Genova
Tel. +39 010 71781-754

www.iit.it

Legal Disclaimer
This electronic message contains information that is confidential. The information is intended for the use of the addressee only.
If you are not the addressee we would appreciate your notification in this respect.
Please note that any disclosure, copy, distribution or use of the contents of this message is prohibited and may be unlawful.
We have taken every reasonable precaution to ensure that any kind of attachment to this e-mail has been swept for viruses.
However, we cannot accept liability for any damage sustained as a result of software viruses
and would advise you to carry out your own virus checks before opening any attachment.
Avvertenza legale
Questo messaggio Email contiene informazioni confidenziali riservate ai soli destinatari.
Qualora  veniate in possesso di tali informazioni senza essere definito come destinatario vi reghiamo di leggere le seguenti note.
Ogni apertura, copia, distribuzione del contenuto del messaggio e dei suoi allegati è proibito e potrebbe violare le presenti leggi.
Abbiamo attivato ogni possibile e ragionevole precauzione per assicurare che gli allegati non contengano virus.
Comunque non assumeremo alcuna responsabilità per ogni eventuale danno causato da virus software e simili
in quanto è onere del destinatario verificarne l’assenza in ogni allegato attuando propri indipendenti controlli.


