From: Michael Neuhauser <mike@domain.hid>
Content-Type: text/plain
Message-Id: <1101819584.22250.19.camel@domain.hid>
Mime-Version: 1.0
Date: Tue, 30 Nov 2004 13:59:44 +0100
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Adeos CVS return missing in adeos_test_and_unstall_pipeline?
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
To: adeos-main@gna.org

Hello all!

I'm working currently on porting Adeos on (over/under?) Linux 2.4.21 to
the ARM9 CPU EP9301. While doing so I've noticed that the function

	unsigned long adeos_test_and_unstall_pipeline()

in file v2.4/adeos-core/include/linux/adeos of Adeos' CVS has no return
statement (v2.6 is OK).

Kind regards,
	Mike
-- 
Dr. Michael Neuhauser                phone: +43 1 789 08 49 - 30
Firmix Software GmbH                   fax: +43 1 789 08 49 - 55
Vienna/Austria/Europe                      email: mike@domain.hid
Embedded Linux Development and Services    http://www.firmix.at/


