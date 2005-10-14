From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17232.2752.731603.9598@domain.hid>
Date: Fri, 14 Oct 2005 21:45:04 +0200
Subject: Re: [Xenomai-help] Xenomai -> PPC (III): Total Failure
In-Reply-To: <50649.193.52.24.125.1129318390.squirrel@domain.hid>
References: <50649.193.52.24.125.1129318390.squirrel@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: smannori@domain.hid
Cc: xenomai@xenomai.org

smannori@domain.hid wrote:
 > Hi:
 > 
 > result: total failure. I think that could be the x.org X11 driver
 > 
 >     BoardName "ATI Radeon (fglrx)"
 >     Driver "radeon"
 > 
 > that cause so many problems.
 > 
 > Someone could suggest any alternative explanations ?
 > 
 > My every attempt to install Fusion/RTAI or Xenomai on this machine was a
 > disaster. I think that Powerbook and iBook are different beast.

If you do not give us any more precise description of the symptoms you
observe, I am afraid no one wil be able to help you.

As usual; do it step by step :
- try and get an adeos patched kernel running in text only mode on your
  box, with as few options as possible enabled ;
-  try and install Xenomai in text-only mode so that if there is a
   crash, you will at least be able to send us a kernel stack trace. 
- if this work, try running X-windows. Then, if it crashes, you will
  know that it is because of X. In such a case, to get a crash dump,
  enable console on serial port or netconsole. Of course, you will need
  a second box.

Also note that :
- you can not run graphic driver kernel module without recompiling them
  for the adeos patched kernel ;
- you probably do not need open GL support for running Xenomai.

-- 


					    Gilles Chanteperdrix.

