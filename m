From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Date: Wed, 30 Nov 2011 12:58:02 +0100
Message-Id: <1322654284-6867-1-git-send-email-wolfgang.mauerer@domain.hid>
Subject: [Adeos-main] [PATCH 0/2] Fasteoi fixes
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: jan.kiszka@domain.hid, adeos-main@gna.org, gernot.hillier@domain.hid

Dear all,

following Jan's considerations, I found that we lack a generic
bug fix for the fasteoi handler in 2.6.38, which is backported
in the first patch. The second patch makes ipipe agree with
threaded one-shot handlers.

Pending adaption to the latest API, this part is also relevant
for the ipipe-3.0-noarch. Philippe, do you agree with the
approach?

Cheers, Wolfgang

--
Siemens AG, Open Source Platforms,
Corporate Competence Centre Embedded Linux


