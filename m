Message-ID: <000301c59e1b$17845020$6101a8c0@domain.hid>
From: "Terry" <terryac4@domain.hid>
Date: Wed, 10 Aug 2005 21:19:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Re: SMP for ppc64
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

I see the problem with booting the second processor - this is done by 
temporarily replacing the reset vector with the
pmac_secondary_start addresses ( a different one for each cpu) and the 
triggering the reset.  I guess since adeos
virtualized all the irq's, the hardcoded replacement of the reset vector 
isn't having the desired effect.  I'll see if I can
work through how to accomplish this when I get back to work next week.

Later,

Terry 



