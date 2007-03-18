From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Message-ID: <17917.26174.329158.46341@domain.hid>
Date: Sun, 18 Mar 2007 17:18:06 +0100
Subject: Re: [Adeos-main] [PATCH - ARM] ldrex/strex syntax errors with recent
	compilers
In-Reply-To: <1173967023.16299.53.camel@domain.hid>
References: <1173966835.16299.49.camel@domain.hid>
	<1173967023.16299.53.camel@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Stelian Pop <stelian@domain.hid>
Cc: adeos-main@gna.org

Stelian Pop wrote:
 > Le jeudi 15 mars 2007 ~ 14:53 +0100, Stelian Pop a ~crit :
 > 
 > [on xenomai-core ml]
 > > Hi,
 > > 
 > > Trying to build a xenomai-enabled kernel using a recent compiler (tried
 > > with gcc version 4.1.1 (CodeSourcery ARM Sourcery G++ 2006q3-26), but
 > > all gcc > 4.1 might be affected) results in the following:
 > > 
 > >   CC      kernel/xenomai/nucleus/shadow.o
 > > /tmp/cc0XooxH.s: Assembler messages:
 > > /tmp/cc0XooxH.s:1464: Error: instruction does not accept this addressing mode -- `ldrex r1,r2'
 > > /tmp/cc0XooxH.s:1466: Error: instruction does not accept this addressing mode -- `strex r3,r1,r2'
 > > 
 > > Older gcc (like gcc version 4.0.0 (DENX ELDK 4.1 4.0.0)) have no problem with this.
 > > 
 > > It appears that the patch below fixes the compile error. I also verified 
 > > that gcc-4.0.0 generates identical code using both forms.
 > 
 > The same issue is present in the mainline kernel too. I'll report this
 > on LKML but meanwhile the patch below could be included in the Adeos
 > patch as well...

Applied all your patches. Thanks.

-- 


					    Gilles Chanteperdrix.

