From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17359.28959.489093.312753@domain.hid>
Date: Thu, 19 Jan 2006 11:59:43 +0100
Subject: Re: [Xenomai-core] RTAI vs XENOMAI
In-Reply-To: <353F6272FE0A6544AA97D47F761F486B01707E7C@ples506a.stcl.siemens.co.uk>
References: <353F6272FE0A6544AA97D47F761F486B01707E7C@ples506a.stcl.siemens.co.uk>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Doyle, Alan (Siemens)" <alan.doyle@domain.hid>
Cc: xenomai@xenomai.org

Doyle, Alan \(Siemens\) wrote:
 > Hi,
 > 
 > I'm looking into porting an embedded application using Accelerated
 > Technologies 'Nucleus' RTOS to a real time Linux variant. RTAI is the
 > preferred approach but on looking into available documentation I have
 > discovered Xenomai which seems to be designed to solve this sort of
 > problem. However as there is no existing emulator for Nucleus on Xenomai
 > I would have to write one so I'm unsure whether there would then be any
 > benefit. Could somebody advise me as to the pros and cons of porting to
 > RTAI or Xenomai.

Using Xenomai would ease writing a skin for the nucleus RTOS. Philippe
once wrote a mail on how to write a new skin, which you will find on
rtai.dk: 

http://rtai.dk/cgi-bin/gratiswiki.pl?How_To_Implement_A_New_Skin

The reasons why the Xenomai project, was made a separate project from
RTAI is explained in the following post on RTAI mailing list :

https://mail.rtai.org/pipermail/rtai/2005-October/013155.html

-- 


					    Gilles Chanteperdrix.

