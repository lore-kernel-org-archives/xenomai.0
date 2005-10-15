From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17232.61282.895708.114223@domain.hid>
Date: Sat, 15 Oct 2005 14:00:34 +0200
Subject: Re: [Xenomai-help] XenoPPC : 
In-Reply-To: <58010.193.52.24.125.1129376818.squirrel@domain.hid>
References: <58010.193.52.24.125.1129376818.squirrel@domain.hid>
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
 > If you have any suggestion regarding the testing... I'm ready :)

Yes: could you try compiling a vanilla (non adeos patched) kernel
without Altivec support, and tell us if it works :
1- without X running
2- with X running

If this works: try compiling an Adeos patched kernel without Altivec
support, and tell us if the kernel works without Xenomai :
3- without X running
4- with X running

If this still works, compile Xenomai for that new kernel, and tell us if
the klatency test works
5- without X running
6- with X running.

If this still works, tell us if the latency test works:
7- without X running
8- with X running

9- Back in the best mode for which Xenomai works without X support,
could you try obtaining a latency figure of Xenomai in text mode 
while running the dohell script ?

10- In the same configuration as 9, could you try inserting and mounting
a DvD and tell us if it has an impact on latency ?

TIA.

-- 


					    Gilles Chanteperdrix.

