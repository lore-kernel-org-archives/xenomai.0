Message-ID: <40C03A5E.7030006@domain.hid>
Date: Fri, 04 Jun 2004 11:01:18 +0200
From: Wolfgang Grandegger <wolfgang.grandegger@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] adeos_tune_timer()
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos-main <adeos-main@gna.org>

Hello,

the function adeos_tune_timer() allows to change the tick frequency of
the hardware timer. I wonder if Linux is aware of this change? Doesn't
it still believe that the timer interrupt comes at a rate of 100 Hz?

Wolfgang.

