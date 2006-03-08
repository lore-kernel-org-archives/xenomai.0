From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17423.8047.793660.826276@domain.hid>
Date: Wed, 8 Mar 2006 19:16:15 +0100
Subject: Re: [Xenomai-core] Error on rtdm skin with --enable-dox-doc
In-Reply-To: <440F15C9.1020509@domain.hid>
References: <200603081421.10284.lbocseg@domain.hid> <440F15C9.1020509@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > Rodrigo Rosenfeld Rosas wrote:
 > > Hi Jan,
 > > 
 > > When compiling svn xenomai I noticed the following error with --enable-dox-doc 
 > > switch:
 > > 
 > > CC [M]  kernel/xenomai/skins/rtdm/drvlib.o
 > > kernel/xenomai/skins/rtdm/drvlib.c:1513:1: error: unterminated #ifdef
 > > 
 > 
 > I just passed this stage with trunk revision 671 without problems
 > (doxygen 1.4.4). Moreover, there is no #ifdef or related preprocessor
 > stuff in the latest drvlib.c at line 1513.

I have a few warnings with doxygen 1.4.2:

ksrc/skins/rtdm/drvlib.c:151: Warning: Member rtdm_task_destroy found in multiple @defgroup groups! The member will be put in group rtdmtask, and not in group rtdmtask

But the --enable-dox-doc flag should not have any influence on kernel
compilation.

-- 


					    Gilles Chanteperdrix.

