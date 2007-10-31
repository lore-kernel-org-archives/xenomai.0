MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18216.54223.558805.510728@domain.hid>
Date: Wed, 31 Oct 2007 20:13:19 +0100
In-Reply-To: <25dd9bf10710311139k35626c86n569cca9fe3a40d5a@domain.hid>
References: <25dd9bf10710311139k35626c86n569cca9fe3a40d5a@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Adeos-main] Adoes on EPC9302, ARM,Cirrus Logic
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Subramani Venkatesh <subbu31mani@domain.hid>
Cc: adeos-main@gna.org

Subramani Venkatesh wrote:
 > Hi,
 > I just completed ADEOS porting on EPC9302, Circus Logic Board, I could
 > successfully register Xenomai domain and could run periodic timer with
 > 100uS.
 > I request someone to suggest me the test applications that I am suppose to
 > use for successfull release to open source.

Good news. What version of the adeos patch ?

You can run the xeno-test script during a long period of time. Use
calibrator (*) with ping flood for load generation, and launch xeno-test
with a -T parameter longer than the default 120 s.

(*) calibrator: http://www.cwi.nl/~manegold/Calibrator

You can also send us the patch for review, there are always small
details that need to be fixed before an inclusion in the adeos patch.

-- 


					    Gilles Chanteperdrix.

