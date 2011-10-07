Message-ID: <4E8F1643.1050700@domain.hid>
Date: Fri, 07 Oct 2011 17:09:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CACFV95JranppM+ZDoqsgjO5nJ-Th2fFAD0HowBSkL-t_wQ-t4w@domain.hid>
In-Reply-To: <CACFV95JranppM+ZDoqsgjO5nJ-Th2fFAD0HowBSkL-t_wQ-t4w@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai: /dev/rtheap is missing (chardev,
 major=10 minor=254) in mini2440
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Siva kumar Balasubramanian <sivakumar.bs@domain.hid>
Cc: xenomai@xenomai.org

On 10/07/2011 04:52 PM, Siva kumar Balasubramanian wrote:
> Hi Experts,
> 
> I compiled and ported linux kernel-2.6.37.6, adeos-ipipe-patch-2.6.37.6 and
> xenomai 2.5.6 in mini2440.
> After porting when i run xeno-test,

What do you mean "porting"? If mini2440 is based on s3c2440, it should 
work out of the box. If it does not, please send patches.

You have probably missed the following message when running "make 
install":

*** Warning: you are not super-user and sudo does not work, real-time devices
*** nodes will not be created.
*** If you do not create these devices by hand, Xenomai test programs will not
*** work.
*** To create these devices please run "make devices" with super-user
*** privileges.

Which, I believe, is self-explanatory.

-- 
					    Gilles.

