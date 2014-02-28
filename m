Message-ID: <53107B01.2000103@control.lth.se>
Date: Fri, 28 Feb 2014 13:03:13 +0100
From: Anders Blomdell <anders.blomdell@control.lth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Xenomai-3 and native RTDM question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

With Xenomai-3, will it be possible to use the native RTDM an a vanilla kernel, or
only on PREEMPT_RT kernels? The reason that I ask, is that I need to upgrade the
software in our labs (vanilla kernels, mostly) and would like to get comedi 
(www.comedi.org) to work with RTDM (so I get all the drivers from comedi,
the analogy double effort seems like a bad idea to me).

In the best of worlds, native RTDM could be pushed into the kernel staging area 
where comedi currently lives, and perhaps make the RTAI part of comedi easier
to support.

/Anders


-- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden


